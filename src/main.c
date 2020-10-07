/*****************************************************************************
 @Project	:
 @File 		: main.c
 @Details  	: Main entry
 @Author	:  
 @Hardware	:  


 --------------------------------------------------------------------------
 @Revision	:
  Ver  	Author    	Date        	Changes
 --------------------------------------------------------------------------
   1.0    Team C    XXXX-XX-XX  		Initial Release

******************************************************************************/

/*NOTE:*/
/*****************************************************************************
Description:
This example is base on FreeRTOS with static memory without using dynamic
allocation. Two tasks are created. LCD task and Terminal task. These tasks are
run in multitasking. LCD can draw number of packet received from Terminal
without any packet lost. Queues is used to store up to 10 items.
******************************************************************************/
#include <Common.h>
#include "Hal.h"
#include "BSP.h"
#include "Timer.h"
#include "UltraSound.h"
#include "Dma.h"
#include "Spim.h"
#include "Serial.h"
#include "i2c.h"
#include "PololuV5.h"
#include "imu.h"
#include "ips.h"
#include "LCD_Driver.h"
#include "gui.h"
#include "Ccm.h"
#include "motors.h"
#include "Encoder.h"
#include "Pwm.h"
#include "Move.h"
#include "IRQ.h"
#include "math.h"

#include "FreeRTOSConfig.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "event_groups.h"
#include "term.h"
#include "semphr.h"

/*****************************************************************************
 Define
******************************************************************************/
#define SYS_TICK_MS 1
#define LCD_BUF_SIZE 4096
#define TIMER9_TICK_HZ 10000U
#define ENCODER_SMPL_INTRVL_MS 25U
#define MOTOR_STOP_DELAY_MS 20
#define DEFAULT_DUTY 30U
#define PID_TARGET_DEFAULT_RPM 40U
#define DUTY_CYCLE_MIN 30U
#define DUTY_CYCLE_MAX 40U
#define OUTPUT_FACTOR 0.332025f
#define OUTPUT_FACTOR1 0.3290f
#define OUTPUT_FACTOR2 0.3467f
#define OUTPUT_FACTOR3 0.3255f
#define OUTPUT_FACTOR4 0.3269f

#define USONIC_TOTAL 8U
#define ShortDist 100
#define LongDist 150
#define SENSOR_DIST 1000
#define SENSOR_ShortDist 1500
//#define SENSOR_LongDist 10000


#define EVT_LCD_FREE 0x00000001U
#define EVT_LCD_BLOCK_DONE 0x00000002U
#define EVT_UART_ON_RX 0x00000001U
#define EVT_ENC_DONE1 0x00000001U
#define EVT_USONIC1_DONE 0x00000001U
#define EVT_USONIC2_DONE 0x00000002U
#define EVT_USONIC3_DONE 0x00000003U
#define EVT_USONIC4_DONE 0x00000004U
#define EVT_USONIC5_DONE 0x00000005U
#define EVT_USONIC6_DONE 0x00000006U
#define EVT_USONIC7_DONE 0x00000007U
#define EVT_USONIC8_DONE 0x00000008U
#define EVT_UART_ON_TX 0x00000002U

#define LCD_TASK_STACK_SIZE 300
#define TERM_TASK_STACK_SIZE 300
#define ENC_TASK_STACK_SIZE 300
#define USONIC_TASK_STACK_SIZE 300
#define IMU_TASK_STACK_SIZE 300
#define MotorsResp_TASK_STACK_SIZE 300
#define IPS_TASK_STACK_SIZE 400
#define NUM_TIMERS 5

#define __SCHEME_SLOW /*Flag for slow scheme*/
/*****************************************************************************
 Type definition
******************************************************************************/
typedef union _tagUsonic_State {
    uint8_t CurrStateNumber;

    struct
    {
        uint8_t bUS1 : 1;
        uint8_t bUS2 : 1;
        uint8_t bUS3 : 1;
        uint8_t bUS4 : 1;
        uint8_t bUS5 : 1;
        uint8_t bUS6 : 1;
        uint8_t bUS7 : 1;
        uint8_t bUS8 : 1;
    } b;

} USONIC_STATE, *PUSONIC_STATE;

typedef enum
{
    false,
    true
} bool;

typedef struct SensorStats
{
    /*init for stat done at sensor init fn*/
    volatile bool sensor0;
    volatile bool sensor1;
    volatile bool sensor2;
    volatile bool sensor3;
    volatile bool sensor4;
    volatile bool sensor5;
    volatile bool sensor6;
    volatile bool sensor7;
    volatile bool sensor8;

    volatile bool sensor0_OBS;
    volatile bool sensor1_OBS;
    volatile bool sensor2_OBS;
    volatile bool sensor3_OBS;
    volatile bool sensor4_OBS;
    volatile bool sensor5_OBS;
    volatile bool sensor6_OBS;
    volatile bool sensor7_OBS;
    volatile bool sensor8_OBS;

} SensorStat;
 
typedef struct AlgoStat
{
    volatile int DiagFlag;
    volatile int Diag_Move;
    volatile int XYFlag;
    volatile int Mov1Flag;
    volatile int Mov2Flag;
    volatile int Mov3Flag;
    volatile int Mov4Flag;
    volatile int Mov5Flag;
    volatile int Mov6Flag;
    volatile int Mov7Flag;
    volatile int Mov8Flag;
    volatile int MovestateFlag;
    volatile int MovStopFlag;

} AlgoStatus;

 

/*****************************************************************************
 Global Variables
******************************************************************************/
extern UART_DRIVER const STM32F722X_USART_DRV;
void GUI_AppDraw( BOOL bFrameStart );
extern double g_nCurrentCoordinate[2]; 

/*****************************************************************************
 Const Local Variables
******************************************************************************/

/*****************************************************************************
 Local Variables
******************************************************************************/
static volatile int g_nSysTick = SYS_TICK_MS;
static volatile BOOL g_bSysTickReady = FALSE;

static BOOL g_bBlueToggle = FALSE;
static BOOL g_bRedToggle = FALSE;

static SPIM_HANDLE g_SpimLcdHandle;
static GUI_DATA g_aBuf[LCD_BUF_SIZE];

static GUI_MEMDEV g_MemDev;
static int g_nCount = 0;

static DMA_HANDLE g_Dma1Spi2TxHandle;
static DMA_HANDLE g_Dma1Spi2RxHandle;

static volatile int g_nDelayms = 0;

static UART_HANDLE g_BtUartHandle;
static char g_aBtUartTxBuf[1024];
static char g_aBtUartRxBuf[1024];
static char g_aLcdString[512];

static CCM_HANDLE g_Ccm1Handle;
static CCM_HANDLE g_Ccm2Handle;
static CCM_HANDLE g_Ccm3Handle;
static CCM_HANDLE g_Ccm4Handle;
static TIMER_HANDLE g_Timer9Handle;
static SHAFT_ENC_HANDLE g_ShaftEncHandles[TOTAL_MOTOR];
static int g_aRpm[TOTAL_MOTOR];
static volatile BOOL g_bEncoderData = FALSE;
static int g_nMotorSpeed = 0;
static int g_nMotorSpeedCorrection = 0;
static int g_nSmplInterval = ENCODER_SMPL_INTRVL_MS;
static PWM_HANDLE g_PwmHandle;
static MOTORS_RESP motorsExecList;
static MOVE_STATE_NUM g_nCurrMoveState = MOVE_NONE;
static volatile BOOL g_bReportON = FALSE;
static DEV_RESP_PKT g_DevInfoPkt;
static int readPWM[4] = {0};
static MOVE_STATE_NUM g_pMoveState = MOVE_NONE;
static MOVE_STATE_NUM g_pMoveState2 = MOVE_NONE;
static int g_nMotorSpeedTemp = 0;

static USONIC_HANDLE g_USHandles[USONIC_TOTAL];
static uint32_t g_aUsonicDist[USONIC_TOTAL];
static volatile BOOL g_bUSTick = FALSE;
static USONIC_STATE g_UsonicState;
static SensorStat g_Usonicstat;
static AlgoStatus g_nAlgoStatus;
 
static int g_count = 0;
static volatile uint8_t g_sensor_number = 0;
static volatile BOOL g_bsensor_Obstacle = FALSE;
static volatile BOOL g_bSensorFlag = FALSE;
static volatile BOOL g_bSensorState = FALSE;
static volatile BOOL g_bSensorFlagFwd = FALSE;
static volatile BOOL g_bSensorStateFwd = FALSE;
static volatile BOOL g_bSensorFlagright = FALSE;
static volatile BOOL g_bSensorStateright = FALSE;
static volatile BOOL g_bSensorFlagleft = FALSE;
static volatile BOOL g_bSensorStateleft = FALSE;
static volatile BOOL g_bcmdstartONHost = FALSE;

static SPIM_HANDLE g_SpimUWBHandle;

static double g_dKP = PID_CONST_KP;
static double g_dKI = PID_CONST_KI;
static double g_dKD = PID_CONST_KD;

static I2C_HANDLE g_I2cHandle;
static IMU_POLOLU_DATA g_ImuData;
static float g_dPitch;
static float g_dPitch;
static float g_dRoll;
static float g_dYaw;
static int16_t g_aImuOffset[3];
static volatile int g_nImuCalCount = 0;
static volatile int g_nTimestamp = 0;
static volatile int g_nImuSync = 0;
static volatile BOOL g_bImuAdjusted = FALSE;
static volatile BOOL g_bUartTxDone = FALSE;
static volatile BOOL g_bAlgoflag = FALSE;
static volatile int x = 0, y = 1;
static volatile int g_count0 = 0, g_count1 = 0, g_count2 = 0, g_count3 = 0,
                    g_count4 = 0;

static double g_SetX_Coord = 0.0;
static double g_SetY_Coord = 0.0;
static double g_XYCoordGoal[20] = {0};
int coord_count = 0;
static int g_nCurrPt = 0;
static int g_nCurrPt2 = 0;
 
static int g_nThresholdYaw = 150;

 
static StaticTask_t xLcdTCB;
static StackType_t xLcdStack[LCD_TASK_STACK_SIZE];
static StaticTask_t xTermTCB;
static StackType_t xTermStack[TERM_TASK_STACK_SIZE];
static StaticTask_t xEncTCB;
static StackType_t xEncStack[ENC_TASK_STACK_SIZE];
static StaticTask_t xUSonicTCB;
static StackType_t xUSonicStack[USONIC_TASK_STACK_SIZE];
static StaticTask_t xIMUTCB;
static StackType_t xIMUStack[IMU_TASK_STACK_SIZE];
static StaticTask_t xIPSTCB;
static StackType_t xIPSStack[IPS_TASK_STACK_SIZE];
static StaticTask_t xMotorsRespTCB;
static StackType_t xMotorsRespStack[MotorsResp_TASK_STACK_SIZE];


static StaticTimer_t xTimerBuffers[NUM_TIMERS];

