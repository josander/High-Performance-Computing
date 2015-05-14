subroutine mult (re_a, im_a, re_b, im_b, re_c, im_c)
! Subroutine to manually get the product of two complex arrays

	implicit none
	integer :: m, i, j
	double precision :: a, b, c
	double precision, dimension(200000) :: re_a, im_a, re_b, im_b, re_c, im_c
  double precision :: fsecond, t, time

	m = 4000

  t = fsecond()

	do j = 1, m
		do i = 1, 200000

			re_a(i) = re_a(i) + re_b(i) * re_c(i) - im_b(i) * im_c(i)
			im_a(i) = im_a(i) + im_b(i) * re_c(i) + re_b(i) * im_c(i)

		end do
	end do

  time = fsecond() - t

  print*, 'Time: ', time
	print*, sum(re_a), sum(im_a)

end subroutine mult
