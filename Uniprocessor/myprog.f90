program main
!
! Comments: everything after !
! Case or blanks are not significant
! (unless they are in strings).
!
  implicit none  ! recommended
  integer           :: k, n, in
  double precision  :: s
  double precision  :: ddot   ! a function

! Arrays start at one by default.
  double precision, dimension(100) :: a, b

  n = 100
  print*, "Type a value for in:"
  read*,  in
  print*, "This is how you write: in = ", in

  do k = 1, n             ! do when k = 1, 2, ..., n
    a(k) = k
    b(k) = -sin(dble(k))  ! using sin
  end do
!
! Call by reference for all variables.
!
  print*, "The inner product is ", ddot(a, b, n)

  call sum_array(a, s, n)    ! NOTE, call
  print*, "The sum of the array is ", s

  print*, "The inner product is ", dot_product(a, b)
  print*, "The sum of the array is ", sum(a)

end program main

function ddot(x, y, n) result(s)
!
!     Fortran has an implicit type rule but
!     implicit none forces you to declare everything.
!     Highly recommended!
!
  implicit none
  integer :: n
  double precision, dimension(n) :: x, y

  integer          :: k
  double precision :: s

  s = 0.0
  do k = 1, n
    s = s + x(k) * y(k)
  end do

end function ddot

subroutine sum_array(a, s, n)
  implicit none
  integer           :: n
  double precision  :: s
  double precision, dimension(n) :: a

  integer :: k

  s = 0.0   ! 0.0 is single and 0.0d0 double
  do k = 1, n
    s = s + a(k)
  end do

end subroutine sum_array