static StaticEventGroup_t g_evtLcd;
static EventGroupHandle_t g_evtLcdHandle;
static StaticEventGroup_t g_evtUart;
static EventGroupHandle_t g_evtUartHandle;
static StaticEventGroup_t g_evtEnc;
static EventGroupHandle_t g_evtEncHandle;
static StaticEventGroup_t g_evtUSonic;
static EventGroupHandle_t g_evtUSonicHandle;
static StaticEventGroup_t g_evtIMU;
static EventGroupHandle_t g_evtIMUHandle;
static StaticEventGroup_t g_evtMotorsResp;
static EventGroupHandle_t g_evtMotorsRespHandle;
static StaticEventGroup_t g_evtIps;
static EventGroupHandle_t g_evtIpsHandle;
static StaticEventGroup_t g_evtIPS;
static EventGroupHandle_t g_evtIPSHandle;

static uint8_t ucQueueCmdStorage[50 * sizeof( HOST_REQ_PKT )];
static xQueueHandle g_xQueueCmdHandle;
static StaticQueue_t g_xQueueCmd;

static char g_aStrLcdBuf[512];
static int g_nTestCnt = 0;


static volatile double g_CurrX = 0, g_CurrY = 0, True_XY_dist = 0,
                       Diag_XY_Dist = 0;
static volatile int algo = 0, g_nAlgo = 0;

static StaticSemaphore_t xSemaphoreBufIMU;
SemaphoreHandle_t xSemaphoreIMU = 0;

static StaticSemaphore_t xSemaphoreBufIPS;
SemaphoreHandle_t xSemaphoreIPS = 0;

/*****************************************************************************
 Local functions
******************************************************************************/
static void main_SpimInit( void );
static void main_LcdInit( void );
static void main_UartInit( void );
static void main_EncodersInit( void );
 static void Host_control_Execution( char* pCmd );
static BOOL main_Gracefulstop_Algo( void );
static void main_EncoderAllReset( void );
static void main_ImuUpdate( void );
static void IMU_after_Ajustment( void );
static void main_CtrlUpdateWheelSpeed( void );
static void main_USoundInit( void );
static void main_I2cInit( void );
static float main_convertRawAcceleration( int16_t nRaw );
static float main_convertRawGyro( int16_t nRaw );
static float main_convertRawMag( int nRaw );
static void USonic_Main1_Completed( void );
static void USonic_Main2_Completed( void );
static void USonic_Main3_Completed( void );
static void USonic_Main4_Completed( void );
static void USonic_Main5_Completed( void );
static void USonic_Main6_Completed( void );
static void USonic_Main7_Completed( void );
static void USonic_Main8_Completed( void );
static void USonic_Main( void );
static void main_USONICPrevState( void );
 
static void Main_Nav_AlgoInit( void );
static void CallChangeState( MOVE_STATE_NUM gnMoveNum );
static void Main_Nav_Algo( int x, int y );

/*****************************************************************************
 Callback functions
******************************************************************************/
static void main_cbGuiFrameEnd( void );
static void main_cbLcdBlockComplete( void );
static void main_cbBtUartOnRx( void );
static void main_cbEncoderRdy( void );
static void main_cbUSonicRdy( void );
static void main_cbImuRdy( void );
static void main_cbUS1OnTrigger( BOOL bON );
static void main_cbUS2OnTrigger( BOOL bON );
static void main_cbUS3OnTrigger( BOOL bON );
static void main_cbUS4OnTrigger( BOOL bON );
static void main_cbUS5OnTrigger( BOOL bON );
static void main_cbUS6OnTrigger( BOOL bON );
static void main_cbUS7OnTrigger( BOOL bON );
static void main_cbUS8OnTrigger( BOOL bON );
static void main_cbUS1OnReady( void );
static void main_cbUS2OnReady( void );
static void main_cbUS3OnReady( void );
static void main_cbUS4OnReady( void );
static void main_cbUS5OnReady( void );
static void main_cbUS6OnReady( void );
static void main_cbUS7OnReady( void );
static void main_cbUS8OnReady( void );

/*****************************************************************************
 RTOS TASK
******************************************************************************/
static void LcdTask( void* pvParameters );
static void TermTask( void* pvParameters );
static void EncoderTask( void* pvParameters );
static void USonicTask( void* pvParameters );
static void IMUTask( void* pvParameters );
static void Motor_Task( void* pvParameters );
static void IPSTask( void* pvParameters );

/*****************************************************************************
 Implementation
******************************************************************************/
int main( void )
{
    BSPInit( );

    TRACE( "System Boot up\r\n" );
    TRACE( "SystemCoreClock %dHz\n\r", SystemCoreClock );

    memset( g_aRpm, 0, sizeof( g_aRpm ) );
    memset( g_DevInfoPkt.aResp, 0, sizeof( g_DevInfoPkt.aResp ) );

    g_nMotorSpeed = PID_TARGET_DEFAULT_RPM;

    main_UartInit( ); //Initialise UART

    main_SpimInit( );//Initialise SPI

    main_LcdInit( );

    TerminalInit( ); //Init Terminal 

    TimerInit( &g_Timer9Handle, 9, TIMER9_TICK_HZ ); //use timer 9 only. Shared among all task

    PWMInit( &g_PwmHandle, 10U, 3200U );

    main_USoundInit( );

    main_EncodersInit( );

    MotorsInit( );

    MotorsPIDConfig( DEFAULT_DUTY, g_nMotorSpeed, g_nSmplInterval,
                     DUTY_CYCLE_MIN, DUTY_CYCLE_MAX, OUTPUT_FACTOR );

    motorsExecList.nStopDelayMs = MOTOR_STOP_DELAY_MS; //Stop for safety issues

    TimerStart( &g_Timer9Handle ); //Start the timer running

    IRQInit( ); //Interrrupt enable

    Main_Nav_AlgoInit( ); //initialise all  variables for navigation

    /* Create an event. Event creation shall come before task creation */
    g_evtLcdHandle = xEventGroupCreateStatic( &g_evtLcd ); //Event handle for LCD
    g_evtUartHandle = xEventGroupCreateStatic( &g_evtUart );
     g_evtEncHandle = xEventGroupCreateStatic( &g_evtEnc );
    g_evtUSonicHandle = xEventGroupCreateStatic( &g_evtUSonic );
    g_evtMotorsRespHandle = xEventGroupCreateStatic( &g_evtMotorsResp );
    g_evtIPSHandle = xEventGroupCreateStatic( &g_evtIPS );
    xSemaphoreIMU = xSemaphoreCreateBinaryStatic( &xSemaphoreBufIMU );
    ASSERT( 0 != xSemaphoreIMU );
    xSemaphoreGive( xSemaphoreIMU );

 

    /****** OS Tasks Creation ******/

    /*Tasks added to queue list based on priority level. WHichever has higher 
    priority gets read first. If multiple task are on waiting list, higher
    priority task gets executed/read first*/

    /* LED blinking task */
    xTaskCreateStatic( TermTask, "TermTask", TERM_TASK_STACK_SIZE, NULL, 8,
                       xTermStack, &xTermTCB );

    /* IPS Display task */
    xTaskCreateStatic( IPSTask, "IPSTask", IPS_TASK_STACK_SIZE, NULL, 7,
                       xIPSStack, &xIPSTCB );

    /* Encoder CCM task */
    xTaskCreateStatic( EncoderTask, "EncoderTask", ENC_TASK_STACK_SIZE, NULL, 6,
                       xEncStack, &xEncTCB );

    /* Usonic task */
     xTaskCreateStatic( USonicTask, "USonicTask", USONIC_TASK_STACK_SIZE, NULL,
                       5, xUSonicStack, &xUSonicTCB );

    /* MotorsResp task */
    xTaskCreateStatic( Motor_Task, "Motor_Task",
                       MotorsResp_TASK_STACK_SIZE, NULL, 4, xMotorsRespStack,
                       &xMotorsRespTCB );
    /* IMU task */
    xTaskCreateStatic( IMUTask, "IMUTask", IMU_TASK_STACK_SIZE, NULL, 3,
                       xIMUStack, &xIMUTCB );

      /* LCD Display task */
      xTaskCreateStatic( LcdTask, "LcdTask", LCD_TASK_STACK_SIZE, NULL, 1,
                       xLcdStack, &xLcdTCB );



    /* Start the tasks and timer running. */
    vTaskStartScheduler( ); 

    /* OS failed will reach here */
    while( 1 )
        ;
};

static void IPSTask( void* pvParameters ) //Main IPS Task priority is set to 7
{
IpsInit( &g_SpimUWBHandle ); //Init IPS in task first
EventBits_t eventbits;

for( ;; )
{
 IpsTimer( ); //Run IPS timer to calculate distance and coordinates from within IPS.c

  vTaskDelay( 100 ); //Time takes to unblock task through multiple testing to get the right figure

      if( g_nCurrPt <= g_nCurrPt2 )
      {
        if( g_bcmdstartONHost != FALSE )
        {
            g_DevInfoPkt.Info.STX = CMD_STX;
            g_DevInfoPkt.Info.Cmd = RESP_DEV_STS;
            g_DevInfoPkt.Info.MoveState = g_nCurrMoveState;
            g_DevInfoPkt.Info.nCurX = g_nCurrentCoordinate[0];
            g_DevInfoPkt.Info.nCurY = g_nCurrentCoordinate[1];
            g_DevInfoPkt.Info.nPoint = g_nCurrPt;
            g_DevInfoPkt.Info.nYaw = g_dYaw;
            g_DevInfoPkt.Info.ETX = CMD_ETX;

            SerialWriteEx( &g_BtUartHandle, g_DevInfoPkt.aResp,
                           sizeof( g_DevInfoPkt.aResp ) );

            xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                                 pdFALSE, 100 );

       
             Main_Nav_Algo( x + ( g_nCurrPt * 2 ), 
                          y + ( g_nCurrPt * 2 ) ); //Execute Navigation Algo
        }

        if( g_nAlgoStatus.MovStopFlag == 2 )
        {
            vTaskDelay( 100 ); //time takes to unblock task. Just a delay scheduling
            g_nAlgoStatus.MovStopFlag = 0;
        }
      }
  }
}


