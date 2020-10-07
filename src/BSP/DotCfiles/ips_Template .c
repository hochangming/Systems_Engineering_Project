/*****************************************************************************
 @Project  : SEP250 2019 Spring
 @File     : ips_Template.c
 @Details  : STM32F722XX Indoor Positioning System
 @Author   : Liang Tang
 @Hardware : STM32F722
 

 --------------------------------------------------------------------------
 @Revision  :
  Ver    Author      Date       Changes
 --------------------------------------------------------------------------
   1.0  lcgan     2018-08-29   Initial Release
   1.1  Liang     2019-01-25   Remove some key parts and students are required
                               to fill.
******************************************************************************/

#include <Common.h>
#include "Hal.h"
#include "BSP.h"
#include "Serial.h"
#include "spim.h"
#include "deca_device_api.h"
#include "deca_regs.h"
#include "ips.h"
#include "matrix.h"

/*****************************************************************************
 Macro
******************************************************************************/


/*****************************************************************************
 Define
******************************************************************************/
/* Default antenna delay values for 64 MHz PRF. See NOTE 2 below. */
#define TX_ANT_DLY 16436
#define RX_ANT_DLY 16436

/* Length of the common part of the message
(up to and including the function code, see NOTE 3 below). */
#define ALL_MSG_COMMON_LEN 10

/* UWB microsecond (uus) to device time unit (dtu, around 15.65 ps) conversion
 * factor. 1 uus = 512 / 499.2 ?s and 1 ?s = 499.2 * 128 dtu. */
#define UUS_TO_DWT_TIME 65536

/* Delay between frames, in UWB microseconds. See NOTE 1 below. */
#define POLL_RX_TO_RESP_TX_DLY_UUS 500

/* Delay between frames, in UWB microseconds. See NOTE 1 below. */
#define POLL_TX_TO_RESP_RX_DLY_UUS 140

/* Speed of light in air, in metres per second. */
#define SPEED_OF_LIGHT 299702547


/* Buffer to store received response message */
#define RX_BUF_LEN 20

/* filter array for damped sample */
#define SAMPLE_ARRAY_X 1000
#define SAMPLE_ARRAY_Y 1000

#define AVG_SAMPLE 4.0f

#define GROUP_ID1 'G'
#define GROUP_ID2 'N'

#define DEFAULT_IRQ_TIMEOUT_MS 5

#define SPISampleRate 10


/*****************************************************************************
 Type definition
******************************************************************************/


/*****************************************************************************
 Global Variables


/*****************************************************************************
 Const Variables
******************************************************************************/
/* Default communication configuration. We use here EVK1000's mode 4. See NOTE 1
 * below. */
static dwt_config_t UWB_CFG = {
3,               /* Channel number. */
DWT_PRF_64M,     /* Pulse repetition frequency. */
DWT_PLEN_128,    /* Preamble length. Used in TX only. */
DWT_PAC8,        /* Preamble acquisition chunk size. Used in RX only. */
9,               /* TX preamble code. Used in TX only. */
9,               /* RX preamble code. Used in RX only. */
0,               /* 0 to use standard SFD, 1 to use non-standard SFD. */
DWT_BR_6M8,      /* Data rate. */
DWT_PHRMODE_STD, /* PHY header mode. */
( 129 + 8 - 8 )  /* SFD timeout (preamble length + 1 + SFD length - PAC size).
                    Used in RX only. */
};


/*****************************************************************************
 Local Variables
******************************************************************************/
static PSPIM_HANDLE g_pSpimHandle;
static volatile BOOL 

g_bSpiDone = FALSE;

static uint8_t g_nFrameSeqNum = 0;

static uint8_t g_aSpiTxBuf[24];
static uint8_t g_aSpiRxBuf[24];
static uint8_t g_aUwbRxBuf[RX_BUF_LEN];

