#include "mex.h"


void dgbmv_(char *, int *, int *, int *, int *, double *, double *, int *, double *, int *, double *, double *, int *);


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {

	/* Declaration of variables. */

  double *x, *A, *Y, alpha, beta, *Atmp;
	int kl, ku, lda, inc, k, amax, amin;

	//char trans = 'n';
  int mrows, ncols;
  
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

	Atmp = mxCalloc(lda * mrows, sizeof(double));
	for(int j = 0; j < ncols; j++){
		k = ku - j ;
		amax = (0 > (j - ku ) ? 0 : (j  - ku ));
		amin = ((ncols) < (j + kl+1) ? ncols : (j + kl+1));
		for(int i = amax; i < amin; i++){
			printf("%i \t %i \t", j,i);			
			printf("%f \n", *(A + j + ncols*(i)));
			*(Atmp + k + i + j*ncols)   = *(A + j + ncols*(i));

		}
	}
	/*for (int j = 0;j < lda; j++){
		for (int i = 0;i < mrows; i++){
				printf("%i %i\t %f \n",j,i,*(Atmp + j + i*mrows ) );
		}
	} */ 



	/* Call the Fortran function. */
	//dgbmv_(&trans, &mrows, &ncols, &kl, &ku, &alpha, Atmp, &lda, x, &inc, &beta, Y, &inc);

	/* Free allocated memory. */
	mxFree(Atmp);

}
