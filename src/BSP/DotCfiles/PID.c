/*****************************************************************************
 @Project	: 
 @File 		: PID.h
 @Details  	:              
 @Author	: lcgan
 @Hardware	: 
 
 --------------------------------------------------------------------------
 @Revision	:
  Ver  	Author    	Date        	Changes
 --------------------------------------------------------------------------
   1.0  lcgan     Oct 2016  		Initial Release
   2.0  lcgan     27 Jul 2018		Update PWM enable to allow duty cycle in double
									to increase resolution
   
******************************************************************************/

#include <Common.h>
#include "PWM.h"
#include "PID.h"
/*****************************************************************************
 Define
******************************************************************************/


/*****************************************************************************
 Type definition
******************************************************************************/


/*****************************************************************************
 Macro
******************************************************************************/


/******************************************************************************
 Global functions
******************************************************************************/


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
void 
PIDCtrlInit(
	PPID_HANDLE pHandle,
	PPWM_HANDLE pPwmHandle,
	uint32_t 	nChannel,
	double		dDutyCyclePercent,
	uint32_t 	nInterval,
	BOOL		bInverse ){

    pHandle->pPwmHandle = pPwmHandle;
    pHandle->nChannel = nChannel;
    pHandle->dDutyCyclePercent = dDutyCyclePercent;
    pHandle->nInterval = nInterval;
    pHandle->bInverse = bInverse;

    pHandle->nTargetValue = 0;
    pHandle->dStopRate = 0.0;
    pHandle->dKp = 0.0;
    pHandle->dKi = 0.0;
    pHandle->dKd = 0.0;
    pHandle->dErrP = 0.0;
    pHandle->dPrevErrP1 = 0.0;
    pHandle->dPrevErrP2 = 0.0;
    pHandle->nPrevOutput = 0.0;
    pHandle->nMin = 0;
    pHandle->nMax = 0;
    pHandle->dFactor = 0.0;
    pHandle->dPWM = 0.0;

    pHandle->pPwmHandle->pTimer = pPwmHandle->pTimer;
    pHandle->pPwmHandle->bInverse = pPwmHandle->bInverse;
    pHandle->pPwmHandle->ReloadCounter = pPwmHandle->ReloadCounter;
    


    
    }


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
void PIDRestart( PPID_HANDLE pHandle, BOOL bInverse ){
    pHandle->dErrP = 0.0;
    pHandle->dPrevErrP1 = 0.0;
    pHandle->dPrevErrP2 = 0.0;
     pHandle->nPrevOutput = 0.0;
    pHandle->bInverse = bInverse;
}


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
void PIDCtrlSetTargetValue( PPID_HANDLE pHandle, int32_t nValue ){

    pHandle->nTargetValue = nValue;

}


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
void PIDCtrlOutputConfig(
			PPID_HANDLE pHandle,
			int32_t 	nMin,
			int32_t		nMax,
			double		dFactor ){

            pHandle->nMax = nMax;
            pHandle->nMin = nMin;
            pHandle->dFactor = dFactor;

            }


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
PID_STS PIDOnTimer( PPID_HANDLE pHandle, int nFeedbackValue ){
    

    ASSERT(pHandle != 0);
    double CurrOut=0 ;

    if( 0 == pHandle->nTargetValue )
    {
           pHandle->dPWM = pHandle->dPWM * 0.7;
           PWMEnable(pHandle->pPwmHandle,
              pHandle->nChannel,
              pHandle->dPWM,
              pHandle->bInverse);  

           return PID_STS_OK;
    }

    if (pHandle->dKp <= 0)
    {
        return PID_ERR_INVALID_KP;
    }
    pHandle->dErrP = pHandle->nTargetValue - nFeedbackValue;

    float l_kp=0,l_ki=0,l_kd=0;

    l_kp=pHandle->dKp * (pHandle->dErrP - pHandle->dPrevErrP1);
    l_ki=pHandle->dKi * ((pHandle->dErrP + pHandle->dPrevErrP1) / 2.0 );
    l_kd=pHandle->dKd * ((pHandle->dErrP - (2.0*pHandle->dPrevErrP1)) + pHandle->dPrevErrP2);

    CurrOut = pHandle->nPrevOutput + l_kp + l_ki + l_kd ;
    pHandle->nPrevOutput = CurrOut; /// was changed

    //CurrOut =(CurrOut * pHandle->dFactor);

   // CurrOut = MIN( CurrOut, pHandle->nMax );
   // CurrOut = MAX( CurrOut, pHandle->nMin );

    pHandle->dPWM = CurrOut* pHandle->dFactor;
    pHandle->dPWM = MIN( pHandle->dPWM, pHandle->nMax );
    pHandle->dPWM = MAX( pHandle->dPWM, pHandle->nMin );

    pHandle->nPrevOutput = CurrOut;
    pHandle->dPrevErrP2 = pHandle->dPrevErrP1;
    pHandle->dPrevErrP1 = pHandle->dErrP;
     PWMEnable(pHandle->pPwmHandle,
              pHandle->nChannel,
              pHandle->dPWM,
              pHandle->bInverse);
  
    return PID_STS_OK;  
}

int readpwm(PPID_HANDLE pHandle){
        return pHandle->dPWM;
        }

/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
void PIDCtrlSetParam(
		PPID_HANDLE pHandle,
		double 		Kp,
		double 		Ki,
		double 		Kd ){
        ASSERT(pHandle != 0);
        pHandle->dKp = Kp;
        pHandle->dKi = Ki;
        pHandle->dKd = Kd;

        }


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
void PIDCtrlSetDecreaseRateAtSpeed0( PPID_HANDLE pHandle, int nDecPercent ){
    ASSERT(pHandle != 0);
    pHandle->dStopRate = nDecPercent;
}

















