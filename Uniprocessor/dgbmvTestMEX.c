#include "mex.h"
#include "cblas.h"


/*void cblas_dgbmv(char *, int *, int *, int *, int *, double *, double *, int *, double *, int *, double *, double *, int *);*/

void cblas_dgbmv(const enum,
                 const enum, const int, const int,
                 const int, const int, const double,
                 const double, const int, const double,
                 const int, const double, double, const int);

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
  double *x, *A, *Y, alpha, beta;
	int rows, cols, kl, ku, lda, inc;
	char trans = 'n';
  int mrows, ncols;
  
  /* Check for proper number of arguments. */
  if (nrhs != 4) {
    mexErrMsgTxt("One input required.");
  } else if (nlhs > 1) {
    mexErrMsgTxt("Too many output arguments");
  }
  
  /* The input must be a noncomplex scalar double.*/
  mrows = mxGetM(prhs[0]);
  ncols = mxGetN(prhs[1]);
  if (!mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) ||
      !(mrows == 1 && ncols == 1)) {
    mexErrMsgTxt("Input must be a noncomplex scalar double.");
  }

  /* Create matrix for the return argument. */
  plhs[0] = mxCreateDoubleMatrix(mrows,ncols, mxREAL);
  
  /* Assign pointers to each input and output. */
  rows = *mxGetPr(prhs[0]);
  cols = *mxGetPr(prhs[1]);
	A = mxGetPr(prhs[2]);
	x = mxGetPr(prhs[3]);
  Y = mxGetPr(plhs[0]);

	kl = cols - 1;
	ku = rows - 1;
	alpha = 1.0;
	beta = 1.0;
	lda = kl + ku + 1;
	inc = 1;
  
  /* Call the dgbmv subroutine. */
  cblas_dgbmv(&trans, &rows, &cols, &kl, &ku, &alpha, A, &lda, x, &inc, &beta, Y, &inc);

							const enum CBLAS_ORDER order,
                 const enum CBLAS_TRANSPOSE TransA, const int M, const int N,
                 const int KL, const int KU, const double alpha,
                 const double *A, const int lda, const double *X,
                 const int incX, const double beta, double *Y, const int incY

}