static double g_dMatA[2][2] = {0};
static double g_dMatInvA[2][2] = {0};
static double g_dMatB[2] = {0};
double g_nCurrentCoordinate[2];

 int          nOrder;
  double       layer1;
  double       layer2;
   double      layer3;
  double       dTerm, xTerm, yTerm;
  double       dex[2][2];
  int           a,b,c,d,e;       
  int           Row=2;
   int          Col=2;
   
   
  double       magic_number;
  int          nRowA;
  int          nColA;
  int          nRowB;
  int          nColB;
  int          i, j;

static double g_dIpsCoordinate[2] = {0};

static PCOORDI_XY veh;

static int g_nBc = 0;
static int g_nCCB = 0;
static int g_nAvgSample = 0;
static BOOL toggle = 0; 

static double g_dAccX = 0.0;
static double g_dAccY = 0.0;

static double g_dAvgX = 0.0;
static double g_dAvgY = 0.0;

static double g_dIpsRef1[2] = {0.0, 0.0};
static double g_dIpsRef2[2] = {0, 820.0};
static double g_dIpsRef3[2] = {600, 820.0};
static double g_dDistance[3] = {0.0, 0.0, 0.0};

static volatile BOOL g_bRxOK = FALSE;
static volatile BOOL g_bSts = FALSE;

static volatile int g_nTimeoutMs = 0;
static int g_nTimeoutMsConst = DEFAULT_IRQ_TIMEOUT_MS;

static UWB_TX_MSG g_TxMsg;
static UWB_RX_MSG g_RespMsg;
static DWT_HANDLE g_UWBHandle;
static DATA_PKT   g_getdistla;

static uint16_t g_aPanId[3] = {0x4747, 0x4747, 0x4747};
static uint16_t g_aDestAddr[3] = {0x5330, 0x5331, 0x5332};
static uint8_t g_aSeqNum[3] = {0, 0, 0};

static int samplerate = SPISampleRate;
static int TotalDist = 0;

static double sample_X[SAMPLE_ARRAY_X];
static double sample_Y[SAMPLE_ARRAY_Y];
static double X_value;
static double Y_value;
/*****************************************************************************
 Local Functions
******************************************************************************/
static void ips_cbOnSpiDone( void );
int calculate[3]={0,0,0};

/*****************************************************************************
 Callback Functions
******************************************************************************/


/*****************************************************************************
 Implementation
******************************************************************************/


IPS_STS IpsInit( SPIM_HANDLE* pSpimHandle )
{
    int speed;

    g_aSeqNum[0] = 0U;
    g_aSeqNum[1] = 0U;
    g_aSeqNum[2] = 0U;

    ASSERT( 0 != pSpimHandle );

    g_pSpimHandle = pSpimHandle;

    /* Add a SPI callback */
    SpimAddCallbackTransferDone( pSpimHandle, ips_cbOnSpiDone );

    /********************************************************
     * To do: ...
     * Set g_TxMsg struct
     ********************************************************/
    g_TxMsg.b.FrameCtrl = 0x8841; /* IEEE standards pdf */ 
    g_TxMsg.b.PANID = g_aPanId[g_nBc]; /* must the same on the other side */
    g_TxMsg.b.Code = 0xE0; /* payload can be variable */ 
    g_TxMsg.b.SrcAddr = 0x3351;
    g_TxMsg.b.Resvd[0] = 0;
    g_TxMsg.b.Resvd[1] = 0;
    g_TxMsg.b.DestAddr = g_aDestAddr[g_nBc];
    g_TxMsg.b.nSequenceNum = 0;

    /* Reset UWB before any configuration */
    UWB_RESET_ON( );

    DWT_SoftReset( &g_UWBHandle );

    if( DWT_Init( &g_UWBHandle, DWT_LOADUCODE ) == DWT_ERROR )
    {
        TRACE( "INIT FAILED\r\n" );
        ASSERT( FALSE );

        return IPS_UWB_INIT_ERROR;
    }

    speed = SpimSetSpeed( pSpimHandle, 10000000 );
    TRACE( "SPI Speed: %d\r\n", speed );

    DWT_SetLEDs( 3 );

    /* Configure DW1000. */
    DWT_Config( &g_UWBHandle, &UWB_CFG );

    /********************************************************
     * To do: ...
     * Set PAN ID and Address
     ********************************************************/
    DWT_SetPanID( g_TxMsg.b.PANID );

    DWT_SetAddr16( g_TxMsg.b.DestAddr );

    /* Enable filter so it will not received other groups message */
    DWT_EnableFrameFilter( &g_UWBHandle, DWT_FF_DATA_EN );

    DWT_EnableInterrupt( SYS_STATUS_RXFCG | SYS_STATUS_ALL_RX_ERR, 1 );

    /* Set expected response's delay and timeout.
    * only handles one incoming frame with always the same delay and timeout,
    those values can be set here once for all. */
    dwt_setrxaftertxdelay( POLL_TX_TO_RESP_RX_DLY_UUS );

    /* Apply default antenna delay value.*/
    DWT_SetRxAntennaDelay( RX_ANT_DLY );
    DWT_SetTxAntennaDelay( TX_ANT_DLY );

    return IPS_SUCCESS;
}

