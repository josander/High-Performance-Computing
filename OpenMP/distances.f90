program main

  implicit none

	integer						::			numCells, n, m, hashInd 					
	double precision	::			distMax, distRes, dist
	double precision, allocatable, dimension(:)		:: sumTable
	integer, allocatable, dimension(:)						:: numTable
! Read file

! Create hash table
	distMax = 70.0
	distRes = 0.001


	allocate(sumTable(INT((distMax - 1.0)/distRes + 1)) ! 69001 elemets
	allocate(numTable(INT((distMax - 1.0)/distRes + 1))

! Paralell thing

	do n = 1, numCells
		do m = n + 1, numCells

			dist = sqrt((cell1(1) - cell2(1))**2 + (cell1(2) - cell2(2))**2 +(cell1(3) - cell2(3))**2)

	end do 

! Merge everything and compute the averages


end program main
