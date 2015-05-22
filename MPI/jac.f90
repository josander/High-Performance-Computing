program main

  implicit none
  include    "mpif.h"
  integer     message, length, source, dest, tag
  integer     my_rank, err
  integer     n_procs  
  integer     status(MPI_STATUS_SIZE)
  integer 				:: n, i
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
  allocate(S(n/2+1, n/2+1)) 		! Our solution
  allocate(U(n,n)) 							! (n)^2 gridpoints, the analytical solution
  allocate(temp1(n/2))
  allocate(temp2(n/2))

	tau = 0.1d0						 				! Minimal error

! Initialize F
	call initFull(F, n)

	do while(delta >= tau)

		delta = 0.01 ! Change this one!!




	end do


! Shut down MPI 
  call MPI_Finalize(err)  

! Free the space
  deallocate(U)
  deallocate(F)

end program main
