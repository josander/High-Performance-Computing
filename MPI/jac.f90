program main

  implicit none
  include    "mpif.h"
  integer     message, length, source, dest, tag
  integer     my_rank, err
  integer     n_procs    ! number of processes 
  integer     status(MPI_STATUS_SIZE)
  integer 				:: n
  double precision, allocatable, dimension(:, :) :: U, f
	double precision:: tau, delta 

  call MPI_Init(err)  ! Start up MPI

! Find out the number of n_processes and my rank 
  call MPI_Comm_rank(MPI_COMM_WORLD, my_rank, err)
  call MPI_Comm_size(MPI_COMM_WORLD, n_procs, err)


  n = 10 !
  allocate(f(0:n +1, 0:n +1)) ! (n + 2)^2 gridpoints
  allocate(U(n,n)) ! (n)^2 gridpoints

	tau = 0.1d0						 ! min error
  call random_number(A)  ! work with A ...
  print*, A(1, 1)        ! or whatever

  call random_number(B)  ! work with B ...
  print*, B(0, :)        ! or whatever
  print*, B(n, 0)
	
	

	do while(delta >= tau)
		delta = 0.01

	end do


	if ( my_rank == 0 ) then ! I'm the master process 

  
  else  ! I'm the slave process 


  end if

  
  call MPI_Finalize(err)  ! Shut down MPI 


  deallocate(B)          ! free the space

end program main
