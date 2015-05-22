subroutine initF(F, n)
! Subroutine to time an addition operation

  implicit none 
  integer	   ::  n, i, j
  double precision :: delta, x, y
  double precision, dimension(n + 2,n + 2) :: f
  real :: cput1, cput2 

	delta = 1/(n+1)

	do i = 1, n
		x = i*delta		
		do j = 1, n
					
			y = j*delta		
			f(i+1,j+1) = 2*(cos(x + y) -(1 + x)*sin(x + y)) 
			

		end do
	end do

	do j = 1, n+2

		f(1,j)
		f(n+2, j)
	end do 
	
	

end subroutine additionTest




