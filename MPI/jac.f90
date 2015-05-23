program main

  implicit none
  include    "mpif.h"
  integer     message, length, source, dest, tag
  integer     my_rank, err
  integer     n_procs
	integer			row, col  
  integer     status(MPI_STATUS_SIZE)
  integer 				:: n, i, j, nHalf
	integer			xOff, yOff
  double precision, allocatable, dimension(:, :) :: U, F, S
  double precision, allocatable, dimension(:) :: temp1, temp2
	double precision:: tau, delta, h, hSq

! Start up MPI
  call MPI_Init(err) 

! Find out the number of n_processes and my rank 
  call MPI_Comm_rank(MPI_COMM_WORLD, my_rank, err)
  call MPI_Comm_size(MPI_COMM_WORLD, n_procs, err)

  n = 10 												! Gridsize

	nHalf = n/2
	allocate(F(nHalf, nHalf)) ! (n/2)^2 gridpoints
  allocate(S(0:n/2 + 1, 0:n/2 + 1)) 		! Our solution
  allocate(U(nHalf,nHalf)) 							! (n)^2 gridpoints, the analytical solution
  allocate(temp1(nHalf))
  allocate(temp2(nHalf))

	tau = 0.1d0						 				! Minimal error



	h = 1.0/(n+1)
	hSq = h**(2)


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


	do i = 1 , nHalf + 1
		do j = 1, nHalf + 1 
			S(j, i) = 0.0d0
		end do
	end do


! Initialize F
	call initFull(F, n)

	do while(delta >= tau)

		delta = 0.01 ! Change this one!!
		
		!Sendrecv the edge_cols
		col = nHalf - xOff*nHalf + xOff		
		do i = 1, nHalf
			temp1(i) = S(i, col) 
		end do

		dest = my_rank  + (-1)**(my_rank)   !(0-1, 2-3)   

		!SENDRECV COLS. Send temp1 and receive temp2
		call MPI_Sendrecv(temp1, nHalf, MPI_DOUBLE, dest, tag, temp2, nHalf, MPI_DOUBLE, dest, tag, MPI_COMM_WORLD, status) 
		
		col = (nHalf + 1) - xOff*(nHalf + 1) ! nHalf + 1 OR 0
		do i = 1, nHalf
			S(i,col) = temp2(i) 
		end do


		!Sendrecv the edge_rows
		row =  nHalf - yOff*nHalf + yOff		
		do i = 1, nHalf
			temp1(i) = S(row, i)
		end do

		dest =  3 - my_rank  							!(0-3, 1-2)

		!SENDRECV ROWS HERE. Send temp1, receive temp2
		call MPI_Sendrecv(temp1, nHalf, MPI_DOUBLE, dest, tag, temp2, nHalf, MPI_DOUBLE, dest, tag, MPI_COMM_WORLD, status) 
		
	
		row = (nHalf + 1) - yOff*(nHalf + 1) 

		do i = 1, nHalf
			S(row,i) = temp2(i)
		end do

			

		! HÄR DET HÄNDER
		do j = 1 , nHalf
			temp2(j) = S(j, 0) ! Save the first column
		end do

		
		do i = 1 , nHalf 			
			do j = 1 , nHalf 
				temp1(j) = S(j,i)
				S(j,i) = 0.25*(S(j - 1,i) + S(j + 1,i) + S(j,i + 1) + temp2(j) + hSq*F(j,i))
				 



		end do 
	end do

	!


! Shut down MPI 
  call MPI_Finalize(err)  

! Free the space
  deallocate(U)
  deallocate(F)

end program main
