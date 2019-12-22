subroutine dens(mode)
    use globals
    implicit none
    integer,intent(in) :: mode
    real (kind=8), dimension(nbins,2),save:: dens_z_aux
    real (kind=8), dimension(3,N), save :: r_scaled
    real (kind=8), dimension(3), save :: inv_boundary(3)
    real (kind=8) :: r_bin,r_dummy
    real (kind=8), save :: z_step,inv_z_step,surf
    integer ,save :: count_obs_b,count_obs_m
    integer :: n_max,i_step,i_part,n_step_clau,i_dummy
    integer :: z_index

 select case (mode)
 case(0) ! initialization
    r_scaled(:,:) = 0.
    dens_z_aux(:,:) = 0.
    inv_boundary(1) = 1/boundary(1)
    inv_boundary(2) = 1/boundary(2)
    inv_boundary(3) = 1/boundary(3)
    z_step = dble(boundary(3)/nbins)
    inv_z_step = 1./z_step
    surf = boundary(1)*boundary(2)
    count_obs_b = 0
case(1)   ! Order N algorithm
    count_obs_b = count_obs_b + 1
    r_scaled(3,:) = r(3,:)*inv_z_step
    do i_part = 1,N
        z_index=int(r_scaled(3,i_part))+1
        if (z_index<1) then
            z_index = 1
        else if (z_index>nbins) then
            z_index = nbins
        end if
        dens_z_aux(z_index,tipe(i_part)) = dens_z_aux(z_index,tipe(i_part)) + 1
    end do
    !dens_z(:,:) = dens_z_aux(:,:)+dens_z(:,:)
case(2)  ! Writing files and normalizing
    print '(/a,i6/)','   *  Density profiles over steps= ',count_obs_b 
    open(unit=73,file='dens_prof.txt',status='replace')
    dens_z_aux(:,:) =  dens_z_aux(:,:)*dble(dble(nbins*inv_boundary(3))/(dble(count_obs_b)*surf)) !!normalización
    !histo_out(:,:) = dens_z(:,:)  
    r_dummy = boundary(3)/dble(nbins)
    r_bin = r_dummy/2.
    do i_dummy = 1,nbins
        write(73,'(4f16.7)') r_bin,dens_z_aux(i_dummy,1),dens_z_aux(i_dummy,2)!,dens_z_aux(i_dummy,3)
        r_bin = r_bin + r_dummy
    end do
end select
end subroutine dens