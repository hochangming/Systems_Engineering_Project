/*****************************************************************************
 @Project	: 
 @File 		: UltraSound.c
 @Details  	: Ultrasonic driver               
 @Author	: 
 @Hardware	: 
 
 --------------------------------------------------------------------------
 @Revision	:
  Ver  	Author    	Date        	Changes
 --------------------------------------------------------------------------
   1.0  Name     XXXX-XX-XX  		Initial Release
   
******************************************************************************/

#include <Common.h>
#include "Hal.h"
#include "BSP.h"
#include "IRQ.h"
#include "Timer.h"
#include "Pwm.h"
#include "motors.h"
#include "Encoder.h"
#include "PID.h"
#include "gui.h"
#include "UltraSound.h"

/*****************************************************************************
 Define
******************************************************************************/
#define US_ECHO_TIMEOUT			180U	/* ms, for 300cm->17.46ms, */ /* Changed to 180 */
#define TOTAL_USONIC			8U
#define US_DEFAULT_DIST_MAX		20000U 

#define US_TIMER_FREQ_MIN		10000U	/* 10KHz */


/*****************************************************************************
 Type definition
******************************************************************************/


/*****************************************************************************
 Global Variables
******************************************************************************/


/*****************************************************************************
 Local Variables
******************************************************************************/

static TIMER_HOOK               g_TimerHook;
static PUSONIC_HANDLE           g_pusonicIrqHandles[TOTAL_USONIC]; /* these handle pointers are used in ISR */
static double                   g_dTimerUsConst = 0;	/* Timer period in us */
static int                      g_nTriggerConst = 0;	/* trigger timeout at least 10us */


/*****************************************************************************
 Local functions
******************************************************************************/
static void sonic_cbOnTimer( void );


/*****************************************************************************
 Implementation
******************************************************************************/
int USonicInit(PTIMER_HANDLE pTimer,int nTimerFreq)
{
	int cnt;
	
	ASSERT( 0 != pTimer );
	ASSERT( 0 != nTimerFreq );

	/* Timer run too slow. insufficient to use */
	if( nTimerFreq < US_TIMER_FREQ_MIN )
	{
		/* Return error code */
		return USONIC_TIMER_FREQ_INVALID;
	}
	
	/* Reset handles to 0 */
	for( cnt=0; cnt<TOTAL_USONIC; cnt++ )
	{
		g_pusonicIrqHandles[cnt] = 0;
	}

        /* timer period in us. Time per tick */
	g_dTimerUsConst = 1000000.0 / nTimerFreq; 

	if( g_dTimerUsConst > 10.0 )
	{
		/* It is fine for trigger time more than 10us that required */
		g_nTriggerConst = 1;
	}
	else
	{
		/* If timer run faster to 10us, we need to scale back using incremental delay */
		g_nTriggerConst = 10 / g_dTimerUsConst;
	}
	
	/* Add a timer callback */
	TimerAddHook(pTimer, &g_TimerHook, sonic_cbOnTimer);
}


int 
UsonicAddDevice(PUSONIC_HANDLE pHandle, uint8_t nIndex, USONIC_CB_ON_TRIGGER *pfOnTrigger, USONIC_CBI_READY *pfOnReady)
{
	ASSERT( 0 != pHandle );
	ASSERT( 0 != pfOnTrigger );
	ASSERT( 0 != pfOnReady );

    /* To check if the number sensor is more than the sensor count */   
    if (nIndex > TOTAL_USONIC) 
    {
        return USONIC_INVALID;
    }
    
    /* To check if the given usonic index is in use */
    if (0 != g_pusonicIrqHandles[nIndex]) 
    {
        return USONIC_INUSE;
    }

    /* Setting default values for new usonic added */
    pHandle->nDistance = 0;
    pHandle->nTimeout = 0;
    pHandle->nTimerTick = 0;
    pHandle->nTrigger = 0;
    pHandle->bValidEdge = FALSE; 
    pHandle->pfOnTrigger = pfOnTrigger;
    pHandle->pfOnReady = pfOnReady;
    pHandle->nTimeoutConst = US_ECHO_TIMEOUT;
    pHandle->nDistanceMax = US_DEFAULT_DIST_MAX;
    g_pusonicIrqHandles[nIndex] = pHandle; 
	
    return USONIC_SUCCESS;
}


