#include <stdio.h>
#include <string.h>
#include <stddef.h>
#include <stdlib.h>
#include "common.h"
#include "matrix.h"
#include "coordi.h"

int coordi(PBEACON_INFO bInfo, PCOORDI_XY VehCoordi)
{
  int          RetCode;
  double       dMatA[2][2];
  double       dMatInv[2][2];
  double       MatB[2];
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
  
  RetCode = FALSE;

  /********************************************************
  * To do: 
  ********************************************************/
      dMatA[0][0] = (-2)*((bInfo->id[0].coordi.x - bInfo->id[2].coordi.x));
	  dMatA[0][1] = (-2)*((bInfo->id[0].coordi.y - bInfo->id[2].coordi.y));
      dMatA[1][0] = (-2)* ((bInfo->id[1].coordi.x - bInfo->id[2].coordi.x));
	  dMatA[1][1] = (-2)*((bInfo->id[1].coordi.y - bInfo->id[2].coordi.y));
      
      layer1 = ((bInfo->id[0].dist * bInfo->id[0].dist) -
               (bInfo->id[0].coordi.x * bInfo->id[0].coordi.x) -
               (bInfo->id[0].coordi.y * bInfo->id[0].coordi.y));
      
      layer2 = ((bInfo->id[1].dist * bInfo->id[1].dist) -
               (bInfo->id[1].coordi.x * bInfo->id[1].coordi.x) -
               (bInfo->id[1].coordi.y * bInfo->id[1].coordi.y));
                
      layer3 = (-(bInfo->id[2].dist * bInfo->id[2].dist) +
                (bInfo->id[2].coordi.x * bInfo->id[2].coordi.x) +
                (bInfo->id[2].coordi.y * bInfo->id[2].coordi.y));
  
      MatB[0] = layer1 + layer3;
      MatB[1] = layer2 + layer3;
      
      MatrixInverse(dMatA,dMatInv,nOrder);         
      MatrixMultiply(dMatInv,2,2,MatB,2,1,VehCoordi);
      
      RetCode = TRUE; 
     
  return(RetCode);
}
