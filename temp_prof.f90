subroutine temp_prof(mode,tiempo) 
    use globals
    implicit none
    integer ,intent(in) :: mode
    real(kind=8) , allocatable, save :: E_cin_z_aux(:), r_scaled(:,:),r_bin_z(:)
    integer, allocatable,save :: contador_z(:)
    integer, save :: n_evolucion
    integer ::  z_index,i,i_part
    real(kind=8) :: tiempo,r_dummy_z
    real(kind=8), save :: inv_dz,dz

select case (mode)
case(0) !! Guarda los z
    allocate(r_bin_z(n_layers))
    r_dummy_z = dble(boundary(3)/nbins)
    do i=1,n_layers
        r_bin_z(i) = i*r_dummy_z
    end do
    open(unit=64,file='temp_z_prof.txt',status='replace')
    write(unit=64,fmt=*) 'tiempos', r_bin_z(:)
    open(unit=300, file='temp_z_promedio.txt',status='replace')
    write(unit=300,fmt=*) r_bin_z(:)
    dz = dble(boundary(3)/n_layers)
    inv_dz = dble(1/dz)
    n_evolucion =0
    allocate(E_cin_z_aux(n_layers),contador_z(n_layers),r_scaled(3,N))
    !print *,'dz= ', dz, 'inv_dz=', inv_dz
case(1) ! Initialize
    E_cin_z_aux(:) = 0.
    contador_z(:)=0
    temp_z(:)=0.
    !print '(/a/)'!,"   *  Temperature prof initialized. "
case(2) ! Profile calculation
    r_scaled(3,:) = r(3,:)*inv_dz
    do i_part=1,N !! Suma la energía cinética de las particulas por bin
        z_index = int(r_scaled(3,i_part)) + 1
        if(z_index<1) then
            z_index =1  
        else if(z_index>n_layers) then
            z_index = n_layers
        end if
        E_cin_z_aux(z_index) = E_cin_z_aux(z_index)+0.5*mass(tipe(i_part))*(v(1,i_part)*v(1,i_part))
        E_cin_z_aux(z_index) = E_cin_z_aux(z_index)+0.5*mass(tipe(i_part))*(v(2,i_part)*v(2,i_part))
        E_cin_z_aux(z_index) = E_cin_z_aux(z_index)+0.5*mass(tipe(i_part))*(v(3,i_part)*v(3,i_part))
        contador_z(z_index) = contador_z(z_index)+1
    end do
    do i=1,n_layers !! Toma el promedio de la energía cinética por bin
        if(contador_z(i)>0) then
            temp_z(i) = temp_z(i) + 2*E_cin_z_aux(i)/(3*contador_z(i))
        end if
    end do
case(3) ! Guarda el tiempo y la Temperatura por bin
    write(64,'(13e16.7)') tiempo, temp_z(:)
case(4) !! Esto es para calcular el promedio temporal
    temp_z_promedio(:) = temp_z_promedio(:)+temp_z(:)
    n_evolucion = n_evolucion +1
case(5)
    write(300,*) temp_z_promedio(:)/n_evolucion
    close(unit=64)
    close(unit=300)
!case default
!print*,"*mode* must have the values 1,2, or 3. Stop here."
end select            
end subroutine temp_prof