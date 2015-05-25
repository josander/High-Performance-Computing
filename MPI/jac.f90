program main

  implicit none
  include    				"mpif.h"
  integer    :: 		message, length, source, dest, tag
  integer    ::			myRank, err
  integer    ::			n_procs
	integer		 ::			row, col  
  integer    ::		 	status(MPI_STATUS_SIZE)
  integer 	 ::			n, i, j, nHalf
	integer    ::			xOff, yOff, run
  double precision, allocatable, dimension(:, :) :: F, S
  double precision, allocatable, dimension(:) :: temp1, temp2
	double precision :: tau, delta, h, hSq, tryMaxError1, tryMaxError2, tryMaxError3, maxError

! The map between subdomains and myRank
!			 _______		
!			| 3	|	2 |
!			|___|___|
!			| 0 | 1 |
!			|___|___|


! Start up MPI
  call MPI_Init(err) 

! Find out the number of n_processes and my rank 
  call MPI_Comm_rank(MPI_COMM_WORLD, myRank, err)
  call MPI_Comm_size(MPI_COMM_WORLD, n_procs, err)

  n = 100												! Gridsize
	tau = 0.00001d0						 				! Minimal error
	h = 1.0/(n+1)
	hSq = h**(2)
	run = 1
	tag = 1

	nHalf = n/2
	allocate(F(nHalf, nHalf)) 								! (n/2)^2 gridpoints
  allocate(S(0:nHalf + 1, 0:nHalf + 1)) 		! Our solution
  allocate(temp1(nHalf))
  allocate(temp2(nHalf))


	delta = 1.0d0									! Initial value



	select case (myRank) ! Constants used to locate which edges that borders the boundary. 
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

! Initialize S
	call initSPart(S,n, myRank)

! Initialize F and U
	call initFPart(F, n, myRank)


	print*, "Testing testing", myRank

	do while(run == 1)

		delta = 0.1d0 
		
		!Sendrecv the edge_cols
		col = nHalf - xOff*nHalf + xOff		
		do i = 1, nHalf
			temp1(i) = S(i, col) 
		end do

		dest = myRank  + (-1)**(myRank)   !(0-1, 2-3)   

		!SENDRECV COLS. Send temp1 and receive temp2
		call MPI_Sendrecv(temp1, nHalf, MPI_DOUBLE, dest, tag, temp2, nHalf, MPI_DOUBLE, dest, tag, MPI_COMM_WORLD, status, err) 

		col = (nHalf + 1) - xOff*(nHalf + 1) ! nHalf + 1 OR 0
		do i = 1, nHalf
			S(i,col) = temp2(i) 
		end do


		!Sendrecv the edge_rows
		row =  nHalf - yOff*nHalf + yOff		
		do i = 1, nHalf
			temp1(i) = S(row, i)
		end do

		dest =  3 - myRank  							!(0-3, 1-2)

		!SENDRECV ROWS HERE. Send temp1, receive temp2

		call MPI_Sendrecv(temp1, nHalf, MPI_DOUBLE, dest, tag, temp2, nHalf, MPI_DOUBLE, dest, tag, MPI_COMM_WORLD, status, err) 

		
		row = (nHalf + 1) - yOff*(nHalf + 1) 
		do i = 1, nHalf
			S(row,i) = temp2(i)
		end do

		! Jacobi iteration
		do j = 1 , nHalf
			temp2(j) = S(j, 0) ! Save the first column
		end do

		maxError = 0.0		
		do i = 1 , nHalf 			
			do j = 1 , nHalf 
				temp1(j) = S(j,i)
				S(j,i) = 0.25*(S(j - 1,i) + S(j + 1,i) + S(j,i + 1) + temp2(j) - hSq*F(j,i))
				temp2(j) = temp1(j)
				temp1(j) = abs(temp1(j) - S(j,i)) 		 
			end do 

			maxError = max(MAXVAL(temp1), maxError) ! Change the maximum error

		end do
		! Calculate the biggest delta in the solution
		if (myRank /= 0) then

			dest = 0 ! Send the maximum error to the master process to evaluate
			call MPI_Send(maxError, 1, MPI_DOUBLE, dest, tag, MPI_COMM_WORLD, err)
			call MPI_Recv(run, 1, MPI_INTEGER, 0, tag, MPI_COMM_WORLD, status, err)

		else

			call MPI_Recv(tryMaxError1, 1, MPI_DOUBLE, 1, tag, MPI_COMM_WORLD, status, err)
			call MPI_Recv(tryMaxError2, 1, MPI_DOUBLE, 2, tag, MPI_COMM_WORLD, status, err)
			call MPI_Recv(tryMaxError3, 1, MPI_DOUBLE, 3, tag, MPI_COMM_WORLD, status, err)
			delta = max(tryMaxError1, tryMaxError2, tryMaxError3, maxError)

			if (delta < tau) then
				run = 0
			end if
			
			call MPI_Send(run, 1, MPI_INTEGER, 1, tag, MPI_COMM_WORLD, err)
			call MPI_Send(run, 1, MPI_INTEGER, 2, tag, MPI_COMM_WORLD, err)
			call MPI_Send(run, 1, MPI_INTEGER, 3, tag, MPI_COMM_WORLD, err)
		end if
	end do
	
	! Test the solution
	call initSolPart(F, n, myRank)	! Get the analytical solution

	maxError = -1.0
	do i = 1, nHalf
		do j = 1, nHalf
			temp1(j) = abs(S(j,i) - F(j,i)) 
		end do
		maxError = max(MAXVAL(temp1), maxError)
	end do

	! Prit the largest error in each part
	print*, 'MaxError: ', maxError, "Rank:", myRank 

! Shut down MPI 
  call MPI_Finalize(err)  

! Free the space
  deallocate(S)
  deallocate(F)

end program main
