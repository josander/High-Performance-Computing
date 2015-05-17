program main

 
  implicit none 
  integer           :: n, k, m, i, j
  double precision 	:: a
  double precision 	:: fsecond, t, time

	double precision, dimension(1000000)	:: x, y
	integer, dimension(1000000) ::	p

! Initialize the variables and arrays
	n = 1000000
	a = 2.1d0

	do k = 1, n
		x(k) = 1.0d0
		y(k) = 1.0d0
	end do

! Initialize p the first way and call sparse_daxpy 500 times; measure the elapsed time.

	m = 1000
	i = 0
	do j = 1, m
		do k = 1, m
			i = i + 1
			p(j + m * (k - 1)) = i
		end do
	end do

	t = fsecond()

	do k = 1, 500
		call sparse_daxpy(n, a, x, y, p)
	end do

	time = fsecond() - t
	print*, 'Time: ', time

! Initialize p the second way and call sparse_daxpy 500 times; measure the elapsed time.
	do j = 1, n
		p(j) = j
	end do

	t = fsecond()

	do k = 1, 500
		call sparse_daxpy(n, a, x, y, p)
	end do

	time = fsecond() - t
	print*, 'Time: ', time

! Call daxpy 500 times; measure the elapsed time. 

	t = fsecond()

	do k = 1, 500
		call daxpy(n, a, x, 1, y, 1)
	end do

	time = fsecond() - t
	print*, 'Time: ', time

end program main