void IPSAuthID( int nBeacon, uint8_t* pID )
{
    /********************************************************
     * To do: ...
     * Set PAN ID
     ********************************************************/
    ASSERT( nBeacon != 0 );

    switch( nBeacon )
    {
        case 1:
            memcpy( &g_aPanId[0], pID, 2 );
            DWT_SetPanID( g_aPanId[0] );
            break;

        case 2:
            memcpy( &g_aPanId[1], pID, 2 );
            DWT_SetPanID( g_aPanId[1] );
            break;

        case 3:
            memcpy( &g_aPanId[2], pID, 2 );
            DWT_SetPanID( g_aPanId[2] );
            break;

        default:
            break;
    }
}


void IPSSetAddr( int nBeacon, uint8_t* pAddr )
{
    /********************************************************
     * To do: ...
     * Set Address
     ********************************************************/
    ASSERT( nBeacon != 0 );
    switch( nBeacon )
    {
        case 1:
            memcpy( &g_aDestAddr[0], pAddr, 2 );
            DWT_SetAddr16( g_aDestAddr[0] );
            break;

        case 2:
            memcpy( &g_aDestAddr[1], pAddr, 2 );
            DWT_SetAddr16( g_aDestAddr[1] );
            break;

        case 3:
            memcpy( &g_aDestAddr[2], pAddr, 2 );
            DWT_SetAddr16( g_aDestAddr[2] );
            break;

        default:
            break;
    }
}


void IPSystemSetIRQTimeout( int nTimeoutMs )
{
    g_nTimeoutMsConst = nTimeoutMs;
}


void IPSSysTimeout1msTimer( void )
{
    if( 0 != g_nTimeoutMs )
    {
        g_nTimeoutMs--;
    }
}


