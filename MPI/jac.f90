program main

  implicit none
  include    "mpif.h"
  integer     message, length, source, dest, tag
  integer     my_rank, err
  integer     n_procs  
  integer     status(MPI_STATUS_SIZE)
  integer 				:: n, i
  double precision, allocatable, dimension(:, :) :: U, F
	double precision:: tau, delta 

! Start up MPI
  call MPI_Init(err)  

! Find out the number of n_processes and my rank 
  call MPI_Comm_rank(MPI_COMM_WORLD, my_rank, err)
  call MPI_Comm_size(MPI_COMM_WORLD, n_procs, err)


  n = 10 												! Gridsize
  allocate(F(0:n + 1, 0:n + 1)) ! (n + 2)^2 gridpoints
  allocate(U(n,n)) 							! (n)^2 gridpoints

	tau = 0.1d0						 				! Minimum error


! Initialize F and U
	call initFull(F, n)
	call initSolFull(U, n)

	do i = 1, n/2
		print*, F(i, 1)
	end do


	do while(delta >= tau)

		delta = 0.01 ! Change this one!!

	! I'm the master process 
		if ( my_rank == 0 ) then 

		!call MPI_Sendrecv(sendbuf, sendcount, sendtype, dest, sendtag, recvbuf, 
			!									recvcount, recvtype, source, recvtag, comm, status) 

			
	

	! I'm the slave process 
  	else  


  	end if

	end do


! Shut down MPI 
  call MPI_Finalize(err)  

! Free the space
  deallocate(U)
  deallocate(F)

end program main
