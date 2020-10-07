/*****************************************************************************
 @Project	: 
 @File 		: i2c.c
 @Details  	: 
 @Author		: lcgan
 @Hardware	: 
 
 --------------------------------------------------------------------------
 @Revision	:
  Ver  	Author    	Date        	Changes
 --------------------------------------------------------------------------
   1.0  Name     XXXX-XX-XX  		Initial Release
   
******************************************************************************/

#include <Common.h>
#include "Hal.h"
#include "i2c.h"


/*****************************************************************************
 Define
******************************************************************************/
#define TOTAL_I2C			3U


/*****************************************************************************
 Type definition
******************************************************************************/


/*****************************************************************************
 Global Variables
******************************************************************************/


/*****************************************************************************
 constant Variables
******************************************************************************/


/*****************************************************************************
 Local Variables
******************************************************************************/
static volatile PI2C_HANDLE	g_pI2cIrqHandles[TOTAL_I2C];


/*****************************************************************************
 Local functions
******************************************************************************/


/*****************************************************************************
 Callback functions
******************************************************************************/


/*****************************************************************************
 Implementation 
******************************************************************************/
int
I2cInit(PI2C_HANDLE pHandle, uint8_t nPort, uint32_t nBusSpeed )
{
	I2C_TypeDef     *i2c;
	IRQn_Type 		irq;
	//uint32_t 		temp = 0;
	
	ASSERT( 0 != pHandle );
	ASSERT( 0 != nPort );

	/* To do ... */
    switch(nPort){
        
        case 1:
                i2c = I2C1;
                irq = I2C1_EV_IRQn;
                break;
        case 2:
                i2c = I2C2;
                irq = I2C2_EV_IRQn;
                break;
        case 3:
                i2c = I2C3;
                irq = I2C3_EV_IRQn;
                break;
        
        default : 
                return I2C_STS_PORT_INVALID;       
    }
    
    pHandle->pI2c = i2c;
    pHandle->bRepeatStart = FALSE;
    pHandle->nTxCount = 0;
    pHandle->nRxCount = 0;

        g_pI2cIrqHandles[nPort-1] = pHandle;  /* Assign handle to I2C port */

        i2c->CR1 = 0; /* reset register */
        
        i2c->CR1 &= ~(I2C_CR1_PE); /*  Peripheral disable */
        while (i2c->CR1 & I2C_CR1_PE); /* If PE then hang here */

        i2c->OAR1 &= ~(I2C_OAR1_OA1EN); /* disable own address 1 */ 
        i2c->OAR2 &= ~(I2C_OAR2_OA2EN); /* disable own address 2 */ 
        
        i2c->CR2 |= (I2C_CR2_AUTOEND | I2C_CR2_NACK); 
        i2c->CR2 &= ~(I2C_CR2_ADD10);
        
        /* Reference in page 818 */
        /* PRESC = PRESC + 1 */ 
        i2c->TIMINGR |= (0x01<<I2C_TIMINGR_PRESC_Pos); /* set PRESC value of 1 */

        /* SCLL = (SCLL+1)*PRESEC* i2cclk_period */
        i2c->TIMINGR |= (0x86<<I2C_TIMINGR_SCLL_Pos); /* set SCL low period of 5 us */
        
        /* SCLH = (SCLH+1)*PRESC* i2cclk_period */
        i2c->TIMINGR |= (0x78<<I2C_TIMINGR_SCLH_Pos); /*set SCL high period of 4.48 us */
        
        /* SDADEL = (SDADEL *PRESEC* i2cclk_period) */ 
        i2c->TIMINGR |= (0x04<<I2C_TIMINGR_SDADEL_Pos); /* set SDADEL of 148.144 ns */ 

        /* SCLDEL = (SCLDEL+1)* PRESC* i2cclk_period) */
        i2c->TIMINGR |= (0x0C<<I2C_TIMINGR_SCLDEL_Pos); /* set SCLDELD of 481.468 ns */
       /* SCLK period = SCLL + SCLH + SDADEL + SCLDEL  = 10.1 us*/

        i2c->OAR1 = (I2C_OAR1_OA1EN | 0x52);  /* set to 7 bit addressing */
 
        i2c->CR1 |= (I2C_CR1_PE); /*  Peripheral re-enable */


        NVIC_EnableIRQ(irq); /* enable interrupt */ 
	
        return I2C_STS_OK;
}


