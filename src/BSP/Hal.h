/*****************************************************************************
 @Project	: 
 @File 		: 
 @Details  	: All Ports and peripherals configuration                    
 @Author	: 
 @Hardware	: 
 
 --------------------------------------------------------------------------
 @Revision	:
  Ver  	Author    	Date        	Changes
 --------------------------------------------------------------------------
   1.0  Name     XXXX-XX-XX  		Initial Release
   
******************************************************************************/

#ifndef __HAL_DOT_H__
#define __HAL_DOT_H__


/*****************************************************************************
 Define
******************************************************************************/
#define GPIO_MODE_INPUT 	0x00U
#define GPIO_MODE_OUTPUT 	0x01U
#define GPIO_MODE_AF		0x02U
#define GPIO_MODE_ANALOGUE	0x03U

#define GPIO_PULL_DIS		0x00U
#define GPIO_PULL_UP		0x01U
#define GPIO_PULL_DWN		0x02U

#define GPIO_SPEED_MIN		0x00U
#define GPIO_SPEED_MEDIUM	0x01U
#define GPIO_SPEED_HIGH 	0x02U
#define GPIO_SPEED_MAX 		0x03U

#define GPIO_PWM_AF1		0x01U
#define GPIO_PWM_AF2		0x02U
#define GPIO_I2C2_AF4		0x04U
#define GPIO_SPI1_AF5		0x05U
#define GPIO_SPI2_AF5		0x05U
#define GPIO_SPI3_AF6       0x06U
#define GPIO_USART2_AF7		0x07U
#define GPIO_UART7_AF8		0x08U

#define GPIO_MODE_INPUT 	0x00U
#define GPIO_MODE_OUTPUT 	0x01U
#define GPIO_MODE_AF		0x02U
#define GPIO_MODE_ANALOGUE	0x03U

#define GPIO_PULL_DIS		0x00U
#define GPIO_PULL_UP		0x01U
#define GPIO_PULL_DWN		0x02U

#define GPIO_SPEED_MIN		0x00U
#define GPIO_SPEED_MEDIUM	0x01U
#define GPIO_SPEED_HIGH 	0x02U
#define GPIO_SPEED_MAX 		0x03U

#define GPIO_TIM1_AF1		0x01U
#define GPIO_TIM2_AF1		0x01U
#define GPIO_PWM_AF1		0x01U
#define GPIO_PWM_AF2		0x02U
#define GPIO_TIM4_AF2		0x02U
#define GPIO_TIM5_AF2		0x02U
#define GPIO_PWM_AF3		0x03U
#define GPIO_I2C1_AF4		0x04U
#define GPIO_I2C2_AF4		0x04U
#define GPIO_SPI1_AF5		0x05U
#define GPIO_SPI2_AF5		0x05U
#define GPIO_SPI3_AF6       0x06U
#define GPIO_USART2_AF7		0x07U
#define GPIO_UART7_AF8		0x08U

/*****************************************************************************
 Define - Pins
******************************************************************************/
#define PE_M1_CTRL_IN1		2U
#define PE_M2_CTRL_IN1		3U
#define PE_M3_CTRL_IN1		4U
#define PE_M4_CTRL_IN1		5U

#define PC_M1_PWM_CH1		6U
#define PC_M2_PWM_CH2		7U
#define PC_M3_PWM_CH3		8U
#define PC_M4_PWM_CH4		9U

#define PG_M1_ENC_IN1		0U
#define PG_M1_ENC_IN2		1U
#define PG_M2_ENC_IN1		2U
#define PG_M2_ENC_IN2		3U
#define PG_M3_ENC_IN1		4U
#define PG_M3_ENC_IN2		5U
#define PG_M4_ENC_IN1		6U
#define PG_M4_ENC_IN2		7U

#define PD_SERVO_PWM_CH1	12U

#define PB_LED_BLUE			7U
#define PB_LED_RED			14U

#define PB_US_TRIG			10U
#define PB_US_ECHO			11U