static void Motor_Task( void* pvParameters ) //Main motor task Priority is set lower
{

for( ;; )
{
  vTaskDelay( 5 ); //Time takes to unblock task through multiple testing to get the right figure 
//        vTaskDelay( 50 );

  if( motorsExecList.PtrMotorListArr !=NULL) //Check if motor response list is set
  {

      switch( motorsExecList.PtrMotorListArr[motorsExecList.CurrStateNumber] ) 
      {
        case RESP_STOP:
               
              if( TRUE == main_Gracefulstop_Algo( ) )
              {
                  g_nCurrMoveState = MOVE_STOP;
                  motorsExecList.CurrStateNumber++;
              }
              break;

          case RESP_STOP_DELAY:
              if( 0 != motorsExecList.nStopDelayMs )
              {
                  motorsExecList.nStopDelayMs--;
                  if( 0 == motorsExecList.nStopDelayMs )
                  {
                      motorsExecList.nStopDelayMs = MOTOR_STOP_DELAY_MS;
                      motorsExecList.CurrStateNumber++;
                  }
              }
              break;

          case RESP_MOVE_FORWARD:

                motorsExecList.CurrStateNumber++;

              g_nCurrMoveState = MOVE_FWD;
              MotorsMoveFront( DEFAULT_DUTY );
              break;

          case RESP_MOVE_BACKWARD:
              motorsExecList.CurrStateNumber++;
                g_nCurrMoveState = MOVE_BWD;
//                      g_nCurrMoveState = MOVE_FWD;
              MotorsMoveBack( DEFAULT_DUTY );
              break;

          case RESP_MOVE_LEFT:
              motorsExecList.CurrStateNumber++;
              g_nCurrMoveState = MOVE_LEFT;
//                      g_nCurrMoveState = MOVE_RIGHT;
              MotorsMoveLeft( DEFAULT_DUTY );
              break;

          case RESP_MOVE_RIGHT:
              motorsExecList.CurrStateNumber++;
              g_nCurrMoveState = MOVE_RIGHT;
              MotorsMoveRight( DEFAULT_DUTY );
              break;

          case RESP_MOVE_FRONT_LEFT:
              motorsExecList.CurrStateNumber++;

              g_nCurrMoveState = MOVE_FRONT_LEFT;
              MotorsMoveFrontLeft( DEFAULT_DUTY );
              break;

          case RESP_MOVE_BACK_LEFT:
              motorsExecList.CurrStateNumber++;
              g_nCurrMoveState = MOVE_BACK_LEFT;
              MotorsMoveBackLeft( DEFAULT_DUTY );
              break;

          case RESP_MOVE_FRONT_RIGHT:
              motorsExecList.CurrStateNumber++;
              g_nCurrMoveState = MOVE_FRONT_RIGHT;
              MotorsMoveFrontRight( DEFAULT_DUTY );
              break;

          case RESP_MOVE_BACK_RIGHT:
              motorsExecList.CurrStateNumber++;
              g_nCurrMoveState = MOVE_BACK_RIGHT;
              MotorsMoveBackRight( DEFAULT_DUTY );
              break;

          case RESP_ROTATE_RIGHT:
              motorsExecList.CurrStateNumber++;
              g_nCurrMoveState = MOVE_ROTATE_RIGHT;
              MotorsRotateRight( DEFAULT_DUTY );
              break;

          case RESP_ROTATE_LEFT:
              motorsExecList.CurrStateNumber++;
              g_nCurrMoveState = MOVE_ROTATE_LEFT;
              MotorsRotateLeft( DEFAULT_DUTY );
              break;

          default:
              motorsExecList.CurrStateNumber = NULL;
              motorsExecList.PtrMotorListArr = NULL;
              break;
      }
  }
}
}

 
static void IMUTask( void* pvParameters )
{
    EventBits_t eventbits;
    int gnCurrYaw;
    IMU_POLOLU_STS imuSts;

    IMU_PWR_OFF( );
    vTaskDelay( 100 );
    IMU_PWR_ON( );
    vTaskDelay( 100 );
    main_I2cInit( );
    vTaskDelay( 100 );

    imuSts =
    ImuPololuInit( &g_I2cHandle, &g_Timer9Handle, TIMER9_TICK_HZ, 100 );
    ASSERT( IMU_POLOLU_STS_OK == imuSts );
    TRACE( "\n\rIMU OK\r\n" );

    ImuInit( FALSE );

    /* timestamp is being used to sample */
    // ImuSetSampleRate( 50.0f );

    g_nImuCalCount = 20;

    for( ;; )
    {
      main_ImuUpdate( ); //To calibrate and Compute yaw value

    if(motorsExecList.PtrMotorListArr ==0)
    {
     gnCurrYaw = (int)( g_dYaw * 100 );

        if( abs( gnCurrYaw ) > g_nThresholdYaw )
        {
            if(xSemaphoreTake( xSemaphoreIMU, 0 )  ==  pdTRUE)//Take resource when nothing else in use
            {
                  g_nThresholdYaw = 50;

                if( MOVE_STOP != g_nCurrMoveState )
                {
                      MotorsStop( );
                    MotorsPIDReset( );
                    //MotorsPIDReset( );
           
                    if( gnCurrYaw > 0 )
                    {
                        MotorsRotateRight( 8 );
                        //MotorsRotateLeft( 8 );

                    }
                    else
                    {
                        MotorsRotateLeft( 8 );
                       // MotorsRotateRight( 8 );
                    }
                }
                else
                {
                    if( gnCurrYaw > 0 )
                    {
                        MotorsRotateRight( 8 );
                    }
                    else
                    {
                        MotorsRotateLeft( 8 );
                    }
                }

                g_bImuAdjusted = TRUE;

                vTaskDelay( 10 );
//                vTaskDelay(50 );

                xSemaphoreGive( xSemaphoreIMU ); //Release resource once done
            }
        }

        else
        {
            if( g_bImuAdjusted == TRUE )
            {
                IMU_after_Ajustment( );
            }
        }
    }

    vTaskDelay( 20 );
  }
}

static void USonicTask( void* pvParameters )
{
    EventBits_t eventbits;
    USonicTrigger( &g_USHandles[0] );

    for( ;; )
    {
        eventbits = xEventGroupWaitBits( g_evtUSonicHandle,
                                       EVT_USONIC1_DONE | EVT_USONIC2_DONE |
                                       EVT_USONIC3_DONE | EVT_USONIC4_DONE |
                                       EVT_USONIC5_DONE | EVT_USONIC6_DONE |
                                       EVT_USONIC7_DONE | EVT_USONIC8_DONE,
                                       pdTRUE, pdFALSE, portMAX_DELAY );

          if( 0 == eventbits )
        {
            continue;
        }

        if( 0 != ( eventbits & EVT_USONIC1_DONE ) )
        {
            USonic_Main1_Completed( );
        }
        if( 0 != ( eventbits & EVT_USONIC2_DONE ) )
        {
            USonic_Main2_Completed( );
        }
           if( 0 != ( eventbits & EVT_USONIC3_DONE ) )
        {
            USonic_Main3_Completed( );
        }
        if( 0 != ( eventbits & EVT_USONIC4_DONE ) )
        {
            USonic_Main4_Completed( );
        }
        if( 0 != ( eventbits & EVT_USONIC5_DONE ) )
        {
            USonic_Main5_Completed( );
        }
        if( 0 != ( eventbits & EVT_USONIC6_DONE ) )
        {
            USonic_Main6_Completed( );
        }
        if( 0 != ( eventbits & EVT_USONIC7_DONE ) )
        {
            USonic_Main7_Completed( );
        }
        if( 0 != ( eventbits & EVT_USONIC8_DONE ) )
        {
            USonic_Main8_Completed( );
        }
 

          SerialWriteEx( &g_BtUartHandle, g_DevInfoPkt.aResp,
                       sizeof( g_DevInfoPkt.aResp ) );

        xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE, pdFALSE,
                             100 );

        /* working algo to detect and stop movement of vehicle */
        USonic_Main( );

        /* partical working algo to detect and by-psss obstacle  */
        // main_USONIC_OBS_Avoid( );

        vTaskDelay( 10 );
    }
}

static void EncoderTask( void* pvParameters )
{
    EventBits_t eventbits;
 
  MotorsStop( );
  g_nCurrMoveState = MOVE_STOP;

  for( ;; )
  {
    eventbits = xEventGroupWaitBits( g_evtEncHandle, EVT_ENC_DONE1, pdTRUE,
                                   pdFALSE, portMAX_DELAY );

    if( 0 == eventbits )
    {
        continue;
    }

    if( 0 != ( eventbits & EVT_ENC_DONE1 ) )
    {
        main_CtrlUpdateWheelSpeed( );

        if(  xSemaphoreTake( xSemaphoreIMU, 0 ) == pdTRUE )
        {
            switch( g_nCurrMoveState )
            {
                case MOVE_FRONT_LEFT:
                case MOVE_BACK_RIGHT:
                    g_aRpm[0] = 0;
                    g_aRpm[2] = 0;
                    if( ( 0 != g_aRpm[1] ) && ( 0 != g_aRpm[3] ) )
                    {
                        MotorsRunPID( 1, g_aRpm[1] );
                        MotorsRunPID( 3, g_aRpm[3] );
                    }
                    break;

                case MOVE_FRONT_RIGHT:
                case MOVE_BACK_LEFT:
                    g_aRpm[1] = 0;
                    g_aRpm[3] = 0;
                    if( ( 0 != g_aRpm[0] ) && ( 0 != g_aRpm[2] ) )
                    {
                        MotorsRunPID( 0, g_aRpm[0] );
                        MotorsRunPID( 2, g_aRpm[2] );
                    }
                    break;

                default:
                    if( ( 0 != g_aRpm[0] ) && ( 0 != g_aRpm[1] ) &&
                        ( 0 != g_aRpm[2] ) && ( 0 != g_aRpm[3] ) )
                    {
                        MotorsRunPID( 0, g_aRpm[0] );
                        MotorsRunPID( 1, g_aRpm[1] );
                        MotorsRunPID( 2, g_aRpm[2] );
                        MotorsRunPID( 3, g_aRpm[3] );
                    }
                    break;
            }

            xSemaphoreGive( xSemaphoreIMU );
        }
    }
}
}

static void LcdTask( void* pvParameters )
{
    EventBits_t eventbits;
    portBASE_TYPE xStatus;
    HOST_REQ_PKT pkt;

    /* Trigger event for first time since LCD is free and no activity is going
     * on */
    xEventGroupSetBits( g_evtLcdHandle, EVT_LCD_FREE | EVT_LCD_BLOCK_DONE );

    /* Runtime for loop */
    for( ;; )
    {
        /* NOTE:
         Wait event is a blocking call. It will be blocked until any event is
         triggered
        */
        eventbits =
        xEventGroupWaitBits( g_evtLcdHandle, EVT_LCD_FREE | EVT_LCD_BLOCK_DONE,
                             pdTRUE, pdFALSE, portMAX_DELAY );

        if( 0 == eventbits )
        {
            /* If event is triggered without any bit set, it is due to
             timeout. Just continue to wait */

            continue;
        }

        if( 0 != ( eventbits & EVT_LCD_FREE ) )
        {
 
        }

        /* Draw every block.Consume less time  */
        GUI_Draw_Exe( );
        vTaskDelay( 10 );
    }
}


