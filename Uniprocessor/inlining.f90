program main
! Program to study inlining

  implicit none 
  integer(8)	   :: k, n, m, i, j
  double precision :: fsecond, t, time

  double precision, dimension(200000) :: re_a, im_a, re_b, im_b, re_c, im_c

	n = 200000
	m = 4000

  print*, '-------------Calling a subroutine--------------'

! Initialize the arrays
	do k = 1,n

    re_b(k) = k * 0.0001d0
		im_b(k) = k * 0.001d0 

		re_c(k) = k * 0.00001d0
		im_c(k) = k * 0.00005d0

  end do

  t = fsecond()

	do j = 1, m
		call mult(re_a, im_a, re_b, im_b, re_c, im_c)
	end do

  time = fsecond() - t
  print*, 'Time: ', time

! Take time of the same inlined procedure
  print*, '------------------Inlining----------------------'

! Initialize the arrays
	do k = 1,n

		re_a(k) = 0.0d0
		im_a(k) = 0.0d0

    re_b(k) = k * 0.0001d0
		im_b(k) = k * 0.001d0 

		re_c(k) = k * 0.00001d0
		im_c(k) = k * 0.00005d0

  end do

! Measure the time for the inlines function
  t = fsecond()

	do j = 1, m
		do i = 1, 200000

			re_a(i) = re_a(i) + re_b(i) * re_c(i) - im_b(i) * im_c(i)
			im_a(i) = im_a(i) + im_b(i) * re_c(i) + re_b(i) * im_c(i)

		end do
	end do

  time = (fsecond() - t)
  
	print*, sum(re_a), sum(im_a)
  print*, 'Time: ', time
  print*, '------------------------------------------------'

end program main


