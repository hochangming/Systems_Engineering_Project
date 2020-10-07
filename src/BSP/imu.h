/*****************************************************************************
 @Project	: 
 @File 		: imu.h
 @Details  	:              
 @Author	: 
 @Hardware	: 
 
 --------------------------------------------------------------------------
 @Revision	:
  Ver  	Author    	Date        	Changes
 --------------------------------------------------------------------------
   1.0  Name     XXXX-XX-XX  		Initial Release
   
******************************************************************************/


#ifndef __IMU_DOT_H__
#define __IMU_DOT_H__

/*****************************************************************************
 Define
******************************************************************************/
#define RAD(x) ((x)*0.01745329252)  /* *pi/180 */
#define ToDeg(x) ((x)*57.2957795131)  /* *180/pi */


/*****************************************************************************
 Type definition
******************************************************************************/
typedef struct _tagIMU_Data
{
	float gx;
	float gy;
	float gz;
	float ax;
	float ay;
	float az;
	float mx;
	float my;
	float mz;
}IMU_DATA, *PIMU_DATA;


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
void ImuInit( BOOL bMagEn );


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
void ImuSetSampleRate(  int nSampleFreq );


/******************************************************************************
 @Description 	: 

 @param			: gx, gy, gz = degree/s
 
 @revision		: 1.0.0
 
******************************************************************************/
void ImuUpdateAcclGyro( IMU_DATA const *pData, int nTimeDiff );


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
void ImuUpdate( IMU_DATA const *pData, int nTimeDiff );


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
void ImuComputeResult( float *pdRoll, float *pdPitch, float *pdYaw );

#endif /* __IMU_DOT_H__ */