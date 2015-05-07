program main
!
! Comments: everything after !
! Case or blanks are not significant
! (unless they are in strings).
!
  implicit none  ! recommended
  integer           :: rows, cols, n, calls
  double precision  :: temp
  double precision :: fsecond, t, t1, time

! Arrays start at one by default.
  double precision, dimension(5000, 5000) :: A
  double precision, dimension(5000) :: matrixSum

  n = 5000

  do rows = 1, n
    do cols = 1, n
			A(rows,cols) = 1.0d0 / (rows + cols)
    end do
  end do

  t = fsecond()

	do calls = 1, 40
		call row_sum(matrixSum, A, n)
	end do

  t1 = fsecond() - t
  time = t1 / 40.0d0

	print*, sum(matrixSum), time


! Set matrixSum to zero
	do rows = 1, n
		matrixSum(rows) = 0.0d0
	end do

  t = fsecond()

	do calls = 1, 40
		call col_sum(matrixSum, A, n)
	end do

  t1 = fsecond() - t
  time = t1 / 40.0d0

	print*, sum(matrixSum), time

end program main

