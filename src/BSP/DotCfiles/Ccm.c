/*****************************************************************************
 @Project	: SEP150 - Capsule
 @File 		: Ccm.h
 @Details  	: Ccm
 @Author	: lcgan
 @Hardware	: 
 
 --------------------------------------------------------------------------
 @Revision	:
  Ver  	Author    	Date        	Changes
 --------------------------------------------------------------------------
   1.0  Name     XXXX-XX-XX  		Initial Release

******************************************************************************/

#include <Common.h>
#include "Ccm.h"
#include "Timer.h"
/*****************************************************************************
 Define
******************************************************************************/
#define CCxS_Input_A 0x01U
#define CCxS_Input_B 0x01U
#define SMS_ENC_MODE_A 0x01U
#define SMS_ENC_MODE_B 0x02U
#define SMS_ENC_MODE_AB 0x03U
#define SMS_EXT_CLCK_MODE1              0x07
#define TS_FILTERED_TIM_IN1             0x05

/*****************************************************************************
 Typedef 
******************************************************************************/


/*****************************************************************************
 @Description 	: Initialize PWM with a full cycle of intended frequency
 
 @Param			: nFrequency - Requirend frequency in Hertz

 @Requirement	: The function does not take care Pin intialization. User shall
				  responsible to configure the pin as PWM. 
				  
 @Revision		:
******************************************************************************/
int CCMInit(
	PCCM_HANDLE	pHandle,
	uint8_t 	nTimer ){
    ASSERT(pHandle != 0);
    ASSERT(nTimer != 0);

    TIM_TypeDef *timer;
    uint32_t    clock = 0U;

    /*select Timer*/
    switch(nTimer)
    {
        case 1:
             timer = TIM1;
        break;

        case 2:
             timer = TIM2;
        break;

        case 3:
             timer = TIM3; 
        break;

        case 4:
             timer = TIM4;
        break;

        case 5:
             timer = TIM5;
        break;

        case 6:
             timer = TIM6;
        break;

        case 7:
             timer = TIM7; 
        break;

        case 8:
             timer = TIM8;
        break;

        case 9:
             timer = TIM8;
        break;

        default:
            return CCM_ERR_TIM_INVALID;
    }
    
    /* check if timer has been used */
    if( ( (timer->CR1 & TIM_CR1_CEN)) != 0 || ((timer->CR1 & TIM_CR1_ARPE) != 0) )
    {
        return CCM_ERR_TIM_USED;
    }
    
    /*store timer into handle */
    pHandle->pTimer = timer;

     /*set up timer */
    timer->CR1 &= ~( TIM_CR1_DIR |  /* UP counter */
                     TIM_CR1_OPM |  /* one pulse mode, counter is not stopped at update event */
                     TIM_CR1_CMS |  /* Edge Aligned mode for Up Counter */
                     TIM_CR1_CKD ); /* no clock division */
    
    /* find clock speed based on timer */
    switch( RCC->CFGR & RCC_CFGR_PPRE1)
    {
        case RCC_CFGR_PPRE1_DIV1:
             clock = SystemCoreClock;
        break;
         case RCC_CFGR_PPRE1_DIV2:
             clock = SystemCoreClock >> 1U;
        break;
        case RCC_CFGR_PPRE1_DIV4:
             clock = SystemCoreClock >> 2U;
        break;
        case RCC_CFGR_PPRE1_DIV8:
             clock = SystemCoreClock >> 3U;
        break;                            
        case RCC_CFGR_PPRE1_DIV16:
             clock = SystemCoreClock >> 4U;
        break;   
    }

    pHandle->nClock = clock;

    return CCM_OK;
    }


