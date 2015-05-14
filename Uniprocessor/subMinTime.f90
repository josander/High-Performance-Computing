subroutine additionTest(vec, n)

  implicit none 
  integer	   :: k, n
  double precision :: fsecond, t, t1, cpuTime, time
  double precision, dimension(4) :: add
  double precision, dimension(n) :: vec
  real :: cput1, cput2 

  t = fsecond()
  call cpu_time(cput1)

! Due to pipelining, do four additions at the same time
  do k = 1, n
    add(1) = 1.0d0 + vec(k)
    add(2) = 2.0d0 + vec(k)
    add(3) = 3.0d0 + vec(k)
    add(4) = 4.0d0 + vec(k)
  end do

  t1 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1
  time = t1 / (n * 4.0d0)

  print*, 'Time per addition: ', time
  print*, 'CPU time: ', cpuTime / (n * 4.0d0)
  print*, 'Gflops: ', 1 / (time * 10**9)
  print*, 'The variable equals', sum(add)

end subroutine additionTest


subroutine multAddTest(vec, n)

  implicit none 
  integer	   :: k, n
  double precision :: fsecond, t, t1, cpuTime, time
  double precision, dimension(5) :: multAdd
  double precision, dimension(n) :: vec
  real :: cput1, cput2 

  t = fsecond()
  call cpu_time(cput1)

  do k = 1, n
    multAdd(1) = 1.0d0 + vec(k) * 0.1d0
    multAdd(2) = 2.0d0 + vec(k) * 0.2d0
    multAdd(3) = 3.0d0 + vec(k) * 0.3d0
    multAdd(4) = 4.0d0 + vec(k) * 0.4d0
    multAdd(5) = 5.0d0 + vec(k) * 0.5d0
  end do

  t1 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1
  time = t1 / (n * 5.0d0)

  print*, 'Time per mult-add: ', time
  print*, 'CPU time: ', cpuTime / (n * 5.0d0)
  print*, 'Gflops: ', 1 / (time * 10**9)
  print*, 'The variable equals', sum(multAdd)

end subroutine multAddTest


subroutine divTest(vec, n)

  implicit none 
  integer	   :: k, n
  double precision :: fsecond, t, t1, cpuTime, div, time
  double precision, dimension(n) :: vec
  real :: cput1, cput2 

  t = fsecond()
  call cpu_time(cput1)

  do k = 1, n
    div = 1.0d0 / vec(k)
  end do

  t1 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1
  time = t1 / (n * 1.0d0)

  print*, 'Time per division: ', time
  print*, 'CPU time: ', cpuTime / (n * 1.0d0)
  print*, 'Gflops: ', 1 / (time * 10**9)
  print*, 'The variable equals', div

end subroutine divTest

subroutine sinTest(vec, n)

  implicit none 
  integer	   :: k, n
  double precision :: fsecond, t, t1, cpuTime, sinT, time
  double precision, dimension(n) :: vec
  real :: cput1, cput2 

  t = fsecond()
  call cpu_time(cput1)

  do k = 1, n
    sinT = sin(vec(k))
  end do

  t1 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1
  time = t1 / (n * 1.0d0)

  print*, 'Time per sinus: ', time
  print*, 'CPU time: ', cpuTime / (n * 1.0d0)
  print*, 'Gflops: ', 1 / (time * 10**9)
  print*, 'The variable equals', sinT

end subroutine sinTest

subroutine expTest(vec, n)

  implicit none 
  integer	   :: k, n
  double precision :: fsecond, t, t1, cpuTime, expT, time
  double precision, dimension(n) :: vec
  real :: cput1, cput2 

  t = fsecond()
  call cpu_time(cput1)

  do k = 1, n
    expT = exp(-vec(k))
  end do

  t1 = fsecond() - t
  call cpu_time(cput2)
  cpuTime = cput2 - cput1
  time = t1 / (n * 1.0d0)

  print*, 'Time per exp: ', time
  print*, 'CPU time: ', cpuTime / (n * 1.0d0)
  print*, 'Gflops: ', 1 / (time * 10**9)
  print*, 'The variable equals', expT

end subroutine expTest


