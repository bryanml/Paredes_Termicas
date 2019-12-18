subroutine verlet_pos
    use globals
    implicit none
    integer:: i

    do i = 1,N
        r(:,i) = r(:,i) + v(:,i)*dt + (0.5*f(:,i)*dt*dt)/mass(tipe(i)) !! r(t+dt)
    end do

    call thermal_walls(1)
    
	do i =1,N
		v(:,i) = v(:,i) + (0.5*f(:,i)*dt)/mass(tipe(i))!!v(t+dt/2) usando r(t) y f(t) = f(r(t)) !!
	end do
    call reubicar !! Mete las particulas que pudieron haber salido de la caja

end subroutine verlet_pos