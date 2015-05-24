program main

  implicit none
	integer 						:: i
	double precision, dimension(3)		:: coordinates


! Read file
	open(unit = 1, file = 'cells', action = 'read')

	do i = 1, 5
		read(1,*) coordinates
		print*, coordinates
	end do

! Create hash table

! Paralell thing

! Merge everything and compute the averages

	close(unit = 1)


end program main
