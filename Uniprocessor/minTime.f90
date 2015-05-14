program main
! This program takes the time for some basic operations

! Start of our program
  implicit none 
  integer(8)	   :: k, n
  double precision :: fsecond, t, t1, t2, t3, t4, t5, cpuTime
  double precision :: expFunk
  real :: cput1, cput2 

! Arrays start at one by default.
  double precision, dimension(100000000) :: vec

  n = 100000000

! Initialize vec with ones
  do k = 1,n
    vec(k) = k * 0.00001d0
  end do

! Time for an addition----------------------------------------------------------
  print*, 'An addition operation was performed ', n * 4,' times.'
 
  call additionTest(vec, n)

  print*, '------------------------------------------------'


! Time for an addition-multiplication pair--------------------------------------

  print*, 'An addition-multiplication operation was performed ', n * 4,' times.'

  call multAddTest(vec, n)

  print*, '------------------------------------------------'

! Time for a division-----------------------------------------------------------

  print*, 'A division operation was performed ', n,' times.'

  call divTest(vec, n)

  print*, '------------------------------------------------'

! Try different elementary functions
  
  print*, 'A sine operation was performed ', n,' times.'

  call sinTest(vec, n)

  print*, '------------------------------------------------'

  print*, 'A exponential operation was performed ', n,' times.'

  call expTest(vec, n)

  print*, '------------------------------------------------'

end program main