/*****************************************************************************
 @Description 	: 
 
 @Param			: 
				  
 
 @Revision		:
******************************************************************************/
int CCMEncoderMode( PCCM_HANDLE pHandle, CCM_ENC_INPUT Input ){
    
    ASSERT(pHandle != 0);
    TIM_TypeDef *timer = (TIM_TypeDef *)pHandle->pTimer;

    switch(Input)
    {
        case CCM_ENC_INPUT_A:
              timer->SMCR &= ~(TIM_SMCR_SMS | TIM_SMCR_TS); 
              timer->CCMR1 &= ~(TIM_CCMR1_CC1S | TIM_CCMR1_CC2S); 
              timer->CCMR1 |= ( CCxS_Input_A << TIM_CCMR1_CC1S_Pos); 
              timer->CCMR1 &= ~(TIM_CCMR1_IC1PSC | TIM_CCMR1_IC2PSC);
              timer->CCMR1 &= ~(TIM_CCMR1_IC1F  | TIM_CCMR1_IC2F); 
              timer->SMCR |=  ( SMS_ENC_MODE_A << TIM_SMCR_SMS_Pos);
              timer->CR1  |= TIM_CR1_CEN;
        break;

        case CCM_ENC_INPUT_B:
              timer->SMCR &= ~(TIM_SMCR_SMS | TIM_SMCR_TS); 
              timer->CCMR1 &= ~(TIM_CCMR1_CC1S | TIM_CCMR1_CC2S);
              timer->CCMR1 |= ( CCxS_Input_B << TIM_CCMR1_CC2S_Pos); 
              timer->CCMR1 &= ~(TIM_CCMR1_IC1PSC | TIM_CCMR1_IC2PSC); 
              timer->CCMR1 &= ~(TIM_CCMR1_IC1F  | TIM_CCMR1_IC2F); 
              timer->SMCR |=  ( SMS_ENC_MODE_B << TIM_SMCR_SMS_Pos); 
              timer->CR1  |= TIM_CR1_CEN;
        break;
        case CCM_ENC_INPUT_AB:

              timer->SMCR &= ~(TIM_SMCR_SMS | TIM_SMCR_TS);
              timer->CCMR1 &= ~(TIM_CCMR1_CC1S | TIM_CCMR1_CC2S); 
              timer->CCMR1 |= ( CCxS_Input_A << TIM_CCMR1_CC1S_Pos); 
              timer->CCMR1 |= ( CCxS_Input_B << TIM_CCMR1_CC2S_Pos); 
              timer->CCMR1 &= ~(TIM_CCMR1_IC1PSC | TIM_CCMR1_IC2PSC); 
              timer->CCMR1 &= ~(TIM_CCMR1_IC1F  | TIM_CCMR1_IC2F);
              timer->SMCR |=  ( SMS_ENC_MODE_AB << TIM_SMCR_SMS_Pos); 
              timer->CR1  |= TIM_CR1_CEN;
        break;

        default:
            return CCM_ERR_INPUT;
    }
    return CCM_OK;
    }


/*****************************************************************************
 @Description 	: 
 
 @Param			: 
				  
 
 @Revision		:
******************************************************************************/
int CCMInputMode( PCCM_HANDLE pHandle ){
        TIM_TypeDef *timer = (TIM_TypeDef *)pHandle->pTimer;

        ASSERT( 0 != pHandle );

        timer->SMCR &= ~(TIM_SMCR_SMS | TIM_SMCR_TS );

        timer->SMCR |= (SMS_EXT_CLCK_MODE1 << TIM_SMCR_SMS_Pos) |
                        (TS_FILTERED_TIM_IN1 << TIM_SMCR_TS_Pos);

        timer->CCMR1 &= ~(TIM_CCMR1_CC1S | TIM_CCMR1_CC2S);
        timer->CCMR1 |= (CCxS_Input_A << TIM_CCMR1_CC1S_Pos);

        timer->CR1 |= TIM_CR1_CEN;

        return CCM_OK;
        }


/*****************************************************************************
 @Description 	: 
 
 @Param			: 
				  
 
 @Revision		:
******************************************************************************/
int16_t CCMReadCount( PCCM_HANDLE pHandle ){        
        ASSERT( 0 != pHandle);
        int16_t count = 0;
        TIM_TypeDef *timer = (TIM_TypeDef *)pHandle->pTimer;
        timer->CR1 &= ~TIM_CR1_CEN;
        count = timer->CNT;
        timer->CR1 |= TIM_CR1_CEN;
        return count;
        }

int16_t CCMReadCountAutoReset( PCCM_HANDLE pHandle ){
        ASSERT(pHandle != 0);
        int16_t count;
        TIM_TypeDef *timer = (TIM_TypeDef *)pHandle->pTimer;
        timer->CR1 &= ~TIM_CR1_CEN;
        count = timer->CNT;
        timer->CNT = 0;
        timer->CR1 |= TIM_CR1_CEN;
        return count;
        }

void CCMResetCount( PCCM_HANDLE pHandle ){
        ASSERT( 0 != pHandle);
        TIM_TypeDef *timer = (TIM_TypeDef *)pHandle->pTimer;
        timer->CR1 &= ~TIM_CR1_CEN;
        timer->CNT = 0;
        timer->CR1 |= TIM_CR1_CEN;
}


/*****************************************************************************
 @Description 	: 
 
 @Param			: 
				  
 
 @Revision		:
******************************************************************************/
void CCMEnable( PCCM_HANDLE	pHandle, uint32_t	nChannel ){
        ASSERT( 0 != pHandle);
        TIM_TypeDef *timer = (TIM_TypeDef *)pHandle->pTimer;
        timer->CR1 &= ~TIM_CR1_CEN;
        timer->CNT = 0;
        timer->CR1 |= TIM_CR1_CEN;
        }


/*****************************************************************************
 @Description 	: Enable PWM channel sperately. Duty cycle % must be specify
 
 @Param			: nChannel 			- PWM channel 1 to 6
				  nDutyCycPercent 	- Duty clycle %
 
 @Revision		:
******************************************************************************/
void CCMDisable( PCCM_HANDLE	pHandle, uint32_t	nChannel ){
        ASSERT( 0 != pHandle);
        ASSERT( 0 != nChannel);
        TIM_TypeDef *timer = (TIM_TypeDef *)pHandle->pTimer;
        timer->CR1 &= ~TIM_CR1_CEN;
        timer->CNT = 0;
        }





















































