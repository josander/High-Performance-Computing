program main
 
! Program to study lapack 
  implicit none 
  integer(4)	   :: k, i, j, nbrOperations, n, info
  double precision :: sumA, sumAA, invDiag, Gflops
  double precision :: fsecond, t, time
	CHARACTER(LEN=1) :: UPLO


  double precision, allocatable, dimension(:, :) :: A

	allocate(A(1200, 1200))
	UPLO = 'L'
	
! Do the Cholesky factorization algorithm for different sizes of n
	do n = 1200, 1200, 100
	! Initialize A as a symmetric and positive definite matrix
		do k = 1, n
			do i = 1, n
				A(i, k) = 0.000001d0			
			end do
			A(k, k) = 1  
		end do


	! Take the time
		t = fsecond()

		call dpotrf(UPLO, n, A, 1200, info)

		time = time + fsecond() - t
	end do
 

end program main

