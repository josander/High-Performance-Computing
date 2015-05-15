program main
! Program to study lapack

  implicit none 
  integer(8)	   :: k, i, j
  double precision :: sumA, sumAA
  double precision :: fsecond, t, time, cpuTime

	integer, dimension(50) :: n
  double precision, dimension(5000, 5000) :: A


! Initialize n
	do k = 1, 50
		n(k) = 100 * k
	end do

	print*, n(1), n(50)


! Initialize A as a symmetric and positive definite matrix
	do k = 1, n(1)
		do i = 1, n(1)
			A(i, k) = 0.000001d0			
		end do
		A(k, k) = 1  
	end do


! Take the time
  t = fsecond()

! Cholesky factorization algorithm
	do k = 1, n(1)
		do i = 1, k - 1
			sumA = sumA + A(k, i) * A(k, i)
		end do		
		A(k, k) = A(k, k)**0.5 - sumA

		do j = k + 1, n(1)

			do i = 1, k -1
				sumAA = sumAA + A(j, i) * A(k, i)
			end do

			A(j, k) = ( A(j, k) - sumAA ) / A(k, k)
		end do

	end do

  time = fsecond() - t

	open (unit = 1, file = "lapackData.txt")
	write (1, *) time, sum(A)
  print*, 'Time: ', time
	print*, 'Gflop/s: ', 1/(time * 10**9)
	print*, sum(A)
	!close (unit = 1)

! Do the same thing using the Lapack routine dpotrf


end program main

