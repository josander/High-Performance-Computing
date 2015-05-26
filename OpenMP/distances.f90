program main

	implicit none
	include 'omp_lib.h'
	integer						::			numCells,hashInd, i,j, numUniq, sumUniq			
	double precision	::			distMax, distRes, dist,t ,t1,fsecond

	double precision, dimension(3)									:: tempCell
	integer, allocatable, dimension(:)							:: numTable
	double precision, allocatable, dimension(:,:)		:: cell

! Read file
	open(unit = 1, file = 'cells', action = 'read') 
 
	distMax = 70.0 ! Maximum dist
	distRes = 0.001	! Resolution of distances
	numCells = 50000 ! Number of cells to be read from file (max 64000) 

! Allocate memory
	allocate(numTable(INT(1/distRes) : INT((distMax)/distRes + 1)))
	allocate(cell(3, numCells))


! Initialize the hash table
	do i = INT(1/distRes), INT((distMax)/distRes + 1)
		numTable(i) = 0
	end do

	do i = 1, numCells
		read(1,*), cell(1,i), cell(2,i), cell(3,i)
	end do		

!  t = fsecond() ! for debugging and testing

! Paralell region
!$OMP parallel do private(hashInd, dist,  i, j, tempCell) REDUCTION( + : numTable) schedule(dynamic)
	do j = 1, numCells 			
		tempCell = cell(:,j)
		do i = j+1, numCells
				dist = sqrt((tempCell(1) - cell(1,i))**2 + (tempCell(2) - cell(2,i))**2 +(tempCell(3) - cell(3,i))**2)
				hashInd = INT(1000*dist )
				numTable(hashInd) =  numTable(hashInd) + 1 
		end do
	end do 	

!$OMP end parallel do 

!	t1 = fsecond() - t	
!	print*,"Time:", t1 

! Compute the averages and write to file
	numUniq = 0 
	sumUniq	= 0

  open (unit=22,file="results.txt",action="write",status="replace")
! Print the number of times each distance occurs
	do i = INT(1/distRes), INT((distMax)/distRes + 1)
		if(numTable(i) > 0) then		
			numUniq = numUniq + 1 
			sumUniq = sumUniq + numTable(i)
			write (22,'(F6.3,i10)'), i/1000.0, numTable(i)
		end if
	end do
! Print the number of unique distances and the total number of computed distances  
	write (22,*),"numUniq: ", numUniq,"sumUniq: ", sumUniq 
! Note that each pair of distances only is counted once since d(a,b) = d(b,a)


! Close units
 	close (unit =22)
	close(unit = 1)


end program main
