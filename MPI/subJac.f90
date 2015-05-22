subroutine initFull(F, n)
! Subroutine to initialize the f + g matrix

  implicit none 
  integer	   ::  n, i, j
  double precision :: delta, x, y, last
  double precision, dimension(n + 2,n + 2) :: F

	delta = 1.0/(n+1)

	! Initialize the inner points in the matrix. Do the operations column-wise
	do i = 1, n
		y = i*delta		
		do j = 1, n				
			x = j*delta		
			F(j+1,i+1) = 2*(cos(x + y) -(1 + x)*sin(x + y)) 
		end do
	end do

	! Initialize the boundary
	do j = 1, n+2
		y = j*delta
		F(1,j) = sin(y) 
		F(n+2, j) =(1 + 1)*sin(1 + y)

		x = y
		F(j, 1) = (1 + x)*sin(x)
		F(j, n+2) = (1 + x)*sin(x + 1) 
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
			U(i,j) = (x+1) * sin(x+y)

		end do
	end do

end subroutine initSolFull