void I2cSetRiseTimeMax( PI2C_HANDLE pHandle, int nRiseNanoSec )
{
	I2C_TypeDef *i2c;
	ASSERT( 0 != pHandle );
}


void
I2cWrite(
	PI2C_HANDLE pHandle,
	uint8_t 	nSlaveAddr,
	uint8_t 	Register,
	void const 	*pData,
	uint8_t 	nByte
	)
{
	I2C_TypeDef *i2c;
	int32_t reg;
	
	ASSERT( 0 != pHandle );
	
	/*To do ...*/

        /* init variables */ 
        i2c = (I2C_TypeDef *) pHandle->pI2c;
        pHandle->nSlaveAddr = nSlaveAddr;
        pHandle->Register = Register;
        pHandle->pData = (uint8_t *)pData;
        pHandle->nByte = nByte + 1;
        pHandle->nTxCount = 0;
        pHandle->bWrite = TRUE;

        /* setting the 7 bit addressing mode,
         transfer direction, number bytes to be Tx,
         stop condition and byte ack */   
        reg &= ~(I2C_CR2_SADD | I2C_CR2_RD_WRN |
                I2C_CR2_NBYTES | I2C_CR2_AUTOEND 
                | I2C_CR2_NACK); 

        /* assigning bytes and slave address */ 
        reg |= ((pHandle->nByte<<I2C_CR2_NBYTES_Pos)|
                (nSlaveAddr<<I2C_CR2_SADD_Pos));

        i2c->CR2 = reg;

        i2c->CR2 |= I2C_CR2_START; /* start bit generation */

        i2c->CR1 |= I2C_CR1_TXIE | I2C_CR1_TCIE; /*set Tx interrupt enabled */

}


void
I2cRead( 
	PI2C_HANDLE pHandle,
	uint8_t 	nSlaveAddr,
	uint8_t 	Register,
	void 		*pData,
	uint8_t 	nByte
	)
{
	I2C_TypeDef *i2c;
	ASSERT( 0 != pHandle );
	
	/*To do ...*/
        
        /* init variables */ 
        i2c = (I2C_TypeDef *) pHandle->pI2c;
        pHandle -> nSlaveAddr = nSlaveAddr;
        pHandle->Register = Register;
        pHandle-> pData = (uint8_t *) pData;
        pHandle->nByte = nByte;
        pHandle->nRxCount = 0;
        pHandle->nTxCount = 0;
        pHandle->bWrite = 0;

        /* setting the 7 bit addressing mode,
         transfer direction, number bytes to be Tx,
         stop condition */ 
        i2c->CR2 &= ~(I2C_CR2_SADD | I2C_CR2_NBYTES);
        i2c->CR2 &= ~(I2C_CR2_AUTOEND | I2C_CR2_RD_WRN);
        
        /*  assigning  only 1 byte of of data and setting the slave address */
        i2c->CR2 |= (1U<<I2C_CR2_NBYTES_Pos) | (nSlaveAddr<<I2C_CR2_SADD_Pos);

        i2c->CR2 |= I2C_CR2_START; /* start bit generation */

        i2c->CR1 |= I2C_CR1_RXIE | I2C_CR1_TXIE | I2C_CR1_TCIE; /*set Tx nad Rx interrupt enabled */


}


void 
I2cAddHook(
	PI2C_HANDLE 		pHandle,
	PI2C_HOOK 			pHook,
	I2C_CB_DONE 		*pfDone
	)
{
	ASSERT( 0 != pHandle );
	ASSERT( 0 != pHook );
	ASSERT( 0 != pfDone );
	
	pHook->pfDone 		= pfDone;
	pHook->pNext 		= pHandle->pHeadHook;
	pHandle->pHeadHook 	= pHook;
}


/*****************************************************************************
 Callback functions
******************************************************************************/


