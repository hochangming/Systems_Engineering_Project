/*****************************************************************************
 @Project  : STM32F7XX SPI Master driver
 @File     : spim.h
 @Details  : SPI Master hardware layer                    
 @Author   : 
 @Hardware : 
 
 --------------------------------------------------------------------------
 @Revision  :
  Ver    Author      Date          Changes
 --------------------------------------------------------------------------
   1.0  Name     XXXX-XX-XX      Initial Release
   
******************************************************************************/


#ifndef __SPIM_DOT_H__
#define __SPIM_DOT_H__

/*****************************************************************************
 Define
******************************************************************************/
#define SPIM_STS_OK                   0
#define SPIM_E_INVALID_PORT          -1
#define SPIM_E_INVALID_CLK_POLARITY  -2
#define SPIM_E_INVALID_CLK_EDGE      -3
#define SPIM_E_INVALID_DATASIZE      -4
#define SPIM_E_INVALID_SPEED         -5


/*****************************************************************************
 Type definition by an enumeration
******************************************************************************/
typedef enum _SPIM_CFG
{
  SPI_CLK_INACT_HIGH,    /* Clock polarity selection */
  SPI_CLK_INACT_LOW,
  
  SPI_CLK_RISING_EDGE,    /* Clock sampling edge selection */
  SPI_CLK_FALLING_EDGE,
  
  SPI_DATA_SIZE_4,
  SPI_DATA_SIZE_5,
  SPI_DATA_SIZE_6,
  SPI_DATA_SIZE_7,
  SPI_DATA_SIZE_8,
  SPI_DATA_SIZE_9,
  SPI_DATA_SIZE_10,
  SPI_DATA_SIZE_11,
  SPI_DATA_SIZE_12,
  SPI_DATA_SIZE_13,
  SPI_DATA_SIZE_14,
  SPI_DATA_SIZE_15,
  SPI_DATA_SIZE_16
}SPIM_CFG;


/* SPI Driver typedef */
/**********************************************************
  SPIM_CB_TRFR_DONE is used for a function pointer to specify
  where is the callback function.
**********************************************************/
typedef void SPIM_CB_TRFR_DONE( void );


/**********************************************************
  SPIM_HANDLE is used for SPI Instance handle.
  Element description:
  *pSpi         : SPI peripheral register base address
   Irq          : IRQ number for the selected SPI
   Apb          : APB number for the selected SPI
   DataSize     : This variable is used in DMA, can be
                  ignored at first.
   nTxCount     : A counter, or buffer address, for the 
                  SPI transmission.
   nRxCount     : A counter, or buffer address, for the 
                  SPI receiving.
  *pTxBuf       : The SPI transmission data buffer, each
                  address holds a BYTE
  *pRxBuf       : The SPI receiving data buffer, each
                  address holds a BYTE
  *pTxWordBuf   : The SPI transmission data buffer, each
                  address holds a WORD
  *pRxWordBuf   : The SPI receiving data buffer, each
                  address holds a WORD
   nSize        : The transmission/receiving data size
  *pDmaTx       : This variable is used in DMA, can be
                  ignored at first.
  *pDmaRx       : This variable is used in DMA, can be
                  ignored at first.
   Dummy        : This variable is used in DMA, can be
                  ignored at first.
   bTransferWord: A Bool type variable to indicate each 
                  buffer address holds a BYTE or a WORD
   Reseved      : Not used!
  *pfDone       : The SPI callback function address holder
**********************************************************/
typedef struct _tagSpim_handle
{
  void              *pSpi;
  int                Irq;
  int                Apb;
  int                DataSize;
                    
  volatile int       nTxCount;
  volatile int       nRxCount;
  char              *pTxBuf;
  char              *pRxBuf;
  uint16_t          *pTxWordBuf;
  uint16_t          *pRxWordBuf;
  int                nSize;
                    
  void              *pDmaTx;
  void              *pDmaRx;
                    
  uint32_t           Dummy;
  uint8_t            bTransferWord :1;
  uint8_t            Reseved :7;
  
  SPIM_CB_TRFR_DONE *pfDone;
}SPIM_HANDLE, *PSPIM_HANDLE;



/******************************************************************************
 Global functions
******************************************************************************/


/******************************************************************************
 @Description: SPI initialization function.
 @param      : pHandle: the memory address of the initialing SPI handle.
               Port: the SPI ID;
               nSpeed: SPI parameter: transfer speed;
               ClkInactive: SPI parameter
               ClkEdge: SPI parameter
               DATA_SIZE: SPI parameter
 @revision   : 1.0.0
******************************************************************************/
int SpimInit(
  void              *pHandle,
  char               nPort,
  int                nSpeed,
  SPIM_CFG           ClkInactive,
  SPIM_CFG           ClkEdge,
  SPIM_CFG           DATA_SIZE );


/******************************************************************************
 @Description: SPI speed setting.
               This function can be ignored at beginning since the SPI speed has 
               been set in the SpimInit function.
               However, this function is still useful.
               For example, a SPI has been initialized and worked for a period.
               Suddenly the user wants to change the SPI speed due to some reasons.
               Although it is possilbe to re-initialize the SPI, calling this 
               function (SpimSetSpeed) will be more efficient.
 @param      : 
 @revision   : 1.0.0
******************************************************************************/
int SpimSetSpeed( void *pHandle, int nSpeed );


/******************************************************************************
 @Description: Similar to the SpimSetSpeed function, the SpimSetDataSize function 
               can be ignored at beginning.
 @param      : 
 @revision   : 1.0.0
 
******************************************************************************/
int SpimSetDataSize( void *pHandle, SPIM_CFG DATA_SIZE );


/******************************************************************************
 @Description: This function is called by the application, or the SPI user, to 
               store the call back function address into the handle struct's 
               pfDone element.
               Thus, during the SPI ISR (implemented by the SPI_Handler function), 
               the ISR can call the callback function, which are located at the 
               application level.
 @param      : 
 @revision   : 1.0.0
******************************************************************************/
void SpimAddCallbackTransferDone(
  void              *pHandle,
  SPIM_CB_TRFR_DONE *pfDone );


/******************************************************************************
 @Description: This is the SPI transfer (write and read) implementation.
               This function is called by the application, or the SPI user, 
               who specify what info will be writted/read.
 @param      : pHandle: SPI handle pointer/address
               pTxBuf: the TX buffer, which holds the data to be transmitted via the SPI;
               pRxBuf: the RX buffer, the received info will be stored here.
               Note, if the SPI operation is purely transmit, no any receiveing:
                 the pRxBuf input can be 0 (NULL) since this buffer won't be used.
               nSize: the number of words for the transmission/receiving.
 @revision    : 1.0.0
******************************************************************************/
void SpimTransfer(
  void              *pHandle,
  void const        *pTxBuf,
  void              *pRxBuf,
  int                nSize );  


/******************************************************************************
 @Description: DMA related function, which can be ignored at first.
 @param      : 
 @revision   : 1.0.0
******************************************************************************/
void SpimLinkDMA(
  void              *pHandle,
  void              *pDmaTxHandle,
  void              *pDmaRxHandle );

#endif /* __SPIM_DOT_H__ */









