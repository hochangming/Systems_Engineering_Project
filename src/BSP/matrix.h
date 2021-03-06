/*****************************************************************************
 @Project	: 
 @File 		: matrix.h
 @Details  	:                 
 @Author	: 
 @Hardware	: 
 
 --------------------------------------------------------------------------
 @Revision	:
  Ver  	Author    	Date        	Changes
 --------------------------------------------------------------------------
   1.0  Name     XXXX-XX-XX  		Initial Release
   
******************************************************************************/

#ifndef __MATRIX_DOT_H__
#define __MATRIX_DOT_H__


/*****************************************************************************
 Define
******************************************************************************/
																 

/*****************************************************************************
 Type definition
******************************************************************************/


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
int
MatrixMultiply(
	void 	*pMatA,
	int 	nRowA,
	int 	nColA,
	void 	*pMatB,
	int 	nRowB,
	int 	nColB,
	void 	*pMatMult );


/******************************************************************************
 @Description 	: 

 @param			: 
 
 @revision		: 1.0.0
 
******************************************************************************/
BOOL
MatrixInverse(
	double  dMatA[2][2],
	double  dMatInv[2][2],
    int     nOrder );
	

#endif /* __MATRIX_DOT_H__ */









