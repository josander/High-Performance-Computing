program main


implicit none
integer :: rows, cols, n, calls, block
double precision:: temp
double precision 	:: fsecond, t, t1, time

double precision, dimension(5000, 5000) :: A
double precision, dimension(5000) :: matrixSum

n = 5000

do rows = 1, n
	do cols = 1, n
			A(rows,cols) = 1.0d0 / (rows + cols)
	end do
end do

	print*, 'METHOD ', 'SUMMATION OF MATRIX ', 'TIME'
	print*, '------------------------------------------------------------'

!----Call row_sum 40 times------------------------------------------------------

t = fsecond()

	do calls = 1, 40
		call row_sum(matrixSum, A, n)
	end do

	t1 = fsecond() - t
	time = t1 / 40.0d0

	print*, 'Row_sum', sum(matrixSum), time


! Set matrixSum to zero
	do rows = 1, n
		matrixSum(rows) = 0.0d0
	end do

!----Call col_sum 40 times------------------------------------------------------

	t = fsecond()

	do calls = 1, 40
		call col_sum(matrixSum, A, n)
	end do

	t1 = fsecond() - t
	time = t1 / 40.0d0

	print*, 'Col_sum:', sum(matrixSum), time


! Set matrixSum to zero
	do rows = 1, n
		matrixSum(rows) = 0.0d0
	end do

!----Call fast_sum 40 times-----------------------------------------------------

	block = 500 ! Number of rows per block. Must be evenly divide n (5000)	
	t = fsecond()

	do calls = 1, 40
		call fast_row_sum(matrixSum, A, n, block)

	end do

	t1 = fsecond() - t
	time = t1 / 40.0d0

	print*, 'Fast_sum:', sum(matrixSum), time


end program main

