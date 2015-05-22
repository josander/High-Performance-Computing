program main

  implicit none
  include    "mpif.h"
  integer     message, length, source, dest, tag
  integer     my_rank, err
  integer     n_procs  
  integer     status(MPI_STATUS_SIZE)
  integer 				:: n
  double precision, allocatable, dimension(:, :) :: U, f
	double precision:: tau, delta 

! Start up MPI
  call MPI_Init(err)  

! Find out the number of n_processes and my rank 
  call MPI_Comm_rank(MPI_COMM_WORLD, my_rank, err)
  call MPI_Comm_size(MPI_COMM_WORLD, n_procs, err)


  n = 10 											! Gridsize
  allocate(f(0:n +1, 0:n +1)) ! (n + 2)^2 gridpoints
  allocate(U(n,n)) 						! (n)^2 gridpoints

	tau = 0.1d0						 ! Minimum error

	do while(delta >= tau)
		delta = 0.01
	end do


! I'm the master process 
	if ( my_rank == 0 ) then 


! I'm the slave process 
  else  


  end if


! Shut down MPI 
  call MPI_Finalize(err)  

! Free the space
  deallocate(U)
  deallocate(f)

end program main
