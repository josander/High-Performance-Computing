double precision function addition(add, vec, n)

  implicit none 
  integer	   :: k, n
  double precision :: fsecond, t, t1, cpuTime
  double precision, dimension(4) :: add
  double precision, dimension(n) :: vec
  real :: cput1, cput2 

  t = fsecond()
  call cpu_time(cput1)
  do k = 1, n
    add(1) = 1.0d0 + vec(k)
    add(2) = 1.0d0 + vec(k)
    add(3) = 1.0d0 + vec(k)
    add(4) = 1.0d0 + vec(k)
  end do
  call cpu_time(cput2)
  t1 = fsecond() - t
  cpuTime = cput2 - cput1
  print*, 'Time per addition: ', t1 / (n * 4.0)
  print*, add(1)
  print*, add(4)
  print*, 'CPU time: ', cpuTime / (n * 4.0)

end function addition
