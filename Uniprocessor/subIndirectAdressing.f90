subroutine sparse_daxpy(n, a, x, y, p)
! Our own daxpy

	implicit none
	integer :: n, k, j
	double precision 	:: a

	double precision, dimension(n)	:: x, y
	integer, dimension(n) ::	p


	do k = 1, n
		j = p(k)
		y(j) = y(j) + a * x(j)
	end do


end subroutine

