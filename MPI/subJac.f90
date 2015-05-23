subroutine initFull(F, n)
! Subroutine to initialize the f + g matrix

  implicit none 
  integer	   ::  n, i, j
  double precision :: h, x, y
  double precision, dimension(n + 2,n + 2) :: F

	h = 1.0/(n+1)

	! Initialize the inner points in the matrix. Do the operations column-wise
	do i = 1, n
		y = i*h		
		do j = 1, n				
			x = j*h		
			F(j+1,i+1) = 2*(cos(x + y) -(1 + x)*sin(x + y)) 
		end do
	end do

	! Initialize the boundary
	do j = 1, n+2
		y = j*h
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
  double precision :: h, x, y
  double precision, dimension(n ,n ) :: U

	h = 1.0/(n+1)

	! Initialize U. Do the operations column-wise
	do i = 1, n 
		y = i*h		
		do j = 1, n					
			x = j*h					
			U(j,i) = (x+1)*sin(x + y)		
		end do
	end do

end subroutine initSolFull


subroutine initFPart(F, n, myRank)
! Subroutine to initialize the f matrix

  implicit none 
  integer	   ::  n, i, j, myRank, xOff, yOff, nHalf
  double precision :: h, x, y
  double precision, dimension(n/2,n/2) :: F

	h = 1.0/(n+1)
	nHalf = n/2

	select case (myRank)
		case(0)
			xOff = 0
			yOff = 0
		case(1)
			xOff = 1 
			yOff = 0
		case(2)
			xOff = 1
			yOff = 1
		case(3)
			xOff = 0
			yOff = 1
	end select

	do i = 1, nHalf 
		y = (yOff * nHalf + i)*h 
		do j = 1, nHalf				
			x = (xOff * nHalf +j)*h	
			F(j + (1 - xOff),i + (1 - yOff)) = 2*(cos(x + y) -(1 + x)*sin(x + y)) 
		end do
	end do

end subroutine initFPart


subroutine initSolPart(U, n, myRank)
! Subroutine to initialize the solution for the PDE

  implicit none 
  integer	   ::  n, i, j, myRank, nHalf, xOff, yOff
  double precision :: h, x, y
  double precision, dimension(n/2 ,n/2 ) :: U
	
	h = 1.0/(n+1)
	nHalf = n/2

	select case (myRank)
		case(0)
			xOff = 0
			yOff = 0
		case(1)
			xOff = 1 
			yOff = 0
		case(2)
			xOff = 1
			yOff = 1
		case(3)
			xOff = 0
			yOff = 1
	end select

	do i = 1, nHalf 
		y = (yOff*nHalf + i)*h		
		do j = 1, nHalf					
			x = (xOff*nHalf + j)*h					
			U(j,i) = (x+1)*sin(x + y)		
		end do
	end do

end subroutine initSolPart

subroutine initSPart(S, n, myRank)
! Subroutine to initialize the the S with g matrix

  implicit none 
  integer	   ::  n, i, j, myRank, xOff, yOff, nHalf
  double precision :: h, x, y
  double precision, dimension(0: n/2+1 ,0:n/2+1) :: S

	h = 1.0/(n+1)
	nHalf = n/2

	select case (myRank)
		case(0)
			xOff = 0
			yOff = 0
		case(1)
			xOff = 1 
			yOff = 0
		case(2)
			xOff = 1
			yOff = 1
		case(3)
			xOff = 0
			yOff = 1
	end select

	do i = 0, nHalf + 1  
		do j = 0, nHalf + 1					
			S(j,i) = 0.0 
		end do
	end do

	do j = 1, nHalf + 1
		y = (j - 1 + nHalf*yOff )*h 
		F(xOff*nHalf + 1, j + yOff*nHalf) =(1 + xOff)*sin(xOff + y)

		x = (j - 1 + nHalf*xOff )*h
		F(j + xOff*nHalf, yOff*nHalf + 1) = (1 + x)*sin(x + yOff) 
	end do 	
end subroutine initFPart


