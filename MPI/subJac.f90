subroutine initFull(F, n)
! Subroutine to initialize the f + g matrix

  implicit none 
  integer	   ::  n, i, j
  double precision :: delta, x, y, last
  double precision, dimension(n + 2,n + 2) :: f

	delta = 1/(n+1)

	do i = 1, n
		x = i*delta		
		do j = 1, n				
			y = j*delta		
			f(i+1,j+1) = 2*(cos(x + y) -(1 + x)*sin(x + y)) 
		end do
	end do

	do j = 1, n+2
		y = j*delta
		f(1,j) = sin(y) 
		f(n+2, j) =(1 + 1)*sin(1 + y)

		x = y
		f(j, 1) = (1 + x)*sin(x)
		f(j, n+2) = (1 + x)*sin(x + 1) 
	end do 	
end subroutine initFull

subroutine initSolFull(U, n)
! Subroutine to initialize the solution for the PDE

  implicit none 
  integer	   ::  n, i, j
  double precision :: delta, x, y, last
  double precision, dimension(n + 2,n + 2) :: U

	delta = 1/(n+1)

	do i = 1, n + 2
		x = (i - 1)*delta		
		do j = 1, n + 2					
			y = (j - 1)*delta					
			f(i,j) = (x+1)*sin(x + y)		
		end do
	end do

end subroutine inisol