#define PD_USART2_TX_DBG	5U			
#define PD_USART2_RX_DBG	6U

#define PB_LASER_IRQ		5U
#define PB_LASER_XSHUT		4U

#define PA_UWB_SPI1_CS		4U
#define PA_UWB_SPI1_CLK		5U
#define PA_UWB_SPI1_MISO	6U
#define PA_UWB_SPI1_MOSI	7U

#define PE_LCD_RESET		6U
#define PE_LCD_DC			8U
#define PE_LCD_BL			0U
#define PB_LCD_SPI2_CS		13U
#define PD_LCD_SPI2_CLK		3U
#define PB_LCD_SPI2_MISO	14U
#define PB_LCD_SPI2_MOSI	15U

//#define PA_IMU_SPI3_CS      15U
//#define PC_IMU_SPI3_SCK     10U
//#define PC_IMU_SPI3_MISO    11U
//#define PC_IMU_SPI3_MOSI    12U
//#define PC_IMU_DATA_RDY		3U

#define PE_UART7_RX			7U
#define PE_UART7_TX			8U

#define PF_US1_TRIG         8U
#define PF_US2_TRIG         9U
#define PF_US3_TRIG         10U
#define PF_US4_TRIG         11U
#define PF_US5_TRIG         12U
#define PF_US6_TRIG         13U
#define PF_US7_TRIG         14U
#define PF_US8_TRIG         15U

#define PG_US1_ECHO         8U
#define PG_US2_ECHO         9U
#define PG_US3_ECHO         10U
#define PG_US4_ECHO         11U
#define PG_US5_ECHO         12U
#define PG_US6_ECHO         13U
#define PG_US7_ECHO         14U
#define PG_US8_ECHO         15U

#define	PE_UWB_RESET		1U
#define PC_UWB_IRQ			3U

#define PA_IMU_PWR_EN		15U

/*****************************************************************************
 Type definition
******************************************************************************/


/*****************************************************************************
 Macro
******************************************************************************/
#define BIT( x )					(1U<<(x))

/* LEDs */
#define LED_RED_ON()				(GPIOB->BSRR = BIT(PB_LED_RED))
#define LED_RED_OFF()				(GPIOB->BSRR = (BIT(PB_LED_RED)<<16U))
#define LED_RED_SET( x )			((x)? LED_RED_ON() : LED_RED_OFF())

#define LED_BLUE_ON()				(GPIOB->BSRR = BIT(PB_LED_BLUE))
#define LED_BLUE_OFF()				(GPIOB->BSRR = (BIT(PB_LED_BLUE)<<16U))
#define LED_BLUE_SET( x )			((x)? LED_BLUE_ON() : LED_BLUE_OFF())

/* LCD */
#define LCD_RESET_LOW()				(GPIOE->BSRR = (BIT(PE_LCD_RESET)<<16U))
#define LCD_RESET_HIGH()			(GPIOE->BSRR = BIT(PE_LCD_RESET))
#define LCD_RESET_SET( x )			((x)? LCD_RESET_HIGH() : LCD_RESET_LOW())

#define LCD_DC_HIGH()				(GPIOE->BSRR = BIT(PE_LCD_DC))
#define LCD_DC_LOW()				(GPIOE->BSRR = (BIT(PE_LCD_DC)<<16U))
#define LCD_DC_SET( x )				((x)? LCD_DC_HIGH() : LCD_DC_LOW())

#define LCD_BL_ON()					(GPIOE->BSRR = BIT(PE_LCD_BL))
#define LCD_BL_OFF()				(GPIOE->BSRR = (BIT(PE_LCD_BL)<<16U))
#define LCD_BL_SET( x )				((x)? LCD_BL_ON() : LCD_BL_OFF())

