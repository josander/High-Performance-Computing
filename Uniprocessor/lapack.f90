program main
! Program to study lapack

  implicit none 
  integer(4)	   :: k, i, j, nbrOperations, n
  double precision :: sumA, sumAA, Gflops
  double precision :: fsecond, t, time

  double precision, allocatable, dimension(:, :) :: A

	allocate(A(5000, 5000))

! Do the Cholesky factorization algorithm for different sizes of n
	do n = 100, 500, 100

	! Initialize A as a symmetric and positive definite matrix
		do k = 1, n
			do i = 1, n
				A(i, k) = 0.000001d0			
			end do
			A(k, k) = 1  
		end do


	! Take the time
		t = fsecond()


	! Cholesky factorization algorithm
		do k = 1, n

			do i = 1, k - 1
				sumA = sumA + A(k, i) * A(k, i)
			end do		

			A(k, k) = A(k, k) ** 0.5 - sumA

			do j = k + 1, n

				do i = 1, k -1
					sumAA = sumAA + A(j, i) * A(k, i)
				end do

				A(j, k) = ( A(j, k) - sumAA ) / A(k, k)

			end do

		end do


		time = fsecond() - t
		Gflops = 1 / (time * 10**9)
		nbrOperations = nbrOperations / n ! not correct!


		open (unit = 1, file = "lapackData.txt")
		write (1, *) n, time, nbrOperations, Gflops
		print*, 'Time: ', time
		print*, sum(A)


	end do	

	deallocate(A)
	close (unit = 1)



! Do the same thing using the Lapack routine dpotrf


end program main