IPS_STS IpsTimer( void )
{
    IPS_STS res = IPS_SUCCESS;
    UWB_TX_MSG* txmsg = 0U;
    UWB_RX_MSG* respmsg = 0U;
    uint32_t stsReg = 0U;
    uint32 framelen;
    uint32 LocalTx = 0U; // local tx
    uint32 RemoteRx = 0U; // remote rx
    uint32 LocalRx = 0U; // local rx
    uint32 RemoteTx = 0U; // remote tx
    int32_t DeltaLocal = 0; // delta local
    int32_t DeltaRemote = 0; // delta remote
    float clockOffsetRatio = 0.0;
    double tof= 0.0;
    int timeout;
    uint8_t cnt = 0;
    int ret;
    uint32_t status = 0;
    double dist=0.0;
    int retry = 0;
    BOOL btx = 0;
    uint32 deltax = 0U; 
    uint8_t *msb = 0x33;
    uint8_t *lsb = 0x33;

    /********************************************************
     * To do: ...
     * Prepare the transmission data, PAN ID, address, etc
     ********************************************************/

    if (g_nBc >= 3)
    {
       g_nBc=0;
       IPSDistMat(veh);
    }

    /* incase if the pan id changes this will help  to set it correctly */
    g_TxMsg.b.PANID = g_aPanId[g_nBc];
    g_TxMsg.b.DestAddr = g_aDestAddr[g_nBc];
    DWT_SetAddr16(g_TxMsg.b.DestAddr);
    DWT_WriteTxData( 12, g_TxMsg.Data, 0 );
    DWT_WriteTxFrameCtrl( &g_UWBHandle, 12, 0, 1 );

     /********************************************************
     * To do: ...
     * Check the receiving status by reading SYS_STATUS_ID
     * register.
     * Collect the received info
     ********************************************************/
    retry =3; /* for ips timeout*/
    do
    {
        btx = 1;
        ret = DWT_StartTx( &g_UWBHandle, DWT_START_TX_IMMEDIATE | DWT_RESPONSE_EXPECTED ); /*trigger TX*/
        if( ret == DWT_SUCCESS )
        {
            g_nTimeoutMs = 10;

            while( g_bSts == 0 )
            {
                if( g_nTimeoutMs == 0 )
                {
                    DWT_ForceTrxOff( &g_UWBHandle);
                    DWT_Write32BitReg( SYS_STATUS_ID, 0xffffffff ); /* clear status id register */ 
                    retry--;
                    if( retry == 0 )
                    {
                        btx = 0;
                        return IPS_UWB_IRQ_TIMEOUT;
                    }
                }
            }
            btx = 0;
        }
    } while( btx != 0 ); 

      g_bSts = 0; 

      status = DWT_Read32BitReg(SYS_STATUS_ID);
      if (0 == status& SYS_STATUS_IRQS)
      {
            return IPS_UWB_IRQ_TIMEOUT;
      }

      DWT_Write32BitReg(SYS_STATUS_ID, SYS_STATUS_RXFCG);

      framelen = DWT_Read32BitReg(RX_FINFO_ID) & RX_FINFO_RXFL_MASK_1023;

      if (framelen <= RX_BUFFER_LEN)
      {
            DWT_ReadRxData( g_RespMsg.Data, framelen, 0 );
            
            if (g_RespMsg.b.Code == 0xE1 && g_RespMsg.b.DestAddr == g_TxMsg.b.DestAddr)
            {

                /*clock off set ratio */ 
                clockOffsetRatio = dwt_readcarrierintegrator() * (FREQ_OFFSET_MULTIPLIER * HERTZ_TO_PPM_MULTIPLIER_CHAN_2/1.0E6);

                //compute time of flight and distance
                DeltaLocal = DWT_ReadRxTimeStamplo32() - DWT_ReadTxTimeStamplo32(); /* read timestamp */ 
                DeltaRemote = g_RespMsg.b.TxTimestamp - g_RespMsg.b.RxTimestamp; /* get timestamp based om mesage */
            
                /*time of flight 8*/
                tof = ((double)(DeltaLocal - DeltaRemote *(1.0 - clockOffsetRatio))/ 2.0 ) * DWT_TIME_UNITS;
            
                dist = (tof * SPEED_OF_LIGHT * 10000.0)/100;

                if (dist <= 25000.0)
                {  
                      g_getdistla.b.nDist1 = dist;
                      if(dist<0)
                      {
                         dist=0;
                      }
                      g_dDistance[g_nBc] =  (g_dDistance[g_nBc]+dist)/2;
                      ++g_nBc;
                       // TRACE ("dist:%f \n",dist );
                }
            }
      }

    return res;
}

int readfromspi( uint16 headerLength,
                 const uint8* headerBuffer,
                 uint32 readlength,
                 uint8* readBuffer )
{
    ASSERT( 0 != g_pSpimHandle );

    /********************************************************
     * To do: ...
     * UWB SPI READ by calling SpimTransfer()
     ********************************************************/
    memset( g_aSpiTxBuf, 0, sizeof(g_aSpiTxBuf) );
	memcpy( g_aSpiTxBuf, headerBuffer, headerLength );
	memset( g_aSpiRxBuf, 0, sizeof(g_aSpiRxBuf) );	
	
	UWB_CS_ASSERT();
	SpimTransfer(
            g_pSpimHandle,
            g_aSpiTxBuf,
            g_aSpiRxBuf,
            (headerLength + readlength));

	while( FALSE == g_bSpiDone );
	g_bSpiDone = FALSE;

	memcpy( readBuffer, &g_aSpiRxBuf[headerLength], readlength );
	UWB_CS_DEASSERT();
    return 0;
}

