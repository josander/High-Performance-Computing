#include "mex.h"


void dgbmv_(char *, int *, int *, int *, int *, double *, double *, int *, double *, int *, double *, double *, int *);


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {

	/* Declaration of variables. */
  double *x, *A, *Y, alpha, beta, *Atmp;
	int kl, ku, lda, inc;
	char trans = 'n';
  int mrows, ncols, Yrows, Ycols;
  
  /* Check for proper number of arguments. */
  if (nrhs != 4) {
    mexErrMsgTxt("Four inputs required.");
  } else if (nlhs > 1) {
    mexErrMsgTxt("Too many output arguments");
  }
  
  /* Get size of the A-matrix. */
  mrows = mxGetM(prhs[2]);
  ncols = mxGetN(prhs[2]);

  /* Create matrix for the return argument. */
  plhs[0] = mxCreateDoubleMatrix(mrows, 1, mxREAL);
  
  /* Assign pointers to each input and output. */
  kl = *mxGetPr(prhs[0]);
  ku = *mxGetPr(prhs[1]);
	A = mxGetPr(prhs[2]);
	x = mxGetPr(prhs[3]);
  Y = mxGetPr(plhs[0]);

	/* Allocate memory for Ytmp. */
	Atmp = mxCalloc(mrows * ncols, sizeof(double));

	/* Initialize other arguments for dgbmv. */
	alpha = 1.0;
	beta = 0.0;
	lda = kl + ku + 1;
	inc = 1;

	/* Make it a dense matrix. */
	Atmp = A;

	/* Call the Fortran function. */
	dgbmv_(&trans, &mrows, &ncols, &kl, &ku, &alpha, Atmp, &lda, x, &inc, &beta, Y, &inc);

	/* Test */
  Yrows = mxGetM(plhs[0]);
  Ycols = mxGetN(plhs[0]);
	printf("%d\t %d\t %f\t %f\t %f\t %f", Yrows, Ycols, Y[0], Y[1], Y[2], Y[3]);

	/* Free allocated memory. */
	mxFree(Atmp);

}
