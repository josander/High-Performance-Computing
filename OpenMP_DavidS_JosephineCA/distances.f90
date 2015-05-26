program main

	implicit none
	include 'omp_lib.h'
	integer						::			numCells, n, m, hashInd, i,j, k, numUniq, sumUniq, blockSize					
	double precision	::			distMax, distRes, dist,t ,t1,fsecond

	double precision, allocatable, dimension(:)			:: distTable
	integer, allocatable, dimension(:)							:: numTable
	double precision, allocatable, dimension(:,:)		:: cell1, cell2

! Read file
	open(unit = 1, file = 'cells', action = 'read') 

	distMax = 70.0
	distRes = 0.001
	numCells = 50000
	blockSize = 5000 !numCells%blockSize must be 0 and numCells/blockSize >= numThreads  

! Allocate memory
	allocate(distTable(INT(1/distRes) : INT((distMax)/distRes + 1))) 
	allocate(numTable(INT(1/distRes) : INT((distMax)/distRes + 1)))
	allocate(cell1(3, blockSize))
	allocate(cell2(3, blockSize)) 	 	

! Initialize the hash table
	do i = INT(1/distRes), INT((distMax)/distRes + 1)
		distTable(i) = 0.0
		numTable(i) = 0
	end do


  t = fsecond()

! Paralell thing

!$OMP parallel do private(n, m, hashInd, dist, k, i, j,  cell1, cell2) REDUCTION( + : distTable, numTable)
	do j = 1, numCells  , blockSize
		
!$OMP CRITICAL 
		rewind 1
		do i = 1, j - 1
			read(1,*) 
		end do
		do i = 1, blockSize
			read(1,*) cell1(1,i), cell1(2,i), cell1(3,i) 
		
		end do		
!$OMP END CRITICAL 
	
		!Evaluate the first block
		do n = 1, blockSize
			do m = n+ 1 , blockSize
			dist = sqrt((cell1(1,n) - cell1(1,m))**2 + (cell1(2,n) - cell1(2,m))**2 +(cell1(3,n) - cell1(3,m))**2)
			hashInd = INT(1000*dist)
		
			distTable(hashInd) = distTable(hashInd) + dist
			numTable(hashInd) =  numTable(hashInd) + 1 
	
			end do
		end do

		do k = blockSize + j , numCells , blockSize
!$OMP CRITICAL 
			rewind 1
			do i = 1, k - 1
				read(1,*) 
			end do
			do i = 1, blockSize
				read(1,*) cell2(1,i), cell2(2,i), cell2(3,i)
			end do		
!$OMP END CRITICAL 

			do n = 1, blockSize
				do m = 1 , blockSize
				!print*, cell1(1,n), cell2(1,m)			
				dist = sqrt((cell1(1,n) - cell2(1,m))**2 + (cell1(2,n) - cell2(2,m))**2 +(cell1(3,n) - cell2(3,m))**2)
				hashInd = INT(1000*dist)

				distTable(hashInd) = distTable(hashInd) + dist
				numTable(hashInd) =  numTable(hashInd) + 1 
	
				end do
			end do
		end do		
	end do
!$OMP end parallel do 

! Compute the averages and write to file
	numUniq = 0 
	sumUniq	= 0

  open (unit=22,file="results.txt",action="write",status="replace")

	do i = INT(1/distRes), INT((distMax)/distRes + 1)
		if(numTable(i) > 0) then		
			distTable(i) = distTable(i)/numTable(i)
			numUniq = numUniq + 1 
			sumUniq = sumUniq + numTable(i)
			write (22,*), distTable(i), numTable(i)  
		end if
	end do
  
	write (22,*),"numUniq: ", numUniq,"sumUniq: ", sumUniq  

	t1 = fsecond() - t	
	print*,"Time:", t1 

! Close units
 	close (unit =22)
	close(unit = 1)


end program main
