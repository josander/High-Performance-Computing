subroutine row_sum(matrixSum, A, n)

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

subroutine fast_sum(matrixSum, A, n)

  implicit none
  integer :: cols, rows, n, block,  rowBlock
  double precision, dimension(n, n) :: A
  double precision, dimension(n) :: matrixSum

  block = 1000
  do rows = 1, n, block
    do cols = 1, n
		do rowBlock = rows, rows + block
		  matrixSum(rowBlock) = matrixSum(rowBlock) + A(rowBlock, cols)
		end do
    end do
  end do
end subroutine

