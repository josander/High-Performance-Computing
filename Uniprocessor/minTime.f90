program main
! This program takes the time for some basic operations

! Start of our program
  implicit none 
  integer	   :: k, n
  double precision :: fsecond, t, t1, t2, t3
  double precision :: add, addMult, div, addition
  real :: cput1, cput2, cpuTime

  n = 100000000
  add = 0.0
  addMult = 0.0
  div = 1.0

! Ask how many loop that should be performed
!  print*, "Type a value for how many loop that should be executed:"
!  read*,  n

 
! Time for an addition

  t = fsecond()
  call cpu_time(cput1)

  do k = 1, n
    add = add + 1.0
  end do
	
  t1 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1

  print*, 'An addition operation was performed ', n,' times.'
  print*, 'The result is ', add
  print*, 'Time: ', t1
  print*, 'CPU time: ', cpuTime
  print*, '------------------------------------------------'


! Time for an addition-multiplication pair

  t = fsecond()
  call cpu_time(cput1)

  do k = 1, n
    addMult = addMult + 1.0 * 2.0
  end do
	
  t2 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1

  print*, 'An addition-multiplication operation was performed ', n,' times.'
  print*, 'The result is ', addMult
  print*, 'Time: ', t2
  print*, 'CPU time: ', cpuTime
  print*, '------------------------------------------------'

! Time for a division

  t = fsecond()
  call cpu_time(cput1)

  do k = 1, n
    div = div/1.01
  end do
	
  t3 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1

  print*, 'A division operation was performed ', n,' times.'
  print*, 'The result is ', div
  print*, 'Time: ', t3
  print*, 'CPU time: ', cpuTime
  print*, '------------------------------------------------'


end program main
