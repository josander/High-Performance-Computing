subroutine mult (re_a, im_a, re_b, im_b, re_c, im_c)
! Subroutine to manually get the product of two complex arrays

	implicit none
	integer :: i
	double precision, dimension(200000) :: re_a, im_a, re_b, im_b, re_c, im_c


	do i = 1, 200000
		re_a(i) = re_a(i) + re_b(i) * re_c(i) - im_b(i) * im_c(i)
		im_a(i) = im_a(i) + im_b(i) * re_c(i) + re_b(i) * im_c(i)
	end do

end subroutine mult