static void TermTask( void* pvParameters )
{
    BOOL toggle = FALSE;
    char* cmd;
    EventBits_t eventbits;
    BaseType_t res;

    for( ;; )
    {
        eventbits = xEventGroupWaitBits( g_evtUartHandle, EVT_UART_ON_RX, pdTRUE,
                                       pdFALSE, portMAX_DELAY );

        if( 0 == eventbits )
        {
            /* If event is triggered without any bit set, it is due to
             timeout. Just continue to wait */
            continue;
        }

        /* When UART event is triggered, it means UART rx is ready to read. Make
        sure to read the UART until it is empty because event only will be
        triggered again when UART rx receive the first byte. This is the
        Serial.c driver behavior */
        for( ;; )
        {
            cmd = TerminalParse( &g_BtUartHandle );
            if( 0 != cmd )
            {

                res = xSemaphoreTake( xSemaphoreIMU, 0 );

                Host_control_Execution( cmd );

                if( pdTRUE == res )
                {
                    xSemaphoreGive( xSemaphoreIMU );
                }
 
            }
            else
            {
                /* No packet was found. exit */
                break;
            }
        }
    }
}


/*****************************************************************************
 Callback functions
******************************************************************************/
void GUI_AppDraw( BOOL bFrameStart )
{
    if( TRUE == bFrameStart )
    {
         sprintf( g_aStrLcdBuf,
                     "B1: %.2f\r\nB2: %.2f\r\nB3: %.2f\r\nX-Cord: "
                     "%.2f\r\nY-Cord: %.2f\r\n",
                     IPSGetDistance( 0 ), IPSGetDistance( 1 ),
                     IPSGetDistance( 2 ),g_nCurrentCoordinate[0],g_nCurrentCoordinate[1]);

//    if (0 != g_nImuCalCount) {
//      sprintf(
//          g_aStrbuf,
//          "DO NOT MOVE.\r\nCalibrating...\r\n %d",
//          g_nImuCalCount);
//    } else {
//      sprintf(
//          g_aStrbuf,
//          "Roll:%.2f\r\nYaw:%.2f\r\nPitch:%.2f",
//          g_dRoll,
//          g_dYaw,
//          g_dPitch);
//    }
    }
 
        GUI_Clear( ClrBlueViolet );
        
        GUI_PrintString( g_aStrLcdBuf, ClrWhite, 1, 10 );
}

static void main_cbEncoderRdy( void )
{
    BaseType_t xHigherPriorityTaskWoken, xResult;
    xResult = xEventGroupSetBitsFromISR( g_evtEncHandle, EVT_ENC_DONE1,
                                         &xHigherPriorityTaskWoken );

    /* Was the message posted successfully? */
    if( xResult != pdFAIL )
    {
        /* If xHigherPriorityTaskWoken is now set to pdTRUE then a context
        switch should be requested.  The macro used is port specific and will
        be either portYIELD_FROM_ISR() or portEND_SWITCHING_ISR() - refer to
        the documentation page for the port being used. */
        portYIELD_FROM_ISR( xHigherPriorityTaskWoken );
    }
}

static void main_cbLcdBlockComplete( void )
{
    /* For each block of LCD data, it is direct call from SPI interrupt */

    BaseType_t xHigherPriorityTaskWoken, xResult;
    xResult = xEventGroupSetBitsFromISR( g_evtLcdHandle, EVT_LCD_BLOCK_DONE,
                                         &xHigherPriorityTaskWoken );


    /* Was the message posted successfully? */
    if( xResult != pdFAIL )
    {
        /* If xHigherPriorityTaskWoken is now set to pdTRUE then a context
        switch should be requested.  The macro used is port specific and will
        be either portYIELD_FROM_ISR() or portEND_SWITCHING_ISR() - refer to
        the documentation page for the port being used. */
        portYIELD_FROM_ISR( xHigherPriorityTaskWoken );
    }
}


static void main_cbGuiFrameEnd( void )
{
    xEventGroupSetBits( g_evtLcdHandle, EVT_LCD_FREE );
}


static void main_cbBtUartOnRx( void )
{
    BaseType_t xHigherPriorityTaskWoken, xResult;
    xResult = xEventGroupSetBitsFromISR( g_evtUartHandle, EVT_UART_ON_RX,
                                         &xHigherPriorityTaskWoken );

    /* Was the message posted successfully? */
    if( xResult != pdFAIL )
    {
        /* If xHigherPriorityTaskWoken is now set to pdTRUE then a context
        switch should be requested.  The macro used is port specific and will
        be either portYIELD_FROM_ISR() or portEND_SWITCHING_ISR() - refer to
        the documentation page for the port being used. */
        portYIELD_FROM_ISR( xHigherPriorityTaskWoken );
    }
}


static void main_cbBtUartOnTx( void )
{

    BaseType_t xHigherPriorityTaskWoken, xResult;
    xResult = xEventGroupSetBitsFromISR( g_evtIPSHandle, EVT_UART_ON_TX,
                                         &xHigherPriorityTaskWoken );

    /* Was the message posted successfully? */
    if( xResult != pdFAIL )
    {
        /* If xHigherPriorityTaskWoken is now set to pdTRUE then a context
        switch should be requested.  The macro used is port specific and will
        be either portYIELD_FROM_ISR() or portEND_SWITCHING_ISR() - refer to
        the documentation page for the port being used. */
        portYIELD_FROM_ISR( xHigherPriorityTaskWoken );
    }
}


static void main_cbUS1OnTrigger( BOOL bON )
{
    US1_TRIG_SET( bON );
}

static void main_cbUS2OnTrigger( BOOL bON )
{
    US2_TRIG_SET( bON );
}

static void main_cbUS3OnTrigger( BOOL bON )
{
    US3_TRIG_SET( bON );
}

static void main_cbUS4OnTrigger( BOOL bON )
{
    US4_TRIG_SET( bON );
}

static void main_cbUS5OnTrigger( BOOL bON )
{
    US5_TRIG_SET( bON );
}

static void main_cbUS6OnTrigger( BOOL bON )
{
    US6_TRIG_SET( bON );
}

static void main_cbUS7OnTrigger( BOOL bON )
{
    US7_TRIG_SET( bON );
}

static void main_cbUS8OnTrigger( BOOL bON )
{
    US8_TRIG_SET( bON );
}

static void main_cbUS1OnReady( void )
{

    BaseType_t xHigherPriorityTaskWoken;
    g_UsonicState.b.bUS1 = TRUE;
    xEventGroupSetBitsFromISR( g_evtUSonicHandle, EVT_USONIC1_DONE,
                               &xHigherPriorityTaskWoken );
}

static void main_cbUS2OnReady( void )
{

    BaseType_t xHigherPriorityTaskWoken;
    g_UsonicState.b.bUS2 = TRUE;
    xEventGroupSetBitsFromISR( g_evtUSonicHandle, EVT_USONIC2_DONE,
                               &xHigherPriorityTaskWoken );
}

static void main_cbUS3OnReady( void )
{

    BaseType_t xHigherPriorityTaskWoken;
    g_UsonicState.b.bUS3 = TRUE;
    xEventGroupSetBitsFromISR( g_evtUSonicHandle, EVT_USONIC3_DONE,
                               &xHigherPriorityTaskWoken );
}

static void main_cbUS4OnReady( void )
{

    BaseType_t xHigherPriorityTaskWoken;
    g_UsonicState.b.bUS4 = TRUE;
    xEventGroupSetBitsFromISR( g_evtUSonicHandle, EVT_USONIC4_DONE,
                               &xHigherPriorityTaskWoken );
}

static void main_cbUS5OnReady( void )
{

    BaseType_t xHigherPriorityTaskWoken;
    g_UsonicState.b.bUS5 = TRUE;
    xEventGroupSetBitsFromISR( g_evtUSonicHandle, EVT_USONIC5_DONE,
                               &xHigherPriorityTaskWoken );
}

static void main_cbUS6OnReady( void )
{

    BaseType_t xHigherPriorityTaskWoken;
    g_UsonicState.b.bUS6 = TRUE;
    xEventGroupSetBitsFromISR( g_evtUSonicHandle, EVT_USONIC6_DONE,
                               &xHigherPriorityTaskWoken );
}

static void main_cbUS7OnReady( void )
{

    BaseType_t xHigherPriorityTaskWoken;
    g_UsonicState.b.bUS7 = TRUE;
    xEventGroupSetBitsFromISR( g_evtUSonicHandle, EVT_USONIC7_DONE,
                               &xHigherPriorityTaskWoken );
}

static void main_cbUS8OnReady( void )
{

    BaseType_t xHigherPriorityTaskWoken;
    g_UsonicState.b.bUS8 = TRUE;
    xEventGroupSetBitsFromISR( g_evtUSonicHandle, EVT_USONIC8_DONE,
                               &xHigherPriorityTaskWoken );
}


/*****************************************************************************
 Local functions
******************************************************************************/
static void main_SpimInit( void )
{
    int res;

    res = DmaInit( &g_Dma1Spi2TxHandle, 1, DMA1_SPI2_TX_CH, 0,
                   DMA_DIR_MEM_TO_PERI, DMA_MEM_INC_EN, DMA_DATA_ALIGN_BYTE,
                   DMA_PERI_INC_DIS, DMA_DATA_ALIGN_BYTE );
    ASSERT( DMA_OK == res );

    res = DmaInit( &g_Dma1Spi2RxHandle, 1, DMA1_SPI2_RX_CH, 0,
                   DMA_DIR_PERI_TO_MEM, DMA_MEM_INC_DIS, DMA_DATA_ALIGN_BYTE,
                   DMA_PERI_INC_DIS, DMA_DATA_ALIGN_BYTE );
    ASSERT( DMA_OK == res );

    /* LCD SPI */
    SpimInit( &g_SpimLcdHandle, 2, 25000000, SPI_CLK_INACT_LOW,
              SPI_CLK_RISING_EDGE, SPI_DATA_SIZE_8 );


    /* UWB SPI */
    SpimInit( &g_SpimUWBHandle, 1, 1000000, SPI_CLK_INACT_LOW,
              SPI_CLK_RISING_EDGE, SPI_DATA_SIZE_8 );
    /* Link  SPI to DMA */
    SpimLinkDMA( &g_SpimLcdHandle, &g_Dma1Spi2TxHandle, &g_Dma1Spi2RxHandle );
}


static void main_UartInit( void )
{
    /* This USART2 is assigned for Command interpreter(shell) use */
    int res;

    NVIC_SetPriority( USART2_IRQn, 0x09 );

    res = SerialInit( &g_BtUartHandle, &STM32F722X_USART_DRV, 2U, /* BT USART */
                      921600 );
    ASSERT( res == UART_STS_OK );

    SerialBuffer( &g_BtUartHandle, g_aBtUartTxBuf, sizeof( g_aBtUartTxBuf ),
                  g_aBtUartRxBuf, sizeof( g_aBtUartRxBuf ) );

    res = SerialConfig( &g_BtUartHandle, UART_BITS_8, UART_NONE, UART_ONE );
    ASSERT( res == UART_STS_OK );

    SerialAddCallback( &g_BtUartHandle, main_cbBtUartOnTx, main_cbBtUartOnRx );
}

