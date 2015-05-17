subroutine row_sum(matrixSum, A, n)
! Row sum of a big matrix A

	implicit none
	integer :: cols, rows, n, rowBlock
	double precision, dimension(n, n) :: A
	double precision, dimension(n) :: matrixSum

	do rows = 1, n
		do cols = 1, n
			matrixSum(rows) = matrixSum(rows) + A(rows, cols)
		end do
	end do

end subroutine


subroutine col_sum(matrixSum, A, n)
! Col sum of a big matrix A

	implicit none
	integer :: cols, rows, n
	double precision, dimension(n, n) :: A
	double precision, dimension(n) :: matrixSum

	do cols = 1, n
		do rows = 1, n
			matrixSum(cols) = matrixSum(cols) + A(rows, cols)
		end do
	end do

end subroutine


subroutine fast_row_sum(matrixSum, A, n, Mblock)
! Sum of a big matrix A using blocks

	implicit none
	integer :: cols, rows, n, Mblock,	rowBlock
	double precision, dimension(n, n) :: A
	double precision, dimension(n) :: matrixSum

	do rows = 1, n, Mblock 
		do cols = 1, n
			do rowBlock = rows, rows + Mblock - 1
				matrixSum(rowBlock) = matrixSum(rowBlock) + A(rowBlock, cols)
			end do
		end do
	end do

end subroutine

