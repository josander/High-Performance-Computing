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
	do n = 100, 5000, 100

		! Initialize A as a symmetric and positive definite matrix
		do k = 1, n

			do i = 1, n
				A(i, k) = 0.000001d0			
			end do

			A(k, k) = 1  

		end do

		! Take the time
		t = fsecond()

		! Our Cholesky factorization algorithm
		do k = 1, n

			do i = 1, k - 1
				sumA = sumA + A(k, i) * A(k, i)
			end do		

			A(k, k) = A(k, k) ** 0.5 - sumA
			invDiag = 1.0d0 / A(k,k)

			do j = k + 1, n


				do i = 1, k -1
					sumAA = sumAA + A(j, i) * A(k, i)
				end do

				A(j, k) = ( A(j, k) - sumAA ) * invDiag

			end do

		end do

		time = fsecond() - t
		
		nbrOperations = 2 *( n ** 2)  + 23 * n + 2
		Gflops = nbrOperations / (time * 10.0d0**9)
		


		open (unit = 1, file = "lapackData.txt")
		write (1, *) n, time, nbrOperations, Gflops
		print*, 'Time: ', time
		print*, n, sum(A), Gflops

		!	Reset A
		do k = 1, n

			do i = 1, n
				A(i, k) = 0.000001d0			
			end do

			A(k, k) = 1  

		end do

		! Do the same thing using the Lapack routine dpotrf
		! Take the time
		t = fsecond()

		call dpotrf(UPLO, n, A, 5000, info)

		time = fsecond() - t

		open (unit = 2, file = "lapackNetlibData.txt")
		write (2, *) n, time
		print*, 'NL Time: ', time
		print*, n, sum(A)
		

	end do	

	deallocate(A)
	close (unit = 1)
	close (unit = 2)


end program main