/*****************************************************************************
 Local functions
******************************************************************************/
static void i2c_Handler( PI2C_HANDLE pHandle, I2C_TypeDef *pI2C )
{
        PI2C_HOOK	cur;
	uint32_t	status = pI2C->ISR;

	ASSERT( 0 != pHandle );
	
	if( 0 != (status & I2C_ISR_STOPF) )
	{

		/*To do ...*/

                pI2C->ICR |= I2C_ICR_STOPCF; /*clear stop flag */ 

                if(pHandle->pHeadHook != 0 ) 
                {
                        for (cur = pHandle->pHeadHook; cur != 0 ; cur = cur->pNext)
                        {
                                ASSERT( 0 != cur->pfDone);
                                cur->pfDone();
                        }
                }       
        }

	else
	{
		if( 0 != (status & I2C_ISR_TXIS) ) /* check if TXDR is empty and needs data to be written */ 
		{
		  /*To do: the current byte transmission is done ...*/  
                   if (pHandle->bWrite == TRUE) /* check if write is completed */ 
                   {
                        if(pHandle->nTxCount == 0)  /* check if Tx count is 0 */ 
                        {
                               pI2C->TXDR = pHandle->Register; /* write register to TXDR*/
                        }

                        else 
                        {
                                pI2C->TXDR = (*pHandle->pData)++; /* increment the data assigned to the TXDR */ 
                        }
                        
                        pHandle->nTxCount++; /* increment Tx count by 1 when writing data to TXDR */
                   }
               
                
                else 
                {
                    if (pHandle->nTxCount == 0 )
                    {
                           pHandle->nTxCount++;
                           pI2C->TXDR = pHandle->Register; /* write data to TXDR */ 
                           pI2C->CR1 &= ~(I2C_CR1_TXIE);  /* disable Tx interrupt */ 
                    }
                }

                }
		
		if( 0 != (status & I2C_ISR_TC) )
		{
                     /*To do: the whole packet transmission is done ...*/
                   if(pHandle->bWrite == TRUE)
                   {
                       if(pHandle->nTxCount >= pHandle->nByte)
                       {
                              pI2C->CR1 &= ~(I2C_CR1_TXIE);
                             pI2C->CR1 |= I2C_CR1_STOPIE ;
                       }

                       pI2C->CR2 |= I2C_CR2_STOP;  /* stop generation */
                   }

                   else 
                   {
                        if(pHandle->nRxCount == 0)
                        {
                                pI2C->CR2 &= ~(I2C_CR2_SADD | I2C_CR2_NBYTES | I2C_CR2_STOP);

                                pI2C->CR2 |= (pHandle->nByte<<I2C_CR2_NBYTES_Pos) | (pHandle->nSlaveAddr<<I2C_CR2_SADD_Pos);

                                pI2C->CR2 |= I2C_CR2_START |I2C_CR2_AUTOEND | I2C_CR2_RD_WRN;
                        }
                   }
                }
		
		if( 0 != (status & I2C_ISR_RXNE) )
		{
			/*To do ...*/
                       
                       *pHandle->pData = pI2C->RXDR;
                        pHandle->nRxCount++;
                       *pHandle->pData++; /* increment data for next */ 
                        
                        if(pHandle->nRxCount >= pHandle->nByte)
                        {
                                pI2C->CR1 &= ~(I2C_CR1_TXIE | I2C_CR1_RXIE);
                                 pI2C->CR1 &= ~(I2C_CR1_TCIE | I2C_CR1_NACKIE);
                                 pI2C->CR1 |= I2C_CR1_STOPIE; /* enable stop bit interrupt */ 
                        }

		}
    }
}


/*****************************************************************************
 Interrupt functions
******************************************************************************/
void I2C1_EV_IRQHandler( void )
{
	i2c_Handler( g_pI2cIrqHandles[0], I2C1 );
}


void I2C2_EV_IRQHandler( void )
{
	i2c_Handler( g_pI2cIrqHandles[1], I2C2 );	
}


void I2C3_EV_IRQHandler( void )
{
	i2c_Handler( g_pI2cIrqHandles[2], I2C3 );	
}