static void main_LcdInit( void )
{
    int screenx;
    int screeny;
    int res;

    /* g_SpimLcdHandle shall be initialized before using it */

    /* Choosing a landscape orientation */
    LcdInit( &g_SpimLcdHandle, LCD_POTRAIT );

    /* Get physical LCD size in pixels */
    LCD_GetSize( &screenx, &screeny );

    /* Initialize GUI */
    GUI_Init( &g_MemDev, screenx, screeny, g_aBuf, sizeof( g_aBuf ) );


    res =
    DmaInit( &g_Dma1Spi2TxHandle, 1, DMA1_SPI2_TX_CH, 0, DMA_DIR_MEM_TO_PERI,
             DMA_MEM_INC_EN, DMA_DATA_ALIGN_HALF_WORD, DMA_PERI_INC_DIS,
             DMA_DATA_ALIGN_HALF_WORD );
    ASSERT( DMA_OK == res );

    res =
    DmaInit( &g_Dma1Spi2RxHandle, 1, DMA1_SPI2_RX_CH, 0, DMA_DIR_PERI_TO_MEM,
             DMA_MEM_INC_DIS, DMA_DATA_ALIGN_HALF_WORD, DMA_PERI_INC_DIS,
             DMA_DATA_ALIGN_HALF_WORD );
    ASSERT( DMA_OK == res );


    GUI_16BitPerPixel( TRUE );

    /* Switch to transfer word for faster performance */
    SpimSetDataSize( &g_SpimLcdHandle, SPI_DATA_SIZE_16 );
    /* Clear LCD screen to Blue */
    GUI_Clear( ClrBlue );

    /* set font color background */
    GUI_SetFontBackColor( ClrBlueViolet );

    /* Set font */
   // GUI_SetFont( GUI_ARIMO20_FONT );

    LCD_AddCallback( main_cbLcdBlockComplete );

    GUI_AddCbFrameEnd( main_cbGuiFrameEnd );

    /* Backlight ON */
    LCD_BL_ON( );
}

static void main_EncodersInit( void )
{
    int res;
    res = CCMInit( &g_Ccm1Handle, 1U );
    ASSERT( CCM_OK == res );

    res = CCMInit( &g_Ccm2Handle, 3U );
    ASSERT( CCM_OK == res );

    res = CCMInit( &g_Ccm3Handle, 2U );
    ASSERT( CCM_OK == res );

    res = CCMInit( &g_Ccm4Handle, 4U );
    ASSERT( CCM_OK == res );

    CCMEncoderMode( &g_Ccm1Handle, CCM_ENC_INPUT_AB );
    CCMEncoderMode( &g_Ccm2Handle, CCM_ENC_INPUT_AB );
    CCMEncoderMode( &g_Ccm3Handle, CCM_ENC_INPUT_AB );
    CCMEncoderMode( &g_Ccm4Handle, CCM_ENC_INPUT_AB );

    ShaftEncoderInit( &g_Timer9Handle, TIMER9_TICK_HZ, main_cbEncoderRdy,
                      g_nSmplInterval );
    ShaftEncoderCfg( 64, 70, g_nSmplInterval );

    /* Add 4 available encoders */
    ShaftEncoderAdd( &g_ShaftEncHandles[0], 0, 0 );
    ShaftEncoderAdd( &g_ShaftEncHandles[1], 1, 0 );
    ShaftEncoderAdd( &g_ShaftEncHandles[2], 2, 0 );
    ShaftEncoderAdd( &g_ShaftEncHandles[3], 3, 0 );

    ShaftEncoderLinkCCM( &g_ShaftEncHandles[0], &g_Ccm1Handle );
    ShaftEncoderLinkCCM( &g_ShaftEncHandles[1], &g_Ccm2Handle );
    ShaftEncoderLinkCCM( &g_ShaftEncHandles[2], &g_Ccm3Handle );
    ShaftEncoderLinkCCM( &g_ShaftEncHandles[3], &g_Ccm4Handle );
}

static void main_CtrlUpdateWheelSpeed( void )
{
    int rpm;
    int cnt;

    // TRACE("Encoder : ");
    for( cnt = 0; cnt < TOTAL_MOTOR; cnt++ )
    {
        rpm = ShaftEncoderReadRPM( &g_ShaftEncHandles[cnt] );
        readPWM[cnt] = MotorReadPWM( cnt );

        // TRACE("%d ", rpm);

        if( rpm < 0 )
        {
            rpm = -rpm;
        }

        g_aRpm[cnt] = rpm;
    }
    // TRACE("\n");
    if( g_nCurrMoveState != MOVE_STOP )
    {
        g_DevInfoPkt.Param.STX = CMD_STX;
        g_DevInfoPkt.Param.Cmd = RESP_DEV_SPEED;
        g_DevInfoPkt.Param.Speed1 = g_aRpm[0];
        g_DevInfoPkt.Param.Speed2 = g_aRpm[1];
        g_DevInfoPkt.Param.Speed3 = g_aRpm[2];
        g_DevInfoPkt.Param.Speed4 = g_aRpm[3];
        g_DevInfoPkt.Param.Pitch = ( int16_t )( ( int32_t )( g_dPitch * 100 ) );
        g_DevInfoPkt.Param.Roll = ( int16_t )( ( int32_t )( g_dRoll * 100 ) );
        g_DevInfoPkt.Param.Yaw = ( int16_t )( ( int32_t )( g_dYaw * 100 ) );
        g_DevInfoPkt.Param.ETX = CMD_ETX;

        SerialWriteEx( &g_BtUartHandle, g_DevInfoPkt.aResp,
                       sizeof( g_DevInfoPkt.aResp ) );


        xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE, pdFALSE,
                             portMAX_DELAY );

//        g_DevInfoPkt.PulseWidthMod.STX = CMD_STX;
//        g_DevInfoPkt.PulseWidthMod.Cmd = RESP_DEV_PWM;
//        g_DevInfoPkt.PulseWidthMod.Pwm1 = readPWM[0];
//        g_DevInfoPkt.PulseWidthMod.Pwm2 = readPWM[1];
//        g_DevInfoPkt.PulseWidthMod.Pwm3 = readPWM[2];
//        g_DevInfoPkt.PulseWidthMod.Pwm4 = readPWM[3];
//        g_DevInfoPkt.PulseWidthMod.ETX = CMD_ETX;
//
//        SerialWriteEx( &g_BtUartHandle, g_DevInfoPkt.aResp,
//                       sizeof( g_DevInfoPkt.aResp ) );
//
//
//        xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE, pdFALSE,
//                             100 );
    }
}


static void USonic_Main1_Completed( void )
{
    if( FALSE != g_UsonicState.b.bUS1 )
    {
        g_UsonicState.b.bUS1 = FALSE;
        g_aUsonicDist[0] = USonicRead( &g_USHandles[0] );
        // TRACE("\n\rUS1 value:%d\n\r", g_aUsonicDist[0]);
        if( g_aUsonicDist[0] < SENSOR_DIST )
        {
            g_Usonicstat.sensor0 = TRUE;
            g_sensor_number = 1;
        }
        else
        {
            g_Usonicstat.sensor0 = FALSE;
            g_sensor_number = 0;
        }
        USonicTrigger( &g_USHandles[1] );
    }
}

static void USonic_Main2_Completed( void )
{
    if( FALSE != g_UsonicState.b.bUS2 )
    {
        g_UsonicState.b.bUS2 = FALSE;
        g_aUsonicDist[1] = USonicRead( &g_USHandles[1] );
        if( g_aUsonicDist[1] < SENSOR_DIST )
        {
            g_Usonicstat.sensor1 = TRUE;
            g_sensor_number = 2;
        }
        else
        {
            g_Usonicstat.sensor1 = FALSE;
            g_sensor_number = 0;
        }
        // TRACE("US2 value:%d\n\r", g_aUsonicDist[1]);
        USonicTrigger( &g_USHandles[2] );
    }
}

static void USonic_Main3_Completed( void )
{
    if( FALSE != g_UsonicState.b.bUS3 )
    {
        g_UsonicState.b.bUS3 = FALSE;
        g_aUsonicDist[2] = USonicRead( &g_USHandles[2] );
        if( g_aUsonicDist[2] < SENSOR_DIST )
        {
            g_Usonicstat.sensor2 = TRUE;
            g_sensor_number = 3;
        }
        else
        {
            g_Usonicstat.sensor2 = FALSE;
            g_sensor_number = 0;
        }
        // TRACE("US3 value:%d\n\r", g_aUsonicDist[2]);
        USonicTrigger( &g_USHandles[3] );
    }
}

static void USonic_Main4_Completed( void )
{
    if( FALSE != g_UsonicState.b.bUS4 )
    {
        g_UsonicState.b.bUS4 = FALSE;
        g_aUsonicDist[3] = USonicRead( &g_USHandles[3] );
        if( g_aUsonicDist[3] < SENSOR_DIST )
        {
            g_Usonicstat.sensor3 = TRUE;
            g_sensor_number = 4;
        }
        else
        {
            g_Usonicstat.sensor3 = FALSE;
            g_sensor_number = 0;
        }
        // TRACE("US4 value:%d\n\r", g_aUsonicDist[3]);
        USonicTrigger( &g_USHandles[4] );
    }
}

static void USonic_Main5_Completed( void )
{
    if( FALSE != g_UsonicState.b.bUS5 )
    {
        g_UsonicState.b.bUS5 = FALSE;
        g_aUsonicDist[4] = USonicRead( &g_USHandles[4] );
        if( g_aUsonicDist[4] < SENSOR_DIST )
        {
            g_Usonicstat.sensor4 = TRUE;
            g_sensor_number = 5;
        }
        else
        {
            g_Usonicstat.sensor4 = FALSE;
            g_sensor_number = 0;
        }
        // TRACE("US5 value:%d\n", g_aUsonicDist[4]);
        USonicTrigger( &g_USHandles[5] );
    }
}

static void USonic_Main6_Completed( void )
{
    if( FALSE != g_UsonicState.b.bUS6 )
    {
        g_UsonicState.b.bUS6 = FALSE;
        g_aUsonicDist[5] = USonicRead( &g_USHandles[5] );
        if( g_aUsonicDist[5] < SENSOR_DIST )
        {
            g_Usonicstat.sensor5 = TRUE;
            g_sensor_number = 6;
        }
        else
        {
            g_Usonicstat.sensor5 = FALSE;
            g_sensor_number = 0;
        }
        // TRACE("US6 value:%d\n", g_aUsonicDist[5]);
        USonicTrigger( &g_USHandles[6] );
    }
}

static void USonic_Main7_Completed( void )
{
    if( FALSE != g_UsonicState.b.bUS7 )
    {
        g_UsonicState.b.bUS7 = FALSE;
        g_aUsonicDist[6] = USonicRead( &g_USHandles[6] );
        if( g_aUsonicDist[6] < SENSOR_DIST )
        {
            g_Usonicstat.sensor6 = TRUE;
            g_sensor_number = 7;
        }
        else
        {
            g_Usonicstat.sensor6 = FALSE;
            g_sensor_number = 0;
        }
        // TRACE("US7 value:%d\n", g_aUsonicDist[6]);
        USonicTrigger( &g_USHandles[7] );
    }
}

