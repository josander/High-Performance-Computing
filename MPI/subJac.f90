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
		
		x = (xOff * nHalf +i)*h	 
		do j = 1, nHalf				
			y = (yOff * nHalf + j)*h
			F(j,i)= 2*(cos(x + y) - ((1 + x)*sin(x + y))) 
		end do
	end do

end subroutine initFPart

subroutine initSolPart(U, n, myRank)
! Subroutine to initialize the solution for the PDE
! u = (x+1)sin(x + y)

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
		x = (xOff*nHalf + i)*h			
		do j = 1, nHalf					
			y = (yOff*nHalf + j)*h		
			U(j,i) = (x+1)*sin(x + y)		
		end do
	end do

end subroutine initSolPart

subroutine initSPart(S, n, myRank)
! Subroutine to initialize the S matrix with g vectors 

  implicit none 
  integer	   ::  n, i, j, myRank, xOff, yOff, nHalf
  double precision :: h, x, y
  double precision, dimension(0: n/2 + 1 ,0:n/2 + 1) :: S

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

	!initialize the boundary g(x,y) = (1 + x)sin(x + y)
	do j = 1, nHalf 
		y = (j + nHalf*yOff )*h 
		S(j, xOff*( nHalf + 1  )) =(1 + xOff)*sin(xOff + y)

		x = (j + nHalf*xOff )*h
		S(yOff*(nHalf + 1), j) = (1 + x)*sin(x + yOff) 
	end do 	
end subroutine initSPart


