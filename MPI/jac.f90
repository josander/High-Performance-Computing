program main

  implicit none
  include    "mpif.h"
  integer     message, length, source, dest, tag
  integer     my_rank, err
  integer     n_procs  
  integer     status(MPI_STATUS_SIZE)
  integer 				:: n, i, j
	integer			xOff, yOff
  double precision, allocatable, dimension(:, :) :: U, F, S
  double precision, allocatable, dimension(:) :: temp1, temp2
	double precision:: tau, delta 

! Start up MPI
  call MPI_Init(err) 

! Find out the number of n_processes and my rank 
  call MPI_Comm_rank(MPI_COMM_WORLD, my_rank, err)
  call MPI_Comm_size(MPI_COMM_WORLD, n_procs, err)


  n = 10 												! Gridsize
  allocate(F(0:n + 1, 0:n + 1)) ! (n + 2)^2 gridpoints
  allocate(S(0:n + 1, 0:n + 1)) ! (n + 2)^2 gridpoints, our solution
  allocate(U(n,n)) 							! (n)^2 gridpoints, the analytical solution
  allocate(temp1(n/2))
  allocate(temp2(n/2))

	tau = 0.1d0						 				! Minimal error


	delta = 1.0/(n+1)
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
		do i = 1, nHalf
			temp1(i) = S(i, nHalf - xOff*nHalf + xOff)
		end do

		dest = my_rank  + (-1)^(my_rank)    
		!SENDRECV COLS HERE
		
		do i = 1, nHalf
			S(i,nHalf - xOff*nHalf + xOff + 1 ) = temp2(i)
		end do


		!Sendrecv the edge_rows
		do i = 1, nHalf
			temp1(i) = S( nHalf - yOff*nHalf + yOff, i)
		end do

		!TO DO FIXA DEST (0-3, 1-2) 
		!SENDRECV ROWS HERE

		do i = 1, nHalf
			S(nHalf - yOff*nHalf + yOff + 1 ,i) = temp2(i)
		end do


		! HÄR DET HÄNDER

	! I'm the master process 
		if ( my_rank == 0 ) then 

		!call MPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, 
			!									recvcount, recvtype, source, recvtag, comm, status) 

			
	

	! I'm the slave process 
  	else  


  	end if


	
	end do

	!


! Shut down MPI 
  call MPI_Finalize(err)  

! Free the space
  deallocate(U)
  deallocate(F)

end program main