int writetospi( uint16 headerLength,
                const uint8* headerBuffer,
                uint32 bodylength,
                const uint8* bodyBuffer )
{
    ASSERT( 0 != headerLength );
    ASSERT( 0 != headerBuffer );
    ASSERT( 0 != bodylength );
    ASSERT( 0 != bodyBuffer );
    ASSERT( 0 != g_pSpimHandle );

    /********************************************************
     * To do: ...
     * UWB SPI Write by calling SpimTransfer()
     ********************************************************/
    memset( g_aSpiTxBuf, 0, sizeof(g_aSpiTxBuf) );
	memcpy( g_aSpiTxBuf, headerBuffer, headerLength );
	memcpy( &g_aSpiTxBuf[headerLength], bodyBuffer, bodylength );	

	UWB_CS_ASSERT();
	SpimTransfer(
	g_pSpimHandle,
	g_aSpiTxBuf,
	g_aSpiRxBuf,
	(headerLength + bodylength) );

	while( FALSE == g_bSpiDone );
	g_bSpiDone = FALSE;

    UWB_CS_DEASSERT();
    return 0;
}

double IPSGetDistance (int nIndex)
{
    return g_dDistance[nIndex];
}

void IPSDistMat(PCOORDI_XY veh)
{
      g_dMatA[0][0] = (-2)*(g_dIpsRef1[0] -  g_dIpsRef3[0]);
	  g_dMatA[0][1] = (-2)*(g_dIpsRef1[1] -  g_dIpsRef3[1]);
      g_dMatA[1][0] = (-2)* ((g_dIpsRef2[0] - g_dIpsRef3[0]));
	  g_dMatA[1][1] = (-2)*((g_dIpsRef2[1] - g_dIpsRef3[1]));
      
      layer1 = (g_dDistance[0] * g_dDistance[0]) -
               (g_dIpsRef1[0] * g_dIpsRef1[0]) -
               (g_dIpsRef1[1] * g_dIpsRef1[1]);
      
      layer2 = (g_dDistance[1] * g_dDistance[1]) -
               (g_dIpsRef2[0] * g_dIpsRef2[0]) -
               (g_dIpsRef2[1] * g_dIpsRef2[1]);
                
      layer3 = ((-(g_dDistance[2]*g_dDistance[2])) +
                (g_dIpsRef3[0] * g_dIpsRef3[0]) +
                (g_dIpsRef3[1] * g_dIpsRef3[1]));
  
      g_dMatB[0] = layer1 + layer3;
      g_dMatB[1] = layer2 + layer3;
      
      MatrixInverse(g_dMatA,g_dMatInvA,nOrder);         
      MatrixMultiply(g_dMatInvA,2,2,g_dMatB,2,1,veh);

      if(veh->x < 0)
      {
          veh->x = 0.0;
      }
      g_nCurrentCoordinate[0] = veh->x;
    
      if(veh->y < 0)
      {
            veh->y  = 0.0;
      }
     g_nCurrentCoordinate[1] = veh->y;
}

/*****************************************************************************
 Callback functions
******************************************************************************/
static void ips_cbOnSpiDone( void )
{
    g_bSpiDone = TRUE;
}

void EXTI3_UWB_INT_IRQHandler(irqStatus)
{
    g_bSts = TRUE;
}

decaIrqStatus_t decamutexon( void )
{
	/* If interrupt pin is used, make sure it lock here */
    NVIC_DisableIRQ( EXTI9_5_IRQn );
	return 1;
}


void decamutexoff ( decaIrqStatus_t s )
{
	/* If interrupt pin is used, make sure it unlock here */
	if( s )
	{
        NVIC_EnableIRQ( EXTI9_5_IRQn );
	}
}