static void USonic_Main8_Completed( void )
{
    if( FALSE != g_UsonicState.b.bUS8 )
    {
        g_UsonicState.b.bUS8 = FALSE;
        g_aUsonicDist[7] = USonicRead( &g_USHandles[7] );
        if( g_aUsonicDist[7] < SENSOR_DIST )
        {
            g_Usonicstat.sensor7 = TRUE;
            g_sensor_number = 8;
        }
        else
        {
            g_Usonicstat.sensor7 = FALSE;
            g_sensor_number = 0;
        }
        // TRACE("US8 value:%d\n", g_aUsonicDist[7]);
        USonicTrigger( &g_USHandles[0] );
    }
}


static void main_USoundInit( void )
{
    USonicInit( &g_Timer9Handle, TIMER9_TICK_HZ );

    /* Add a callback to get notify when ultrasonic sensor is ready to read */
    UsonicAddDevice( &g_USHandles[0], 0U, main_cbUS1OnTrigger,
                     main_cbUS1OnReady );
    UsonicAddDevice( &g_USHandles[1], 1U, main_cbUS2OnTrigger,
                     main_cbUS2OnReady );
    UsonicAddDevice( &g_USHandles[2], 2U, main_cbUS3OnTrigger,
                     main_cbUS3OnReady );
    UsonicAddDevice( &g_USHandles[3], 3U, main_cbUS4OnTrigger,
                     main_cbUS4OnReady );
    UsonicAddDevice( &g_USHandles[4], 4U, main_cbUS5OnTrigger,
                     main_cbUS5OnReady );
    UsonicAddDevice( &g_USHandles[5], 5U, main_cbUS6OnTrigger,
                     main_cbUS6OnReady );
    UsonicAddDevice( &g_USHandles[6], 6U, main_cbUS7OnTrigger,
                     main_cbUS7OnReady );
    UsonicAddDevice( &g_USHandles[7], 7U, main_cbUS8OnTrigger,
                     main_cbUS8OnReady );

    /* by default all usonic stat is set to zero*/
    g_Usonicstat.sensor0 = FALSE;
    g_Usonicstat.sensor1 = FALSE;
    g_Usonicstat.sensor2 = FALSE;
    g_Usonicstat.sensor3 = FALSE;
    g_Usonicstat.sensor4 = FALSE;
    g_Usonicstat.sensor5 = FALSE;
    g_Usonicstat.sensor6 = FALSE;
    g_Usonicstat.sensor7 = FALSE;

    g_Usonicstat.sensor0_OBS = FALSE;
    g_Usonicstat.sensor1_OBS = FALSE;
    g_Usonicstat.sensor2_OBS = FALSE;
    g_Usonicstat.sensor3_OBS = FALSE;
    g_Usonicstat.sensor4_OBS = FALSE;
    g_Usonicstat.sensor5_OBS = FALSE;
    g_Usonicstat.sensor6_OBS = FALSE;
    g_Usonicstat.sensor7_OBS = FALSE;

 
}


static void main_I2cInit( void )
{
    int res;

    res = I2cInit( &g_I2cHandle, 1, 400000U );
    ASSERT( I2C_STS_OK == res );
}

static float main_convertRawAcceleration( int16_t nRaw )
{
    float a = (float)( (int32_t)nRaw ) * 0.000061f;
    return a;
}

static float main_convertRawGyro( int16_t nRaw )
{
    float g = (float)( (int32_t)nRaw ) * 0.00875f;
    return g;
}

static float main_convertRawMag( int nRaw )
{
    float g = (float)( (int32_t)nRaw ) / 6842.0f;
    return g;
}

static void main_ImuUpdate( void )
{
    IMU_POLOLU_STS imuSts;
    IMU_DATA data;
    int16_t gx;
    int16_t gy;
    int16_t gz;
    int timestamp = g_nTimestamp;

    imuSts = ImuPololuReadData( &g_ImuData );

    if( IMU_POLOLU_STS_OK == imuSts )
    {
        /* Calibration will happen if g_nImuCalCount is none zero */
        if( 0 != g_nImuCalCount )
        {
            g_nImuCalCount--;
            if( 0 == g_nImuCalCount )
            {
                g_aImuOffset[0] = g_ImuData.nGyroX;
                g_aImuOffset[1] = g_ImuData.nGyroY;
                g_aImuOffset[2] = g_ImuData.nGyroZ;

                TRACE( "IMU calibrated\r\n" );

                g_nImuSync = 5;
            }
            else
            {
                /* Calibration Offset have not yet done */
                return;
            }
        }
#if 0
            TRACE( "Accl: %d %d %d  Gyro: %d %d %d\r\n", 
                g_ImuData.nAcclX,
                g_ImuData.nAcclY,
                g_ImuData.nAcclZ,
                g_ImuData.nGyroX,
                g_ImuData.nGyroY,
                g_ImuData.nGyroZ );
#endif

        if( 0 != g_nImuSync )
        {
            g_nImuSync--;
            g_nTimestamp = 0;
            return;
        }

        gx = g_ImuData.nGyroX;
        if( ABS( g_ImuData.nGyroX - g_aImuOffset[0] ) < 40 )
        {
            gx = g_aImuOffset[0];
        }

        gy = g_ImuData.nGyroY;
        if( ABS( g_ImuData.nGyroY - g_aImuOffset[1] ) < 40 )
        {
            gy = g_aImuOffset[1];
        }

        gz = g_ImuData.nGyroZ;
        if( ABS( g_ImuData.nGyroZ - g_aImuOffset[2] ) < 40 )
        {
            gz = g_aImuOffset[2];
        }

        data.gx = main_convertRawGyro( gx - g_aImuOffset[0] );
        data.gy = main_convertRawGyro( gy - g_aImuOffset[1] );
        data.gz = main_convertRawGyro( gz - g_aImuOffset[2] );
        data.ax = main_convertRawAcceleration( g_ImuData.nAcclX );
        data.ay = main_convertRawAcceleration( g_ImuData.nAcclY );
        data.az = main_convertRawAcceleration( g_ImuData.nAcclZ );

        /* Set timestamp to 0 if using fix sample rate */
        ImuUpdateAcclGyro( &data, timestamp );
        g_nTimestamp = 0;

        ImuComputeResult( &g_dRoll, &g_dPitch, &g_dYaw );
        // TRACE( "%.2f %.2f %.2f, %d\r\n", g_dRoll, g_dPitch, g_dYaw, timestamp
        // );
    }

    else
    {
        LED_BLUE_ON( );
    }

 
}

static void IMU_after_Ajustment( void ) //Carry on with previous movement state after adjustment
{

    g_bImuAdjusted = FALSE;
    g_nThresholdYaw = 100;
     
    MotorsStop( );

    MotorsPIDReset( );
    Motor1SetTargetSpeed( g_nMotorSpeed );
    Motor2SetTargetSpeed( g_nMotorSpeed );
    Motor3SetTargetSpeed( g_nMotorSpeed );
    Motor4SetTargetSpeed( g_nMotorSpeed );

    // MotorsPIDReset( );
    // main_Gracefulstop_Algo();

    switch( g_nCurrMoveState )
    {
        case MOVE_FRONT_LEFT:
            MotorsMoveFrontLeft( DEFAULT_DUTY );
            g_nCurrMoveState = MOVE_FRONT_LEFT;
            break;

        case MOVE_FWD:
            MotorsMoveFront( DEFAULT_DUTY );
            g_nCurrMoveState = MOVE_FWD;
            break;

        case MOVE_FRONT_RIGHT:
            MotorsMoveFrontRight( DEFAULT_DUTY );
            g_nCurrMoveState = MOVE_FRONT_RIGHT;
            break;

        case MOVE_RIGHT:
            Motor4SetTargetSpeed(g_nMotorSpeed);
            MotorsMoveRight( DEFAULT_DUTY );
            g_nCurrMoveState = MOVE_RIGHT;
            break;

        case MOVE_BACK_RIGHT:
            MotorsMoveBackRight( DEFAULT_DUTY );
            g_nCurrMoveState = MOVE_BACK_RIGHT;
            break;

        case MOVE_BWD:
            MotorsMoveBack( DEFAULT_DUTY );
            g_nCurrMoveState = MOVE_BWD;
            break;

        case MOVE_BACK_LEFT:
            MotorsMoveBackLeft( DEFAULT_DUTY );
            g_nCurrMoveState = MOVE_BACK_LEFT;
            break;

        case MOVE_LEFT:
            MotorsMoveLeft( DEFAULT_DUTY );
            g_nCurrMoveState = MOVE_LEFT;
            break;

        case MOVE_STOP:
            MotorsStop( );
            MotorsPIDReset( );
            // main_Gracefulstop_Algo();
            break;

        default:
            break;
    }
}

static BOOL main_Gracefulstop_Algo( void )
{
    BOOL res = FALSE;
    int cutoffspeed = g_nMotorSpeed >> 1;

 
    MotorsSetTargetSpeed( 0 );//Stop gracefully

    if( ( g_aRpm[0] < cutoffspeed ) && ( g_aRpm[1] < cutoffspeed ) &&
        ( g_aRpm[2] < cutoffspeed ) && ( g_aRpm[3] < cutoffspeed ) )
    {
        MotorsStop( );
        MotorsPIDReset( );
        main_EncoderAllReset( );
        MotorsSetTargetSpeed( g_nMotorSpeed );
        res = TRUE;
    }
    return res;
}

static void main_EncoderAllReset( void ) 
{
    g_aRpm[0] = 0;
    g_aRpm[1] = 0;
    g_aRpm[2] = 0;
    g_aRpm[3] = 0;

    ShaftEncoderReset( &g_ShaftEncHandles[0] );
    ShaftEncoderReset( &g_ShaftEncHandles[1] );
    ShaftEncoderReset( &g_ShaftEncHandles[2] );
    ShaftEncoderReset( &g_ShaftEncHandles[3] );
}

