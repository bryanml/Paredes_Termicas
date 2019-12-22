program simple
    use ziggurat
    use globals
    implicit none
    logical :: es,es2
    integer:: seed, i,j
    real(kind=8) :: tinicial,tfinal
    integer :: minutos,segundos
![NO TOCAR] Inicializa generador de número random
    inquire(file='seed.dat',exist=es)
    if(es) then
        open(unit=10,file='seed.dat',status='old')
        read(10,*) seed
        close(10)
    else
        seed = 24583490
    end if
    call zigset(seed)

![FIN NO TOCAR]
allocate(r(3,N),v(3,N),f(3,N),ecut(2,2),eps(2,2), tipe(N), mass(2),boundary(3))!,dens_z(nbins,2))

open(unit=10,file='mediciones.txt',status='replace') 
open(unit=20,file='movie1.vtf',status='replace') !! Guarda las posiciones
open(unit=30,file='movie2.vtf',status='replace') !! Guarda las posiciones
open(unit=40,file='T.txt', status='replace')
open(unit=50,file='test.txt',status='replace')

!!Me creo matrices para las dos particulas

!sigma =  reshape((/ 1.0, 1.0, 1.0, 1.0 /), shape(sigma))
eps  =  reshape((/ 1.0, 0.5, 0.5, 1.0 /), shape(eps))
mass = reshape((/1.0, 2.0/), shape(mass))
open(unit=1,file='dt.txt',status='old')
read(unit=1,fmt=*) dt
close(unit=1)

open(unit=2,file='T1.txt',status='old')
read(unit=2,fmt=*) T1
close(unit=2)

open(unit=3,file='T2.txt',status='old')
read(unit=3,fmt=*) T2
close(unit=3)

open(unit=4,file='z_space_wall.txt',status='old')
read(unit=4,fmt=*) z_space_wall
close(unit=4)

L = sqrt(N/(rho*z_space_wall))

inquire(file='posiciones.txt',exist=es2)
if(es2) then
    print *," Reading conf files ... "
	open(unit=60,file='posiciones.txt',status='old')
	open(unit=70,file='velocidades.txt',status='old')
	open(unit=90,file='ultimo_tiempo.txt',status='old')
	read(unit=90,fmt=*) ultimo_tiempo
	do i=1,N
		read(unit=60,fmt=*) r(:,i)
		read(unit=70,fmt=*) v(:,i)
	end do
	close(unit=60)
	close(unit=70)
	close(unit=90)
else
    print *," Initializing configuration  "
    call inicio !! Estado inicial
end if 

!! Radio de corte y energia de corte (matrices 2*2)

!rc2 = reshape((/ 2.5**2*sigma(1,1)**2,2.5**2*sigma(1,2)**2,2.5**2*sigma(2,1)**2,2.5**2*sigma(2,2)**2 /),shape(rc2))
ecut(1,1) = 4*eps(1,1)*((sigma**12/rc2**6 - (sigma**6/rc2**3)))
ecut(1,2) = 4*eps(1,2)*((sigma**12/rc2**6 - (sigma**6/rc2**3)))
ecut(2,1) = 4*eps(2,1)*((sigma**12/rc2**6 - (sigma**6/rc2**3)))
ecut(2,2) = 4*eps(2,2)*((sigma**12/rc2**6 - (sigma**6/rc2**3)))

!Tipo de particula

tipe(:) = 2

do j=1,N1
    tipe(j) = 1
end do

!call thermal_walls(1)
boundary(1) = L
boundary(2) = L
boundary(3) = z_space_wall
call fuerza !! Fuerza del estado inicial
call CPU_TIME(tinicial)
call evol_dinamica
call guardar
call dens(0)
call dens(1)
call dens(2)
call CPU_TIME(tfinal)
minutos = floor((tfinal-tinicial)/60)
segundos = MOD((tfinal-tinicial),60.0)
print *, 'Terminó dt:', dt, 'en t:', minutos,'min', segundos,'seg'

close(unit=10)
close(unit=20)
close(unit=30)
close(unit=40)
close(unit=50)

deallocate(r,v,f,ecut,eps, tipe, mass,boundary)!,dens_z)

!! FIN FIN edicion
!! 
![No TOCAR]
! Escribir la última semilla para continuar con la cadena de numeros aleatorios 

open(unit=100,file='seed.dat',status='unknown')
seed = shr3() 
write(100,*) seed
close(100)
![FIN no Tocar]        


end program simple
