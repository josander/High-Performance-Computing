program allocprogram alloc
  integer 				:: n
  double precision, allocatable, dimension(:, :) :: U, f
	double precision:: tau, delta 

  n = 10 !
  allocate(f(0:n +1, 0:n +1)) ! (n + 2)^2 gridpoints
  allocate(U(n,n)) ! (n)^2 gridpoints

	tau = 0.1d0							! min error
  call random_number(A)  ! work with A ...
  print*, A(1, 1)        ! or whatever

  call random_number(B)  ! work with B ...
  print*, B(0, :)        ! or whatever
  print*, B(n, 0)
	
	

	do while(delta >= tau)
		delta = 0.01

	end do

  deallocate(B)          ! free the space

end program alloc