#define LCD_CS_LOW()				(GPIOB->BSRR = (BIT(PB_LCD_SPI2_CS)<<16U))
#define LCD_CS_HIGH()			(GPIOB->BSRR = BIT(PB_LCD_SPI2_CS))
/* Motors */
#define M1_DIR_CTRL_ON()			(GPIOE->BSRR = BIT(PE_M1_CTRL_IN1))
#define M1_DIR_CTRL_OFF()			(GPIOE->BSRR = (BIT(PE_M1_CTRL_IN1)<<16U))
#define M1_DIR_CTRL_SET( x )		((x)? M1_DIR_CTRL_ON() : M1_DIR_CTRL_OFF())

#define M1_PWM_OUT_EN()				GPIOC->MODER &= ~GPIO_MODER_MODER6;			\
									GPIOC->MODER |= (GPIO_MODE_AF<<GPIO_MODER_MODER6_Pos);							
#define M1_PWM_OUT_DIS()			GPIOC->MODER &= ~GPIO_MODER_MODER6;			\
									GPIOC->MODER |= (GPIO_MODE_INPUT<<GPIO_MODER_MODER6_Pos);								
#define M1_PWM_OUT_SET( x )			((x)? M1_PWM_OUT_EN() : M1_PWM_OUT_DIS())

#define M2_DIR_CTRL_ON()			(GPIOE->BSRR = BIT(PE_M2_CTRL_IN1))
#define M2_DIR_CTRL_OFF()			(GPIOE->BSRR = (BIT(PE_M2_CTRL_IN1)<<16U))
#define M2_DIR_CTRL_SET( x )		((x)? M2_DIR_CTRL_ON() : M2_DIR_CTRL_OFF())

#define M2_PWM_OUT_EN()				GPIOC->MODER &= ~GPIO_MODER_MODER7;			\
									GPIOC->MODER |= (GPIO_MODE_AF<<GPIO_MODER_MODER7_Pos);
#define M2_PWM_OUT_DIS()			GPIOC->MODER &= ~GPIO_MODER_MODER7;			\
									GPIOC->MODER |= (GPIO_MODE_OUTPUT<<GPIO_MODER_MODER7_Pos);
#define M2_PWM_OUT_SET( x )			((x)? M2_PWM_OUT_EN() : M2_PWM_OUT_DIS())

#define M3_DIR_CTRL_ON()			(GPIOE->BSRR = BIT(PE_M3_CTRL_IN1))
#define M3_DIR_CTRL_OFF()			(GPIOE->BSRR = (BIT(PE_M3_CTRL_IN1)<<16U))
#define M3_DIR_IN_SET( x )			((x)? M3_DIR_CTRL_ON() : M3_DIR_CTRL_OFF())

#define M3_PWM_OUT_EN()				GPIOC->MODER &= ~GPIO_MODER_MODER8;			\
									GPIOC->MODER |= (GPIO_MODE_AF<<GPIO_MODER_MODER8_Pos);
#define M3_PWM_OUT_DIS()			GPIOC->MODER &= ~GPIO_MODER_MODER8;			\
									GPIOC->MODER |= (GPIO_MODE_OUTPUT<<GPIO_MODER_MODER8_Pos);
#define M3_PWM_OUT_SET( x )			((x)? M3_PWM_OUT_EN() : M3_PWM_OUT_DIS())

#define M4_DIR_CTRL_ON()			(GPIOE->BSRR = BIT(PE_M4_CTRL_IN1))
#define M4_DIR_CTRL_OFF()			(GPIOE->BSRR = (BIT(PE_M4_CTRL_IN1)<<16U))
#define M4_DIR_CTRL_SET( x )		((x)? M4_DIR_CTRL_ON() : M4_DIR_CTRL_OFF())

#define M4_PWM_OUT_EN()				GPIOC->MODER &= ~GPIO_MODER_MODER9;			\
									GPIOC->MODER |= (GPIO_MODE_AF<<GPIO_MODER_MODER9_Pos);
#define M4_PWM_OUT_DIS()			GPIOC->MODER &= ~GPIO_MODER_MODER9;			\
									GPIOC->MODER |= (GPIO_MODE_OUTPUT<<GPIO_MODER_MODER9_Pos);
