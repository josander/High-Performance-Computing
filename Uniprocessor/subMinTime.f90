double precision function addition(add, vec, n)

  implicit none 
  integer	   :: k, n
  double precision, dimension(4) :: add
  double precision, dimension(n) :: vec

  do k = 1, n
    add(1) = 1.0d0 + vec(k)
    add(2) = 1.0d0 + vec(k)
    add(3) = 1.0d0 + vec(k)
    add(4) = 1.0d0 + vec(k)
  end do

  print*, add(1)

end function addition
