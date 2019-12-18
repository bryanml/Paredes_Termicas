subroutine verlet_vel
use globals
implicit none
integer :: i,j


do i =1,N
    v(:,i) = v(:,i) + (0.5*f(:,i)*dt)/mass(tipe(i))!! Calcula v(t+dt)
end do

end subroutine verlet_vel