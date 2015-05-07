program main
! This program takes the time for some basic operations

! Start of our program
  implicit none 
  integer	   :: k, n
  double precision :: fsecond, t, t1, t2, t3, t4, t5
  double precision :: addMult, div, addition, sinFunk, expFunk
  real :: cput1, cput2, cpuTime

! Arrays start at one by default.
  double precision, dimension(4) :: add
  double precision, dimension(1000000) :: vec

  n = 1000000
  addMult = 0.0d0
  div = 1.0d0

! Initialize vec with ones
  do k = 1,n
    vec(k) = 1.0d0
  end do
 
! Time for an addition

  t = fsecond()
  call cpu_time(cput1)

  add = addition(add, vec, n)
	
  t1 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1

  print*, 'An addition operation was performed ', n * 4,' times.'
  print*, 'The result is ', addition(add, vec, n)
  print*, 'Time per addition: ', t1 / (n * 4)
  print*, 'CPU time: ', cpuTime / (n * 4)
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

! Try different elementary functions

  t = fsecond()
  call cpu_time(cput1)

  do k = 1, n
    sinFunk = sin(dble(k))
  end do
	
  t4 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1

  print*, 'A sine operation was performed ', n,' times.'
  print*, 'The result is ', sinFunk
  print*, 'Time: ', t4
  print*, 'CPU time: ', cpuTime
  print*, '------------------------------------------------'

  t = fsecond()
  call cpu_time(cput1)

  do k = 1, n
    expFunk = exp(dble(k))
  end do
	
  t5 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1

  print*, 'A exponential operation was performed ', n,' times.'
  print*, 'The result is ', expFunk
  print*, 'Time: ', t5
  print*, 'CPU time: ', cpuTime
  print*, '------------------------------------------------'

end program main