#define M4_PWM_OUT_SET( x )			((x)? M4_PWM_OUT_EN() : M4_PWM_OUT_DIS())

/* IMU */
//#define IMU_PWR_ON()				(GPIOA->BSRR = BIT(PC_IMU_PWR_EN))
//#define IMU_PWR_OFF()				(GPIOA->BSRR = (BIT(PC_IMU_PWR_EN)<<16U))
//#define IMU_PWR_SET( x )			((x)? IMU_PWR_ON() : IMU_PWR_OFF())


///* LCD */
//#define LCD_RESET_LOW()				(GPIOB->BSRR = (BIT(PB_LCD_RESET)<<16U))
//#define LCD_RESET_HIGH()			(GPIOB->BSRR = BIT(PB_LCD_RESET))
//#define LCD_RESET_SET( x )			((x)? LCD_RESET_HIGH() : LCD_RESET_LOW())
//
//#define LCD_DC_HIGH()				(GPIOB->BSRR = BIT(PB_LCD_DC))
//#define LCD_DC_LOW()				(GPIOB->BSRR = (BIT(PB_LCD_DC)<<16U))
//#define LCD_DC_SET( x )				((x)? LCD_DC_HIGH() : LCD_DC_LOW())
//
//#define LCD_BL_ON()					(GPIOB->BSRR = BIT(PB_LCD_BL))
//#define LCD_BL_OFF()				(GPIOB->BSRR = (BIT(PB_LCD_BL)<<16U))
//#define LCD_BL_SET( x )				((x)? LCD_BL_ON() : LCD_BL_OFF())
//
//#define LCD_CS_LOW()				(GPIOB->BSRR = (BIT(PB_LCD_SPI2_CS)<<16U))
//#define LCD_CS_HIGH()			(GPIOB->BSRR = BIT(PB_LCD_SPI2_CS))

/* Ultrasound sensors */
#define US1_TRIG_ON()				(GPIOF->BSRR = BIT(PF_US1_TRIG))
#define US1_TRIG_OFF()				(GPIOF->BSRR = (BIT(PF_US1_TRIG)<<16U))
#define US1_TRIG_SET( x )			((x)? US1_TRIG_ON() : US1_TRIG_OFF())
#define IN_US1_ECHO()				((GPIOG->IDR & BIT(PG_US1_ECHO))? TRUE : FALSE)

#define US2_TRIG_ON()				(GPIOF->BSRR = BIT(PF_US2_TRIG))
#define US2_TRIG_OFF()				(GPIOF->BSRR = (BIT(PF_US2_TRIG)<<16U))
#define US2_TRIG_SET( x )			((x)? US2_TRIG_ON() : US2_TRIG_OFF())
#define IN_US2_ECHO()				((GPIOG->IDR & BIT(PG_US2_ECHO))? TRUE : FALSE)

#define US3_TRIG_ON()				(GPIOF->BSRR = BIT(PF_US3_TRIG))
#define US3_TRIG_OFF()				(GPIOF->BSRR = (BIT(PF_US3_TRIG)<<16U))
#define US3_TRIG_SET( x )			((x)? US3_TRIG_ON() : US3_TRIG_OFF())
#define IN_US3_ECHO()				((GPIOG->IDR & BIT(PG_US3_ECHO))? TRUE : FALSE)

#define US4_TRIG_ON()				(GPIOF->BSRR = BIT(PF_US4_TRIG))
#define US4_TRIG_OFF()				(GPIOF->BSRR = (BIT(PF_US4_TRIG)<<16U))
#define US4_TRIG_SET( x )			((x)? US4_TRIG_ON() : US4_TRIG_OFF())
#define IN_US4_ECHO()				((GPIOG->IDR & BIT(PG_US4_ECHO))? TRUE : FALSE)