void USonicTrigger( PUSONIC_HANDLE pHandle )
{
	ASSERT( 0 != pHandle );
	
/********************************************************
* To do: ...
********************************************************/
      pHandle->nTimeout = 0;
      pHandle->nTimerTick = 0;
      pHandle->nTrigger = 1; 
      pHandle->bValidEdge = FALSE;
      pHandle->pfOnTrigger (TRUE);
 
}


void USonicSetEchoTimeOut(PUSONIC_HANDLE pHandle,int nTimeoutMs,int nDistMax)
{
	ASSERT( 0 != pHandle );
	
/********************************************************
* To do: ...
********************************************************/

        pHandle->nTimeoutConst = nTimeoutMs;
        pHandle->nDistanceMax = nDistMax;
}

uint32_t USonicRead( PUSONIC_HANDLE pHandle )
{
	ASSERT( 0 != pHandle );
        /* Returns the distaance */ 
	return pHandle->nDistance;   
}

void UsonicISR( PUSONIC_HANDLE 	pHandle, BOOL bEcho )
{
	uint32_t tmp;
	
	ASSERT( 0 != pHandle );

	if( bEcho != 0 )
	{
		pHandle->nTimerTick = 0;
		pHandle->bValidEdge = TRUE;
		return;
	}
	
	if( pHandle->bValidEdge != 0 )
	{
		pHandle->bValidEdge = FALSE;
                pHandle->nTimeout = 0;
			
		/* If counter is 0, use previous value. This is sensor error */
		if( 0 != pHandle->nTimerTick )
		{
/********************************************************
* To do: ...
********************************************************/
                  /* I changed the formula slightly */
                  tmp = (uint32_t)((((double)pHandle->nTimerTick * 50.0) / 29.0)*100); 
                  if ( tmp > 200)
                  {
                    pHandle->nDistance = tmp;
                  }
                   pHandle->pfOnReady();
                }
	}
}

/*****************************************************************************
 Callback functions
******************************************************************************/
static void sonic_cbOnTimer( void )
{
  	int             cnt = 0;
    PUSONIC_HANDLE	sensor;

  /********************************************************
  * To do: ...
  ********************************************************/
   /* changed from while loop to for loop */
    for(int cnt = 0; cnt < TOTAL_USONIC; cnt++) 
   {
        if (g_pusonicIrqHandles[cnt] == 0) 
        {
            continue;
        }

   // ASSERT( 0 != g_pusonicIrqHandles[cnt] );
      
    /* Free running timer to increase nTimerTick */
    g_pusonicIrqHandles[cnt]->nTimerTick++;
	  
    /* Check if trigger flag is set */
    if(g_pusonicIrqHandles[cnt]->nTrigger != 0) // added 0 != 
    {
     /* Reset Trigger flag*/
     g_pusonicIrqHandles[cnt]->nTrigger--;
         
     if(g_pusonicIrqHandles[cnt]->nTrigger == 0)
     {
      /* Set Trigger to not measure the distance*/
        g_pusonicIrqHandles[cnt]->pfOnTrigger( FALSE ); 
        g_pusonicIrqHandles[cnt]->nTimeout = US_ECHO_TIMEOUT;
     }
    }

    if( g_pusonicIrqHandles[cnt]->nTimeout != 0 )
    {
     g_pusonicIrqHandles[cnt]->nTimeout--;
     
     if( 0 == g_pusonicIrqHandles[cnt]->nTimeout )
     {
      g_pusonicIrqHandles[cnt]->nDistance = -1;
      g_pusonicIrqHandles[cnt]->nTimerTick = 0;
      g_pusonicIrqHandles[cnt]->bValidEdge = FALSE;
      g_pusonicIrqHandles[cnt]->pfOnReady();
     }
    }
   }
}

/*****************************************************************************
 Local functions
******************************************************************************/


/*****************************************************************************
 Interrupt functions
******************************************************************************/





















































