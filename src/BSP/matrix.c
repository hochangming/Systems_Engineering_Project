
#include "common.h"

BOOL
MatrixInverse(
              double  dMatA[2][2],
              double  dMatInv[2][2],
              int     nOrder )
{
  double determinant;
  BOOL RetCode;
  
  RetCode = TRUE;
  
  /********************************************************
  * To do: 
  ********************************************************/
  determinant = dMatA[0][0] * dMatA[1][1] - dMatA[0][1] * dMatA[1][0];
  determinant = 1/determinant;
  dMatInv[0][0] = dMatA[1][1] * determinant;
  dMatInv[0][1] = dMatA[0][1] * determinant;
  dMatInv[1][0] = dMatA[1][0] * determinant;
  dMatInv[1][1] = dMatA[0][0] * determinant;
  
  dMatInv[0][1] = 0 - dMatInv[0][1];
  dMatInv[1][0] = 0 - dMatInv[1][0];
  
  return(RetCode);
}

int
MatrixMultiply(
               void     *pMatA,
               int     nRowA,
               int     nColA,
               void     *pMatB,
               int     nRowB,
               int     nColB,
               void     *pMatMult )
{
  int i , j , k;
  int addrMatA;
  int addrMatB;
  int addrMatMult;
  double MultiResult;
  int RetCode;
  
  double (*matA)[2] = pMatA;
  double (*matB)[1] = pMatB;
  double (*matM)[1] = pMatMult;
  
  //ASSERT(nColA!=nRowB);
  RetCode = TRUE;
  /********************************************************
  * To do: 
  ********************************************************/
  for (i=0 ; i<nColA;i++){ 
	for (j=0 ; j<nColB ; j++){
		matM[i][j] = 0 ;
		for (k=0 ; k<nColA ; k++){
			MultiResult = matA[i][k] * matB[k][j];
			matM[i][j] = matM[i][j] + MultiResult;
		}
	}
  }
  
  return(RetCode);
    
}