static void Host_control_Execution( char* pCmd )
{
  HOST_REQ_PKT* req = (HOST_REQ_PKT*)pCmd;
 
  switch( req->Cmd.Cmd )
  {
      case CMD_HOST_START:
 
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );

          TRACE( " Start\r\n" );
          g_bReportON = FALSE;
          g_bcmdstartONHost = TRUE;
          break;

      case CMD_HOST_RESTORE:
 
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( " Start\r\n" );
          break;

      case CMD_HOST_STOP:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( " STOP\r\n" );
          motorsExecList.PtrMotorListArr = g_aMoveStopJobList;
          motorsExecList.nStopDelayMs = MOTOR_STOP_DELAY_MS;
          motorsExecList.CurrStateNumber = 0;
          g_bReportON = FALSE;
          break;

      case CMD_HOST_REPORT_ON:
          if( 1 == pCmd[1] )
          {
              g_bReportON = TRUE;
          }
          else
          {
              g_bReportON = FALSE;
          }
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          break;

      case CMD_HOST_MOVE_FWD:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( "FWD\r\n" );

          if( 0 != motorsExecList.PtrMotorListArr )
          {
              return;
          }

          motorsExecList.PtrMotorListArr = g_aMoveFrontJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case CMD_HOST_MOVE_BWD:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( "BWD\r\n" );

          motorsExecList.PtrMotorListArr = g_aMoveBackJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case CMD_HOST_MOVE_LEFT:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( " LEFT\r\n" );
          motorsExecList.PtrMotorListArr = g_aMoveLeftJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case CMD_HOST_MOVE_FL:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( "FRONT LEFT\r\n" );
          motorsExecList.PtrMotorListArr = g_aMoveFrontLeftJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case CMD_HOST_MOVE_BL:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( "BACK LEFT\r\n" );
          motorsExecList.PtrMotorListArr = g_aMoveBackLeftJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case CMD_HOST_MOVE_RIGHT:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( "  RIGHT\r\n" );
          motorsExecList.PtrMotorListArr = g_aMoveRightJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case CMD_HOST_MOVE_FR:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( "FRONT RIGHT\r\n" );
          motorsExecList.PtrMotorListArr = g_aMoveFrontRightJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case CMD_HOST_MOVE_BR:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( "BACK RIGHT\r\n" );
          motorsExecList.PtrMotorListArr = g_aMoveBackRightJobList;
          motorsExecList.CurrStateNumber = 0;

          break;

      case CMD_HOST_ROTATE_LEFT:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( "ROTATE LEFT\r\n" );
          motorsExecList.PtrMotorListArr = g_aRotateLeftJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case CMD_HOST_ROTATE_RIGHT:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( "  ROTATE RIGHT\r\n" );
          motorsExecList.PtrMotorListArr = g_aRotateRightJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case CMD_HOST_CHANGE_SPEED:
          g_nMotorSpeed = req->Speed.nCount;
          MotorsSetTargetSpeed( g_nMotorSpeed );
 
 
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          TRACE( "Term Speed changed to %d RPM\r\n", g_nMotorSpeed );
          break;

      case CMD_HOST_CHANGE_PID:
          g_dKP = (double)( (int32_t)req->PID.Kp ) / 100.0;
          g_dKI = (double)( (int32_t)req->PID.Ki ) / 100.0;
          g_dKD = (double)( (int32_t)req->PID.Kd ) / 100.0;

          MotorsSetPIDParams( g_dKP, g_dKI, g_dKD );

          if( g_nSmplInterval != req->PID.Interval )
          {
              g_nSmplInterval = req->PID.Interval;
              ShaftEncoderChangeInterval( g_nSmplInterval );
          }
 
          break;

      case CMD_HOST_MAP_SET:
          TerminalAckToHost( &g_BtUartHandle );
          xEventGroupWaitBits( g_evtIPSHandle, EVT_UART_ON_TX, pdTRUE,
                               pdFALSE, portMAX_DELAY );
          g_SetX_Coord = req->coordinates.x_cor / 100;
          g_SetY_Coord = req->coordinates.y_cor / 100;
          g_nCurrPt2 = req->coordinates.point;
          if( g_nCurrPt2 == 0 )
          {
              g_XYCoordGoal[0] = g_SetX_Coord;
              g_XYCoordGoal[1] = g_SetY_Coord;
          }
          else
          {
              g_XYCoordGoal[g_nCurrPt2 * 2] = g_SetX_Coord;
              g_XYCoordGoal[g_nCurrPt2 * 2 + 1] = g_SetY_Coord;
          }
          // TRACE("%.f\n\r,%.f\n\r", g_SetX_Coord , g_SetY_Coord);
          break;

      default:
          TRACE( "cmd: Invalid\r\n" );
          break;
  }
}
 

static void USonic_Main( void )//Detect which side of vehicle sensors to stop  
{
    switch( g_nCurrMoveState )
    {
        case MOVE_FRONT_LEFT:
            if( ( g_aUsonicDist[0] < SENSOR_DIST ||
                  g_aUsonicDist[1] < SENSOR_DIST ||
                  g_aUsonicDist[7] < SENSOR_DIST ) )
            {
                g_bSensorFlag = TRUE;
            }
            break;

        case MOVE_FWD:
            if( ( g_aUsonicDist[0] < SENSOR_DIST ||
                  g_aUsonicDist[1] < SENSOR_DIST ||
                  g_aUsonicDist[2] < SENSOR_DIST ) )
            {
                g_bSensorFlag = TRUE;
            }

            break;

        case MOVE_FRONT_RIGHT:
            if( ( g_aUsonicDist[1] < SENSOR_DIST ||
                  g_aUsonicDist[2] < SENSOR_DIST ||
                  g_aUsonicDist[3] < SENSOR_DIST ) )
            {
                g_bSensorFlag = TRUE;
            }
            break;

        case MOVE_RIGHT:
            if( ( g_aUsonicDist[2] < SENSOR_DIST ||
                  g_aUsonicDist[3] < SENSOR_DIST ||
                  g_aUsonicDist[4] < SENSOR_DIST ) )
            {
                g_bSensorFlag = TRUE;
            }
            break;

        case MOVE_BACK_RIGHT:
            if( ( g_aUsonicDist[3] < SENSOR_DIST ||
                  g_aUsonicDist[4] < SENSOR_DIST ||
                  g_aUsonicDist[5] < SENSOR_DIST ) )
            {
                g_bSensorFlag = TRUE;
            }
            break;

        case MOVE_BWD:
            if( ( g_aUsonicDist[4] < SENSOR_DIST ||
                  g_aUsonicDist[5] < SENSOR_DIST ||
                  g_aUsonicDist[6] < SENSOR_DIST ) )
            {
                g_bSensorFlag = TRUE;
            }
            break;

        case MOVE_BACK_LEFT:
            if( ( g_aUsonicDist[5] < SENSOR_DIST ||
                  g_aUsonicDist[6] < SENSOR_DIST ||
                  g_aUsonicDist[7] < SENSOR_DIST ) )
            {
                g_bSensorFlag = TRUE;
            }
            break;

        case MOVE_LEFT:
            if( ( g_aUsonicDist[7] < SENSOR_DIST ||
                  g_aUsonicDist[0] < SENSOR_DIST ||
                  g_aUsonicDist[6] < SENSOR_DIST ) )
            {
                g_bSensorFlag = TRUE;
            }
            break;

        case MOVE_STOP:
            if( g_Usonicstat.sensor0 == TRUE || g_Usonicstat.sensor1 == TRUE ||
                g_Usonicstat.sensor2 == TRUE || g_Usonicstat.sensor3 == TRUE ||
                g_Usonicstat.sensor4 == TRUE || g_Usonicstat.sensor5 == TRUE ||
                g_Usonicstat.sensor6 == TRUE || g_Usonicstat.sensor7 == TRUE )
            {}
            else
            {
                g_bSensorFlag = FALSE;
            }
            break;

        default:
            break;
    }

    if( g_bSensorFlag == TRUE )
    {
        if( g_bSensorState == FALSE )
        {
            g_pMoveState = g_nCurrMoveState; /* to save current move state*/
            g_bSensorState = TRUE;
        }

        motorsExecList.PtrMotorListArr = g_aMoveStopJobList;
        motorsExecList.CurrStateNumber = 0;
        PWMEnable( &g_PwmHandle, 1, 50.0, TRUE );
        MOTORS_STOP( );
        MotorsPIDReset( );
        // vTaskDelay( 50 );
    }
    else
    {
        if( g_nCurrMoveState == MOVE_STOP )
        {
            MOTORS_STOP( );
            MotorsPIDReset( );

            if( g_bSensorState == TRUE )
            {
                PWMDisable( &g_PwmHandle, 1 );
                main_USONICPrevState( ); // assign previous movestate to resp list
                g_bSensorState = FALSE;
            }
        }
    }
}

static void main_USONICPrevState( void ) //TO ensure previous state movement is captured and called
{
  switch( g_pMoveState )
  {
       case MOVE_FWD:
          motorsExecList.PtrMotorListArr = g_aMoveFrontJobList;
            motorsExecList.CurrStateNumber = 0;
          break;

      case MOVE_BWD:
      // motorsExecList.PtrMotorListArr = g_aMoveBackJobList;
             motorsExecList.PtrMotorListArr = g_aMoveBackJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case MOVE_BACK_LEFT:
             motorsExecList.PtrMotorListArr = g_aMoveBackLeftJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

       case MOVE_BACK_RIGHT:
          motorsExecList.PtrMotorListArr = g_aMoveBackRightJobList;
            motorsExecList.CurrStateNumber = 0;
          break;

      case MOVE_FRONT_LEFT:
          motorsExecList.PtrMotorListArr = g_aMoveFrontLeftJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case MOVE_FRONT_RIGHT:
          motorsExecList.PtrMotorListArr = g_aMoveFrontRightJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case MOVE_LEFT:
          motorsExecList.PtrMotorListArr = g_aMoveLeftJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case MOVE_RIGHT:
          motorsExecList.PtrMotorListArr = g_aMoveRightJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      case MOVE_STOP:
          motorsExecList.PtrMotorListArr = g_aMoveStopJobList;
          motorsExecList.CurrStateNumber = 0;
          break;

      default:
          break;
  }
}

static void Main_Nav_AlgoInit( void )
{

    g_nAlgoStatus.DiagFlag = 0;
    g_nAlgoStatus.Diag_Move = 0;
    g_nAlgoStatus.XYFlag = 0;
    g_nAlgoStatus.Mov1Flag = 0;
    g_nAlgoStatus.Mov2Flag = 0;
     g_nAlgoStatus.Mov3Flag = 0;
    g_nAlgoStatus.Mov4Flag = 0;
    g_nAlgoStatus.Mov5Flag = 0;
    g_nAlgoStatus.Mov6Flag = 0;
    g_nAlgoStatus.Mov7Flag = 0;
    g_nAlgoStatus.Mov8Flag = 0;
    g_nAlgoStatus.MovestateFlag = 0;
    g_nAlgoStatus.MovStopFlag = 0;
 
}

