subroutine initFull(F, n)
! Subroutine to initialize the f + g matrix

  implicit none 
  integer	   ::  n, i, j
  double precision :: delta, x, y
  double precision, dimension(n + 2,n + 2) :: F

	delta = 1/(n+1)

	do i = 1, n
		x = i*delta		
		do j = 1, n				
			y = j*delta		
			F(i+1,j+1) = 2*(cos(x + y) -(1 + x)*sin(x + y)) 
		end do
	end do

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
  double precision :: delta, x, y
  double precision, dimension(n ,n ) :: U

	delta = 1/(n+1)

	do i = 1, n 
		x = (i )*delta		
		do j = 1, n					
			y = (j )*delta					
			U(i,j) = (x+1)*sin(x + y)		
		end do
	end do

end subroutine iniSolFull

subroutine initFPart(F, n, myRank)
! Subroutine to initialize the f + g matrix

  implicit none 
  integer	   ::  n, i, j, myRank, xOff, yOff, nHalf
  double precision :: delta, x, y
  double precision, dimension(n/2 + 1,n/2 + 1) :: F

	delta = 1/(n+1)
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
		y = (yOff * nHalf + i)*delta 
		do j = 1, nHalf				
			x = (xOff * nHalf +j)*delta	
			F(j + (1 - xOff),i + (1 - yOff)) = 2*(cos(x + y) -(1 + x)*sin(x + y)) 
		end do
	end do

	do j = 1, nHalf + 1
		y = (j-1)*delta 
		F(xOff*nHalf + 1, j + yOff*nHalf) =(1 + xOff)*sin(xOff + y)

		x = y
		F(j + xOff*nHalf, yOff*nHalf) = (1 + x)*sin(x + yOff) 
	end do 	
end subroutine initFPart

subroutine initSolPart(U, n, myRank)
! Subroutine to initialize the solution for the PDE

  implicit none 
  integer	   ::  n, i, j, myRank
  double precision :: delta, x, y
  double precision, dimension(n/2 ,n/2 ) :: U

	delta = 1/(n+1)
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
		x = (xOff*nHalf + i)*delta		
		do j = 1, nHalf					
			y = (yOff*nHalf + j)*delta					
			U(i,j) = (x+1)*sin(x + y)		
		end do
	end do

end subroutine iniSolPart



