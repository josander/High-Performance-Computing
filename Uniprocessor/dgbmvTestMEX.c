#include "mex.h"


void dgbmv_(char *, int *, int *, int *, int *, double *, double *, int *, double *, int *, double *, double *, int *);


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
  plhs[0] = mxCreateDoubleMatrix(mrows, ncols, mxREAL);
  
  /* Assign pointers to each input and output. */
  rows = *mxGetPr(prhs[0]);
  cols = *mxGetPr(prhs[1]);
	A = mxGetPr(prhs[2]);
	x = mxGetPr(prhs[3]);
  Y = mxGetPr(plhs[0]);

	kl = rows - 1;
	ku = cols - 1;
	alpha = 1.0;
	beta = 0.0;
	lda = kl + ku + 1;
	inc = 1;

	printf("%d", lda);

	/* Call the Fortran function */
	dgbmv_(&trans, &rows, &cols, &kl, &ku, &alpha, A, &lda, x, &inc, &beta, Y, &inc);

}
