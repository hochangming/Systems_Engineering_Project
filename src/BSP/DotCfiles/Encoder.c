/*****************************************************************************
 @Project   : 
 @File      : main.c
 @Details   : Main entry               
 @Author    : 
 @Hardware  : 
 
 --------------------------------------------------------------------------
 @Revision  :
  Ver    Author      Date          Changes
 --------------------------------------------------------------------------

   
******************************************************************************/
#include <Common.h>
#include "Hal.h"
#include "Timer.h"
#include "Encoder.h"


/*****************************************************************************
 Define
******************************************************************************/


/*****************************************************************************
 Type definition
******************************************************************************/


/*****************************************************************************
 Global Variables
******************************************************************************/


/*****************************************************************************
 Local Variables
******************************************************************************/
static TIMER_HOOK         g_TimerHook;
static TIMER_HANDLE       *g_pTimerHandle  = 0;
static int                g_TimerHz;
static volatile int       g_nInterval      = 0;
static int                g_nIntervalConst = 0;
static ENC_CB_READY       *g_pfcbEncReady  = 0;
static double             g_RpmConst       = 0.0;

static PSHAFT_ENC_HANDLE  g_pHeadHandle    = 0;

static int                g_CPR            = 0;
static int                g_GearRatio      = 0;


/*****************************************************************************
 Callback functions prototypes
******************************************************************************/
static void enc_cbOnTimer( void );


/*****************************************************************************
 Local functions prototypes
******************************************************************************/


/*****************************************************************************
 Implementation
******************************************************************************/
void
ShaftEncoderInit(
  PTIMER_HANDLE  pTimerHandle,
  uint32_t       nTimerHz,
  ENC_CB_READY   *pfcbEncReady,
  uint32_t       nIntervalMs
  )
{
  ASSERT( 0 != pTimerHandle );

  /********************************************************
  * To do: 
  ********************************************************/
  g_pTimerHandle = pTimerHandle;
  g_TimerHz = nTimerHz;
  g_nInterval = nIntervalMs/1000.0*nTimerHz;  
  g_nIntervalConst = g_nInterval;
  g_pfcbEncReady = pfcbEncReady;
  TimerAddHook(pTimerHandle, &g_TimerHook,enc_cbOnTimer);
}


void
ShaftEncoderCfg(
  uint32_t    nCPR,
  uint32_t    nGearRatio,
  uint32_t    nIntervalMs
  )
{
  /********************************************************
  * To do: update g_CPR, g_GearRatio and g_RpmConst
  ********************************************************/
  g_CPR = nCPR;
  g_GearRatio = nGearRatio;
  g_RpmConst = ((1000.0 / nIntervalMs) *60 / g_CPR) / g_GearRatio;
}


void ShaftEncoderChangeInterval( uint32_t nIntervalMs )
{
 /* Output RPM = ((Pulses Recieved in 1 sec * 60) / PPR) / Gear Ratio
  PPR = 2*CPR = 2*48 (Pololu motor is 48CPR) x2 because using both encoder A&B
  Gear Ratio is 47:1 */
  
    TimerStop( g_pTimerHandle );

  /********************************************************
  * To do: update g_RpmConst, g_nIntervalConst and g_nInterval
  ********************************************************/
  g_nInterval = nIntervalMs/1000.0*g_TimerHz;  
  g_nIntervalConst = g_nInterval; 
  g_RpmConst = (((1000.0 / nIntervalMs) *60) / g_CPR) / g_GearRatio;

  TimerStart( g_pTimerHandle );
}


BOOL
ShaftEncoderAdd(
  PSHAFT_ENC_HANDLE  pHandle,
  int                nIndex,
  ENC_CB_THRES       *pfcbEncThresHit
  )
{
  ASSERT( 0 != pHandle );

  /* Reset variable to default 0 */
  memset( pHandle, 0, sizeof(SHAFT_ENC_HANDLE) );
  
  /********************************************************
  * To do: 
  ********************************************************/

  g_pHeadHandle -> nIndex = nIndex;
  g_pHeadHandle -> pfThresHit = pfcbEncThresHit;
  pHandle->pNext = g_pHeadHandle;
  g_pHeadHandle = pHandle;
  
  return TRUE;
}


