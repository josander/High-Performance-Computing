program main

! Program to study lapack
  implicit none 
  integer(4)	   :: k, i, j, nbrOperations, n, info
  double precision :: sumA, sumAA, invDiag, Gflops
  double precision :: fsecond, t, time
	CHARACTER(LEN=1) :: UPLO


  double precision, allocatable, dimension(:, :) :: A

	allocate(A(5000, 5000))
	UPLO = 'L'

! Do the Cholesky factorization algorithm for different sizes of n
	do n = 100, 2000, 100
	
		time = 0
		do j = 1, 20
		!	Reset A
			do k = 1, n
				do i = 1, n
					A(i, k) = 0.000001d0			
				end do
				A(k, k) = 1  
			end do

		! Take the time
			t = fsecond()

			call dpotrf(UPLO, n, A, 5000, info)


	! Do the same thing using the Lapack routine dpotrf

			time = time + fsecond() - t
	
		end do
		time = time/20
		nbrOperations = 2 *( n ** 2)  + 23 * n + 2
		Gflops = nbrOperations / (time * 10.0d0**9)

		open (unit = 2, file = "oBlas4TData.txt")
		write (2, *) n, time, nbrOperations, Gflops
		print*, 'NL Time: ', time
		print*, n, sum(A), Gflops
		
	end do
	do n = 2100, 5000, 100
	
	!	Reset A
		do k = 1, n
			do i = 1, n
				A(i, k) = 0.000001d0			
			end do
			A(k, k) = 1  
		end do

	! Take the time
		t = fsecond()

		call dpotrf(UPLO, n, A, 5000, info)


! Do the same thing using the Lapack routine dpotrf

		time = fsecond() - t

		nbrOperations = 2 *( n ** 2)  + 23 * n + 2
		Gflops = nbrOperations / (time * 10.0d0**9)

		open (unit = 2, file = "oBlas4TData.txt")
		write (2, *) n, time, nbrOperations, Gflops
		print*, 'NL Time: ', time
		print*, n, sum(A), Gflops
		
	end do	
	

	deallocate(A)
	close (unit = 1)
	close (unit = 2)




end program main

