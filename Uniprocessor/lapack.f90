program main
! Program to investigate inlining

  implicit none 
  integer(8)	   :: k, n, m, i, j
  double precision :: fsecond, t, time, sumA, sumAA
  real :: cput1, cput2 

  double precision, dimension(100, 100) :: A, L, U

	n = 100

	do k = 1, n

		do i = 1, k - 1
			sumA = sumA + A(k, i)**2
		end do		

		A(k, k) = A(k, k)**0.5 - sumA

		do j = k + 1, n

			do i = 1, k -1
				sumAA = sumAA + A(j, i) * A(k, i)
			end do

			A(j, k) = ( A(j, k) - sumAA ) / A(k, k)
		end do

	end do



end program main

