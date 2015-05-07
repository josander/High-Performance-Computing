subroutine sparse_daxpy(n, a, x, y, p)

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


subroutine daxpy(n, a, x, y)

	implicit none
	integer :: n, k, j
  double precision 	:: a

	double precision, dimension(n)	:: x, y
	integer, dimension(n) ::	p



end subroutine


