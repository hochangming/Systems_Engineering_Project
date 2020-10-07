/*****************************************************************************
 @Project	: SEP150 - Capsule
 @File 		: pwm.c
 @Details  	: pwm
 @Author	: lcgan
 @Hardware	: stm32
 
 --------------------------------------------------------------------------
 @Revision	: 
  Ver  	Author    	Date        	Changes
 --------------------------------------------------------------------------
   1.0  Name     XXXX-XX-XX  		Initial Release
******************************************************************************/

#include "Common.h"
#include "Hal.h"
#include "Pwm.h"



/******************************************************************************
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


/*****************************************************************************
 Local functions
******************************************************************************/


/*****************************************************************************
 Implementation
******************************************************************************/

int
PWMInit(
	PPWM_HANDLE 	pHandle,
	uint8_t 		nTimer,
	uint32_t 		nFreq
	)
{
	TIM_TypeDef *timer;
	uint32_t 	clock		= 0U;
	uint32_t 	count 		= 0U;
	uint32_t 	prescale 	= 0U;
        int		apb		= 0;
	
	ASSERT( 0 != pHandle );
	ASSERT( 0 != nFreq );
	
	/* Timer selection base on user specified */
	switch( nTimer )
	{
		case 1U:
			timer = TIM1;
            apb = 2;
		break;
		
		case 2U:
			timer = TIM2;
            apb = 1;
		break;
		
		case 3U:
			timer = TIM3;
            apb = 1;
		break;
		
		case 4U:
			timer = TIM4;
            apb = 1;
		break;
		
		case 5U:
			timer = TIM5;
            apb = 1;
		break;
		
		case 6U:
			timer = TIM6;
            apb = 1;
		break;
		
		case 7U:
			timer = TIM7;
            apb = 1;
		break;
		
		case 8U:
			timer = TIM8;
            apb = 2;
		break;

		case 9U:
			timer = TIM9;
            apb = 2;
		break;

 		case 10U:
			timer = TIM10;
            apb = 2;
		break;

  		case 11U:
			timer = TIM11;
            apb = 2;
		break;
	
   		case 12U:
			timer = TIM12;
            apb = 1;
		break;

   		case 13U:
			timer = TIM13;
            apb = 1;
		break;

    	case 14U:
			timer = TIM14;
            apb = 1;
		break;

		default:
			return PWM_ERR_INVALID;		/* User specified an invalid timer, return error */
	}
	
        pHandle -> pTimer = timer;

        timer->CR1 &= ~(TIM_CR1_DIR 
                        | TIM_CR1_OPM  /* one pulse mode */
                        | TIM_CR1_CKD 
                        | TIM_CR1_CMS); /* Center align mode */
/* Different timer has different APB bus */
	if( 1 == apb )
	{
		/* Re-calculate current bus clock. User may change it in Hal.c */
		switch( RCC->CFGR & RCC_CFGR_PPRE1 )
		{
			case RCC_CFGR_PPRE1_DIV1:
				clock = SystemCoreClock;
			break;
		
			case RCC_CFGR_PPRE1_DIV2:
				clock = SystemCoreClock>>1U;
			break;
		
			case RCC_CFGR_PPRE1_DIV4:
				clock = SystemCoreClock>>2U;
			break;
		
			case RCC_CFGR_PPRE1_DIV8:
				clock = SystemCoreClock>>3U;
			break;
		
			case RCC_CFGR_PPRE1_DIV16:
				clock = SystemCoreClock>>4U;
			break;

			default:
			break;
		}
	}
	
	if( 2 == apb )
	{
		/* Re-calculate current bus clock. User may change it in Hal.c */
		switch( RCC->CFGR & RCC_CFGR_PPRE2 )
		{
			case RCC_CFGR_PPRE2_DIV1:
				clock = SystemCoreClock;
			break;
		
			case RCC_CFGR_PPRE2_DIV2:
				clock = SystemCoreClock>>1U;
			break;
		
			case RCC_CFGR_PPRE2_DIV4:
				clock = SystemCoreClock>>2U;
			break;
		
			case RCC_CFGR_PPRE2_DIV8:
				clock = SystemCoreClock>>3U;
			break;
		
			case RCC_CFGR_PPRE1_DIV16:
				clock = SystemCoreClock>>4U;
			break;

			default:
			break;
		}
	}

  /********************************************************
  * To do: ...
  ********************************************************/
         if( 0 == (RCC->DCKCFGR1 & RCC_DCKCFGR1_TIMPRE) )
         {
             clock = 2 * clock;
         }

	count = clock / nFreq;
	
	/* since 16bits can hold 65536U. if we require 6533600 counts, 
	   everytime the prescale counts to 10, counter register will increment.
	   in this scenario, our prescale is 10, which will allows us to count 6533600 times */
	   
	/* if count is bigger then 16bits, prescaler is needed to ensure program can match required counts */
	while(count >= 0xffffU) 
	{
		count = clock / nFreq;                          
		prescale++;
		count /= (prescale + 1);
	}
	
	/*check if there is a need of prescale */
	if ( prescale != 0 )
    {
		timer->PSC = prescale;
	}
	
	/* set count into auto reload register (ARR) */
	timer->ARR = count;

        pHandle -> ReloadCounter = count;
        pHandle -> bInverse = FALSE;


	return PWM_OK;
}


