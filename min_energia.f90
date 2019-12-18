subroutine min_energia
use globals
implicit none
integer :: i,j


do i = 1,N
    r(:,i) = r(:,i) + 0.5*f(:,i)*dt*dt/mass(tipe(i))
    call reubicar
end do

end subroutine min_energia