void CallChangeState( MOVE_STATE_NUM gnMoveNum ) 
{
    if( gnMoveNum == MOVE_FWD )
    {
        if( g_nAlgoStatus.MovestateFlag != 1 )
        {
            MotorsPIDReset( );
//            Motor1SetTargetSpeed(g_nMotorSpeed+5);
            motorsExecList.PtrMotorListArr = g_aMoveFrontJobList; //ptrMotorArr points to move front
            motorsExecList.CurrStateNumber = 0;
            g_nAlgoStatus.MovestateFlag = 1;
        }
    }

    else if( gnMoveNum == MOVE_BWD )
    {
        if( g_nAlgoStatus.MovestateFlag != 2 )
        {
            MotorsPIDReset( );
            Motor2SetTargetSpeed(PID_TARGET_DEFAULT_RPM);
//           Motor4SetTargetSpeed(g_nMotorSpeed+5);

            motorsExecList.PtrMotorListArr = g_aMoveBackJobList;
            motorsExecList.CurrStateNumber = 0;
            g_nAlgoStatus.MovestateFlag = 2;
        }
    }

    else if( gnMoveNum == MOVE_BACK_LEFT )
    {
        if( g_nAlgoStatus.MovestateFlag != 3 )
        {
            MotorsPIDReset( );
            motorsExecList.PtrMotorListArr = g_aMoveBackLeftJobList;
            motorsExecList.CurrStateNumber = 0;
            g_nAlgoStatus.MovestateFlag = 3;
        }
    }

    else if( gnMoveNum == MOVE_BACK_RIGHT )
    {
        if( g_nAlgoStatus.MovestateFlag != 4 )
        {
            MotorsPIDReset( );
 //            Motor3SetTargetSpeed(g_nMotorSpeed+5);

            motorsExecList.PtrMotorListArr = g_aMoveBackRightJobList;
            motorsExecList.CurrStateNumber = 0;
            g_nAlgoStatus.MovestateFlag = 4;
        }
    }

    else if( gnMoveNum == MOVE_FRONT_LEFT )
    {
        if( g_nAlgoStatus.MovestateFlag != 5 )
        {
            MotorsPIDReset( );
            motorsExecList.PtrMotorListArr = g_aMoveFrontLeftJobList;
            motorsExecList.CurrStateNumber = 0;
            g_nAlgoStatus.MovestateFlag = 5;
        }
    }

    else if( gnMoveNum == MOVE_FRONT_RIGHT )
    {
        if( g_nAlgoStatus.MovestateFlag != 6 )
        {
            MotorsPIDReset( );
            motorsExecList.PtrMotorListArr = g_aMoveFrontRightJobList;
            motorsExecList.CurrStateNumber = 0;
            g_nAlgoStatus.MovestateFlag = 6;
        }
    }

    else if( gnMoveNum == MOVE_LEFT )
    {
        if( g_nAlgoStatus.MovestateFlag != 7 )
        {
            MotorsPIDReset( );
            motorsExecList.PtrMotorListArr = g_aMoveLeftJobList;
            motorsExecList.CurrStateNumber = 0;
            g_nAlgoStatus.MovestateFlag = 7;
        }
    }

    else if( gnMoveNum == MOVE_RIGHT )
    {
        if( g_nAlgoStatus.MovestateFlag != 8 )
        {
            MotorsPIDReset( );
//            Motor4SetTargetSpeed(PID_TARGET_DEFAULT_RPM+1);
            Motor3SetTargetSpeed(PID_TARGET_DEFAULT_RPM+1);
            motorsExecList.PtrMotorListArr = g_aMoveRightJobList;
            motorsExecList.CurrStateNumber = 0;
            g_nAlgoStatus.MovestateFlag = 8;
        }
    }

    else if( gnMoveNum == MOVE_STOP )
    {
        if( g_nAlgoStatus.MovestateFlag != 9 )
        {
            motorsExecList.PtrMotorListArr = g_aMoveStopJobList;
            motorsExecList.CurrStateNumber = 0;
            MOTORS_STOP( );
            MotorsPIDReset( );
            g_nAlgoStatus.MovestateFlag = 9;
        }
    }
}

static void Main_Nav_Algo( int x, int y )
{
     
g_CurrX = ABS( g_XYCoordGoal[x] - g_nCurrentCoordinate[0] );
g_CurrY = ABS( g_XYCoordGoal[y] - g_nCurrentCoordinate[1] );

if( g_CurrX >= LongDist && g_CurrY >= LongDist &&
    g_nAlgoStatus.Diag_Move == 0 ) // Check if g_currX & g_currY >=threhold distance to go diagonal
{
    g_nAlgoStatus.DiagFlag = 2;  
    g_nAlgoStatus.Diag_Move = 1;
}

 if( ( g_CurrX < ShortDist || g_CurrY < ShortDist ) &&
         g_nAlgoStatus.Diag_Move == 1 ) // Check if g_currX or g_currY< threshold distance to do XY movement
{
    g_nAlgoStatus.DiagFlag = 1;   
    g_nCurrMoveState = MOVE_STOP;
    CallChangeState( g_nCurrMoveState ); //Call for movement in the current direction
    g_nAlgoStatus.Diag_Move = 3;
}
else
{
    if( g_nAlgoStatus.Diag_Move != 1 )
    {
        g_nAlgoStatus.DiagFlag = 1;
    }
}

 

if(g_nCurrentCoordinate[0] > g_XYCoordGoal[x])
{
  g_nAlgoStatus.Mov1Flag = 1;

}
else if(g_nCurrentCoordinate[0] < g_XYCoordGoal[x])
{
  g_nAlgoStatus.Mov1Flag=2;
 }

if(g_nCurrentCoordinate[1] > g_XYCoordGoal[y] ==1)
{
  g_nAlgoStatus.Mov2Flag=1;
}

else if(g_nCurrentCoordinate[1]<g_XYCoordGoal[y])
{
  g_nAlgoStatus.Mov2Flag = 2;
 }

 

switch( g_nAlgoStatus.DiagFlag )
{
    case 1:// Movement for XY coordinates 
         if( ( g_nCurrentCoordinate[1] >= g_XYCoordGoal[y] ) &&
            ( g_nCurrentCoordinate[1] <= g_XYCoordGoal[y] + 30 ) &&
            ( g_nAlgoStatus.MovStopFlag != 2 ) )
        {
            g_nAlgoStatus.MovStopFlag = 1; //y axis done flag 
        }

        else if( g_nAlgoStatus.MovStopFlag != 1 &&
                 g_nAlgoStatus.MovStopFlag != 2 )
        {

            switch( g_nAlgoStatus.Mov2Flag )
            {
                case 1:
                    g_nCurrMoveState = MOVE_BWD;
                    CallChangeState( g_nCurrMoveState ); //Call change state algo
                    break;

                case 2:
                    g_nCurrMoveState = MOVE_FWD;
                    CallChangeState( g_nCurrMoveState );
                    break;

                default:
                    break;
            }
        }

        if( g_nCurrentCoordinate[0] >= g_XYCoordGoal[x] &&
            ( g_nCurrentCoordinate[0] <= ( g_XYCoordGoal[x] + 30 ) ) &&
            g_nAlgoStatus.MovStopFlag == 1 )
        {
            g_nAlgoStatus.MovStopFlag = 2; //x axis done flag 
        }
        else if( g_nAlgoStatus.MovStopFlag == 1 )
        {
            switch( g_nAlgoStatus.Mov1Flag )
            {
                case 1:
                    g_nCurrMoveState = MOVE_LEFT;
                    CallChangeState( g_nCurrMoveState );
                    break;

                case 2:
                    g_nCurrMoveState = MOVE_RIGHT;
                    
                    CallChangeState( g_nCurrMoveState );
                    break;

                default:
                    break;
            }
        }
        break;

    case 2: // Diagonal Movement 
         if( ( g_nCurrentCoordinate[0] >= g_XYCoordGoal[x] ) &&
            ( g_nCurrentCoordinate[0] <= ( g_XYCoordGoal[x] + 30 ) ) &&
            ( g_nCurrentCoordinate[1] >= g_XYCoordGoal[y] ) &&
            ( ( g_nCurrentCoordinate[1] <= ( g_XYCoordGoal[y] + 30 ) ) ) )
        {
            g_nAlgoStatus.MovStopFlag = 2;
        }

        else if( g_nAlgoStatus.Mov1Flag == 1 && g_nAlgoStatus.Mov2Flag == 1 ) 
        {
            g_nCurrMoveState = MOVE_BACK_LEFT;//mov1flag=backwards, mov2flag=left
            CallChangeState( g_nCurrMoveState );
        }

        else if( g_nAlgoStatus.Mov1Flag == 1 && g_nAlgoStatus.Mov2Flag == 2 )
        {
            g_nCurrMoveState = MOVE_FRONT_LEFT;
            CallChangeState( g_nCurrMoveState );
        }

        else if( g_nAlgoStatus.Mov1Flag == 2 && g_nAlgoStatus.Mov2Flag == 2 )
        {
            g_nCurrMoveState = MOVE_FRONT_RIGHT;
            CallChangeState( g_nCurrMoveState );
        }

        else if( g_nAlgoStatus.Mov1Flag == 2 && g_nAlgoStatus.Mov2Flag == 1 )
        {
            g_nCurrMoveState = MOVE_BACK_RIGHT;
            CallChangeState( g_nCurrMoveState );
        }

        break;

    default:
        break;
}

if( g_nAlgoStatus.MovStopFlag == 2 )
{

    g_nCurrMoveState = MOVE_STOP;
    CallChangeState( g_nCurrMoveState );
    g_nAlgoStatus.Diag_Move = 0;
    g_nCurrPt++; // to increment if a point has been reached 
    
}
}


 
 


/*****************************************************************************
 Interrupt functions
******************************************************************************/
void SysTickHandler( void )
{

    g_nTimestamp++;

    if( 0 != g_nDelayms )
    {
        g_nDelayms--;
    }

    /* Provide system tick with a specified period
    decided by macro SYS_TICK_MS */
    if( 0 != g_nSysTick )
    {
        g_nSysTick--;

        if( 0 == g_nSysTick )
        {
            g_nSysTick = SYS_TICK_MS;
            g_bSysTickReady = TRUE;
        }
    }

    IPSSysTimeout1msTimer( );
}

 
void EXTI8_US1_ECHO_IRQHandler( uint32_t Status )
{
    UsonicISR( &g_USHandles[0], IN_US1_ECHO( ) );
}

void EXTI9_US2_ECHO_IRQHandler( uint32_t Status )
{
    UsonicISR( &g_USHandles[1], IN_US2_ECHO( ) );
}

void EXTI10_US3_ECHO_IRQHandler( uint32_t Status )
{
    UsonicISR( &g_USHandles[2], IN_US3_ECHO( ) );
}

void EXTI11_US4_ECHO_IRQHandler( uint32_t Status )
{
    UsonicISR( &g_USHandles[3], IN_US4_ECHO( ) );
}

void EXTI12_US5_ECHO_IRQHandler( uint32_t Status )
{
    UsonicISR( &g_USHandles[4], IN_US5_ECHO( ) );
}

void EXTI13_US6_ECHO_IRQHandler( uint32_t Status )
{
    UsonicISR( &g_USHandles[5], IN_US6_ECHO( ) );
}

void EXTI14_US7_ECHO_IRQHandler( uint32_t Status )
{
    UsonicISR( &g_USHandles[6], IN_US7_ECHO( ) );
}

void EXTI15_US8_ECHO_IRQHandler( uint32_t Status )
{
    UsonicISR( &g_USHandles[7], IN_US8_ECHO( ) );
}