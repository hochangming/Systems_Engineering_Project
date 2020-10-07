/*****************************************************************************
 @Project   : SEP250 IPS coordinate calculation test bench
 @File      : coordi.h
 @Details   :                 
 @Author    : 
 @Hardware  : NIL
 
 --------------------------------------------------------------------------
 @Revision  :
  Ver    Author      Date          Changes
 --------------------------------------------------------------------------
   1.0  Name     XXXX-XX-XX      Initial Release
******************************************************************************/

#ifndef __COORDI_DOT_H__
#define __COORDI_DOT_H__


typedef struct _tagCOORDI_XY
{
  double x;
  double y;
}COORDI_XY, *PCOORDI_XY;

typedef struct _tagBEACON_INFO
{
  struct
  {
    COORDI_XY coordi;   //Beacon's coordinate, static known parameter
    double dist;        //Beacon-vehicle distance, dynamic known parameter
  }id[NUM_OF_BEACON];
}BEACON_INFO, *PBEACON_INFO;



int coordi(PBEACON_INFO bInfo, PCOORDI_XY VehCoordi);

#endif /* __COORDI_DOT_H__ */
