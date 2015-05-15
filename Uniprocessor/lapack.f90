program main
! Program to study lapack

  implicit none 
  integer(8)	   :: k, i, j, m, nbrOperations
  double precision :: sumA, sumAA, Gflops
  double precision :: fsecond, t, time, cpuTime

	integer, dimension(50) :: n
  double precision, dimension(5000, 5000) :: A



! Initialize n
	do k = 1, 50
		n(k) = 100 * k
	end do

	print*, n(1), n(50)



! Do the Cholesky factorization algorithm for different sizes of n
	do m = 1, 15


	! Initialize A as a symmetric and positive definite matrix
		do k = 1, n(m)
			do i = 1, n(m)
				A(i, k) = 0.000001d0			
			end do
			A(k, k) = 1  
		end do


	! Take the time
		t = fsecond()


	! Cholesky factorization algorithm
		do k = 1, n(m)

			do i = 1, k - 1
				sumA = sumA + A(k, i) * A(k, i)
			end do		

			A(k, k) = A(k, k) ** 0.5 - sumA

			do j = k + 1, n(m)

				do i = 1, k -1
					sumAA = sumAA + A(j, i) * A(k, i)
				end do

				A(j, k) = ( A(j, k) - sumAA ) / A(k, k)

			end do

		end do


		time = fsecond() - t
		Gflops = 1 / (time * 10**9)
		nbrOperations = nbrOperations / n(m)


		open (unit = 1, file = "lapackData.txt")
		write (1, *) time, nbrOperations, Gflops
		print*, 'Time: ', time
		print*, sum(A)


	end do	


	close (unit = 1)



! Do the same thing using the Lapack routine dpotrf


end program main

