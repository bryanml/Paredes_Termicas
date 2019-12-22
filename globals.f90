module globals
implicit none

integer, parameter :: N1 = 200, N2 = 200, N = N1+N2, nbins=500
real(kind=8), allocatable :: r(:,:), v(:,:), f(:,:), fl(:,:), eps(:,:), mass(:), ecut(:,:),boundary(:)!,dens_z(:,:)
real(kind=8), parameter :: rho = 0.2, thermal_skin = 1.2, rc2 = 2.5*2.5
integer , allocatable :: tipe(:)
real(kind=8), parameter ::  gamma = 0.5, sigma = 1.0, kb = 1
integer :: N_evo, nconf, N1conteo, N2conteo
real(kind=8) :: E_mec, E_pot, E_cin1, E_cin2, p, p2, temp, pres
real(kind=8) :: lambda, L, T,T1, T2,dt,z_space_wall,ultimo_tiempo


!! Disminuir dt, aumentar sigma o tirar las particulas mas para adentro
!! termalizo con un paso de tiempo corto (ver el que se uso para termalizar )
!! siempre el equilibrio es referencia

end module globals