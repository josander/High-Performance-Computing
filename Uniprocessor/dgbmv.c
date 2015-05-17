#include "mex.h"

void dgbmv(int rows, int cols, double A[], double x[], double y[]) {

	char n = 'n';

	/* Call the Fortran routine dgbmv.f */
	//dgbmv(n, rows, cols, cols-1, rows-1, 1.0, A, cols+rows-1, x, 1.0, 1, 0, 1);

	y[0] = rows * cols;
  
}


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
  double *x, *A;
	int rows, cols;
  int mrows, ncols;
  
  /* Check for proper number of arguments. */
  if (nrhs != 1) {
    mexErrMsgTxt("One input required.");
  } else if (nlhs > 1) {
    mexErrMsgTxt("Too many output arguments");
  }
  
  /* The input must be a noncomplex scalar double.*/
  mrows = mxGetM(prhs[0]);
  ncols = mxGetN(prhs[0]);
  if (!mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) ||
      !(mrows == 1 && ncols == 1)) {
    mexErrMsgTxt("Input must be a noncomplex scalar double.");
  }

  /* Create matrix for the return argument. */
  plhs[0] = mxCreateDoubleMatrix(mrows,ncols, mxREAL);
  
  /* Assign pointers to each input and output. */
  rows = mxGetPr(prhs[0]);
  cols = mxGetPr(plhs[0]);
  A = mxGetPr(prhs[0]);
  x = mxGetPr(plhs[0]);
  
  /* Call the dgbmv subroutine. */
  dgbmv(rows, cols, A, x);

}