void
PWMEnable(
	PPWM_HANDLE	pHandle,
	uint32_t	nChannel,
	double 		dDutyCycPercent,
	BOOL		bInverse
	)
{
	TIM_TypeDef *timer;
	int32_t ccr1;
	
	ASSERT( 0 != pHandle );
	
	timer = (TIM_TypeDef *)pHandle->pTimer;
	pHandle->bInverse = bInverse;

	
        ccr1 = (int32_t)(((double)pHandle->ReloadCounter * dDutyCycPercent) / 100.0);

	switch( nChannel )
	{
		case 1:
			timer->CCMR1 &= ~TIM_CCMR1_CC1S;
			timer->CCMR1 |= TIM_CCMR1_OC1M;
		
			timer->CCR1 &= ~TIM_CCR1_CCR1;
			timer->CCR1 = ccr1;
			if( TRUE == bInverse )
			{
				timer->CCER &= ~TIM_CCER_CC1P;
			}
			else
			{
				timer->CCER |= TIM_CCER_CC1P;
			}
			
			timer->CCER |= TIM_CCER_CC1E;
		break;
		
		case 2:
			timer->CCR2 &= ~TIM_CCR2_CCR2;
			timer->CCR2 = ccr1;
			timer->CCMR1 |= TIM_CCMR1_OC2M;
		
			if( TRUE == bInverse )
			{
				timer->CCER &= ~TIM_CCER_CC2P;
			}
			else
			{
				timer->CCER |= TIM_CCER_CC2P;
			}
			
			timer->CCER |= TIM_CCER_CC2E;
		break;

		case 3:
			timer->CCR3 &= ~TIM_CCR3_CCR3;
			timer->CCR3 = ccr1;
			timer->CCMR2 |= TIM_CCMR2_OC3M;
		
			if( TRUE == bInverse )
			{
				timer->CCER &= ~TIM_CCER_CC3P;
			}
			else
			{
				timer->CCER |= TIM_CCER_CC3P;
			}
			
			timer->CCER |= TIM_CCER_CC3E;
		break;

		case 4:
			timer->CCR4 &= ~TIM_CCR4_CCR4;
			timer->CCR4 = ccr1;
			timer->CCMR2 |= TIM_CCMR2_OC4M;
		
			if( TRUE == bInverse )
			{
				timer->CCER &= ~TIM_CCER_CC4P;
			}
			else
			{
				timer->CCER |= TIM_CCER_CC4P;
			}
			
			timer->CCER |= TIM_CCER_CC4E;
		break;
			
		default:
		break;
	}
   
	
  /********************************************************
  * To do: ...
  ********************************************************/
  timer->CR1 |= TIM_CR1_CEN | TIM_CR1_ARPE;
  timer->BDTR |= TIM_BDTR_MOE;

}


void
PWMDisable(
	PPWM_HANDLE	pHandle,
	uint32_t	nChannel
	)
{
	TIM_TypeDef *timer;
	
	ASSERT( 0 != pHandle );
	
	timer = (TIM_TypeDef *)pHandle->pTimer;
	
	switch( nChannel )
	{
		case 1:
			timer->CCMR1 &= ~TIM_CCMR1_OC1M;
		break;
		
		case 2:
      /********************************************************
      * To do: ...
      ********************************************************/
   			timer->CCMR1 &= ~TIM_CCMR1_OC2M;
   
      
		break;

		case 3:
      /********************************************************
      * To do: ...
      ********************************************************/
 			timer->CCMR2 &= ~TIM_CCMR2_OC3M;
     
      
		break;

		case 4:
      /********************************************************
      * To do: ...
      ********************************************************/
      
 			timer->CCMR2 &= ~TIM_CCMR2_OC4M;
     
		break;
		
		default:
		break;
	}
}


void
PWMSetInverse(
	PPWM_HANDLE	pHandle,
	uint32_t	nChannel,
	BOOL		bInverse
	)
{
	TIM_TypeDef *timer;
	
	ASSERT( 0 != pHandle );
	
	timer = (TIM_TypeDef *)pHandle->pTimer;
	
	if( bInverse != pHandle->bInverse )
	{
		pHandle->bInverse = bInverse;
		
		switch( nChannel )
		{
			case 1:
				timer->CCMR1 &= ~TIM_CCMR1_CC1S;
				if( TRUE == bInverse )
				{
					timer->CCER &= ~TIM_CCER_CC1P;
				}
				else
				{
					timer->CCER |= TIM_CCER_CC1P;
				}
				
				timer->CCER |= TIM_CCER_CC1E;
			break;
			
			case 2:
				timer->CCMR1 &= ~TIM_CCMR1_CC2S;
				if( TRUE == bInverse )
				{
					timer->CCER &= ~TIM_CCER_CC2P;
				}
				else
				{
					timer->CCER |= TIM_CCER_CC2P;
				}
				
				timer->CCER |= TIM_CCER_CC2E;
      
      
			break;

			case 3:
				timer->CCMR2 &= ~TIM_CCMR2_CC3S;
				if( TRUE == bInverse )
				{
					timer->CCER &= ~TIM_CCER_CC3P;
				}
				else
				{
					timer->CCER |= TIM_CCER_CC3P;
				}
				
				timer->CCER |= TIM_CCER_CC3E;
      
			break;

			case 4:
				timer->CCMR2 &= ~TIM_CCMR2_CC4S;
				if( TRUE == bInverse )
				{
					timer->CCER &= ~TIM_CCER_CC4P;
				}
				else
				{
					timer->CCER |= TIM_CCER_CC4P;
				}
				
				timer->CCER |= TIM_CCER_CC4E;
      
			break;
				
			default:
			break;
		}		
	}
}