void ShaftEncoderReset( PSHAFT_ENC_HANDLE pHandle )
{
  ASSERT( 0 != pHandle );

  /********************************************************
  * To do: 
  ********************************************************/
  pHandle->nFinalCnt =0;
  pHandle->nTmpCnt = 0;
}


BOOL ShaftEncoderLinkCCM( PSHAFT_ENC_HANDLE pHandle, void *pCcmHandle )
{
  ASSERT( 0 != pHandle );
  ASSERT( 0 != pCcmHandle );

  pHandle->pCcm = pCcmHandle;

  return TRUE;
}


void ShaftEncoderSetThresCount( PSHAFT_ENC_HANDLE pHandle,int nCount )
{
  ASSERT( 0 != pHandle );
  
  pHandle->nThresCnt = nCount;
}


int ShaftEncoderReadCount( PSHAFT_ENC_HANDLE pHandle )
{
  return pHandle->nFinalCnt;
}


int ShaftEncoderReadRPM( PSHAFT_ENC_HANDLE pHandle )
{
  int rpm = (int)(pHandle->nFinalCnt);
  return rpm;
}


int ShaftEncoderCountToRpm( int nCount )
{
  int rpm = (int)(nCount*g_RpmConst);
  return rpm;
}


int ShaftEncoderRpmToCount( int nRpm )
{
  /********************************************************
  * To do: return count based on nRpm and g_RpmConst
  ********************************************************/
  int count = (double)(nRpm / g_RpmConst);
  return count;
}

/******************************************************************************
 @Description : ISR implementation for all encoders' signal rising/falling edge
                interrupt.
                A counter (pHandle's nTmpCnt) should be maintained.

 @param       : pHandle       - Handle for a encoder's resource struct
                bInputEncBSts - Decide whether nTmpCnt is creased by 1, or 
                                decreased by 1, depending on the motor's direction. 
 
 @return      : .
 
 @revision    : 1.0.0
 
******************************************************************************/
void ShaftEncoderISR( PSHAFT_ENC_HANDLE pHandle, BOOL bInputEncBSts )
{

  /********************************************************
  * To do: maintain nTmpCnt counter
  ********************************************************/
 if(0 == pHandle->pCcm)
     {
        (0 != bInputEncBSts) ? pHandle->nTmpCnt++ : pHandle->nTmpCnt--;
          
           if(0 != pHandle->nThresCnt)
           {
              pHandle->nThresCnt--;
                
                if(0 == pHandle->nThresCnt)
                {
                    if(0 != pHandle->pfThresHit)
                    {
                      pHandle->pfThresHit(0);
                    }
                }
           }
     }
}


/*****************************************************************************
 Callback functions 
******************************************************************************/
static void enc_cbOnTimer( void )
{
  PSHAFT_ENC_HANDLE cur;


  /********************************************************
  * To do: record the encoder counter to a encoder handler's
  * nFinalCnt element, and clear the encoder counter so that 
  * it can count for another round.
  ********************************************************/
   if(0 != g_nInterval)
    {
        g_nInterval--;

        if(0 == g_nInterval)
        {
          g_nInterval = g_nIntervalConst; 

              for(cur = g_pHeadHandle; cur != 0; cur = cur->pNext)
              {
                  if(0 != cur->pCcm)
                  {
                       #if 0
                       cur->nFinalCnt = cur->nTmpCnt;                /* for encoder interupt */    
                       cur->nTmpCnt = 0;
                       #endif
                       cur->nFinalCnt = CCMReadCountAutoReset(cur->pCcm);
                  }
                  

              }
                      if(0 != g_pfcbEncReady)
                      {
                        g_pfcbEncReady();
                      }
        }
      }

}


/*****************************************************************************
 Local functions 
******************************************************************************/


/*****************************************************************************
 Interrupt
******************************************************************************/








