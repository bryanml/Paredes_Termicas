subroutine evol_dinamica
use globals
implicit none
integer :: i,j,k

write(unit=20, fmt=*) "atom 0:199      radius 0.5 name S"
write(unit=20, fmt=*)
write(unit=20, fmt=*) "pbc", L, L, z_space_wall

write(unit=30, fmt=*) "atom 0:199      radius 0.5 name F"
write(unit=30, fmt=*)
write(unit=30, fmt=*) "pbc", L, L, z_space_wall

write(unit=20, fmt=*) "timestep"
write(unit=20, fmt=*) 
do j=1,N1
	write(unit=20, fmt=*) r(:,j)
end do
write(unit=30, fmt=*) "timestep"
write(unit=30, fmt=*) 
do k=N1+1,N
	write(unit=30, fmt=*) r(:,k)
end do

temp = 0
pres = 0
p2 = 0
N_evo = 50000

do i=1,N_evo !!Empiezo a medir
	call verlet_pos
	call fuerza
	call verlet_vel
	if (MOD(i-1, 100) == 0) then !!VMD movie cada 100 pasos
		write(unit=20, fmt=*) "timestep"
		write(unit=20, fmt=*) 
		do j=1,N1
			write(unit=20, fmt=*) r(:,j)
		end do
		write(unit=30, fmt=*) "timestep"
		write(unit=30, fmt=*) 
		do k=N1+1,N
			write(unit=30, fmt=*) r(:,k)
		end do
	end if
	call energia
	!call dens(0)
	!call dens(1)
	ultimo_tiempo = ultimo_tiempo + dt
	write(unit=10,fmt=*) E_cin1/N+E_cin2/N2, E_pot/N, E_mec/N,ultimo_tiempo
	call test
	write(unit=50, fmt=*) N1conteo, N2conteo
	temp = temp + E_cin1/N+E_cin2/N2 !!Temperatura como valor medio de la energía cinética
	pres = pres + p !! Presión como valor medio de la presión instantanea
	p2 = P2 + p*p !! P^2
end do 

!dens_z(:,:) = dens_z(:,:)/N_evo

p2 = p2/N_evo-pres*pres/(N_evo*N_evo) !! Sigma_P ^2
temp = 2*temp/(3*N_evo) !! Temperatura
pres = pres/N_evo !! Presión

!print *, 'T = ', temp, 'p =', pres !! Muestra en pantalla T y P
end subroutine evol_dinamica