#define US5_TRIG_ON()				(GPIOF->BSRR = BIT(PF_US5_TRIG))
#define US5_TRIG_OFF()				(GPIOF->BSRR = (BIT(PF_US5_TRIG)<<16U))
#define US5_TRIG_SET( x )			((x)? US5_TRIG_ON() : US5_TRIG_OFF())
#define IN_US5_ECHO()				((GPIOG->IDR & BIT(PG_US5_ECHO))? TRUE : FALSE)

#define US6_TRIG_ON()				(GPIOF->BSRR = BIT(PF_US6_TRIG))
#define US6_TRIG_OFF()				(GPIOF->BSRR = (BIT(PF_US6_TRIG)<<16U))
#define US6_TRIG_SET( x )			((x)? US6_TRIG_ON() : US6_TRIG_OFF())
#define IN_US6_ECHO()				((GPIOG->IDR & BIT(PG_US6_ECHO))? TRUE : FALSE)

#define US7_TRIG_ON()				(GPIOF->BSRR = BIT(PF_US7_TRIG))
#define US7_TRIG_OFF()				(GPIOF->BSRR = (BIT(PF_US7_TRIG)<<16U))
#define US7_TRIG_SET( x )			((x)? US7_TRIG_ON() : US7_TRIG_OFF())
#define IN_US7_ECHO()				((GPIOG->IDR & BIT(PG_US7_ECHO))? TRUE : FALSE)

#define US8_TRIG_ON()				(GPIOF->BSRR = BIT(PF_US8_TRIG))
#define US8_TRIG_OFF()				(GPIOF->BSRR = (BIT(PF_US8_TRIG)<<16U))
#define US8_TRIG_SET( x )			((x)? US8_TRIG_ON() : US8_TRIG_OFF())
#define IN_US8_ECHO()				((GPIOG->IDR & BIT(PG_US8_ECHO))? TRUE : FALSE)

/* Optical Sensor */
#define OPTICAL_XSHUT_ON()			(GPIOB->BSRR = BIT(PB_LASER_XSHUT))
#define OPTICAL_XSHUT_OFF()			(GPIOB->BSRR = (BIT(PB_LASER_XSHUT)<<16U))
#define OPTICAL_XSHUT_SET( x )		((x)? OPTICAL_XSHUT_ON() : OPTICAL_XSHUT_OFF())

#define IMU_PWR_ON()				(GPIOA->BSRR = (BIT(PA_IMU_PWR_EN)<<16U))
#define IMU_PWR_OFF()				(GPIOA->BSRR = BIT(PA_IMU_PWR_EN)) 
#define IMU_PWR_SET( x )			((x)? IMU_PWR_ON() : IMU_PWR_OFF())
	
/* UWB Reset */
#define UWB_RESET_ON()				(GPIOE->BSRR = BIT(PE_UWB_RESET))
#define UWB_RESET_OFF()				(GPIOE->BSRR = (BIT(PE_UWB_RESET)<<16U))
#define UWB_RESET_SET( x )			((x)? UWB_RESET_ON() : UWB_RESET_OFF())

#define UWB_CS_ASSERT()				GPIOA->BSRR = GPIO_BSRR_BR_4;
#define UWB_CS_DEASSERT()			GPIOA->BSRR = GPIO_BSRR_BS_4;		
///* UWB Reset */
//#define UWB_RESET_ON()				(GPIOE->BSRR = BIT(PE_UWB_RESET))
//#define UWB_RESET_OFF()				(GPIOE->BSRR = (BIT(PE_UWB_RESET)<<16U))
//#define UWB_RESET_SET( x )			((x)? UWB_RESET_ON() : UWB_RESET_OFF())
//
//#define UWB_CS_ASSERT()				GPIOA->BSRR = GPIO_BSRR_BR_4;
//#define UWB_CS_DEASSERT()			GPIOA->BSRR = GPIO_BSRR_BS_4;



/******************************************************************************
 Global functions
******************************************************************************/


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
void PortInit( void );



#endif /* __HAL_DOT_H__ */









