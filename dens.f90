subroutine dens(mode)
    use globals
    implicit none
    integer,intent(in) :: mode
    real (kind=8), dimension(nbins,2),save:: dens_z_aux,dens_x_aux,dens_y_aux
    real (kind=8), dimension(3,N), save :: r_scaled
    real (kind=8), dimension(3), save :: inv_boundary(3)
    real (kind=8) :: r_bin_z,r_dummy_z,r_bin_x,r_dummy_x,r_bin_y,r_dummy_y
    real (kind=8), save :: z_step,x_step,y_step,inv_z_step,inv_x_step,inv_y_step,surf_z,surf_x,surf_y
    integer ,save :: count_obs_b,count_obs_m
    integer :: n_max,i_step,i_part,n_step_clau,i_dummy
    integer :: z_index,x_index,y_index

 select case (mode)
 case(0) ! initialization
    r_scaled(:,:) = 0.
    dens_z_aux(:,:) = 0.
    dens_x_aux(:,:) = 0.
    dens_y_aux(:,:) = 0.
    inv_boundary(1) = 1/boundary(1)
    inv_boundary(2) = 1/boundary(2)
    inv_boundary(3) = 1/boundary(3)
    z_step = dble(boundary(3)/nbins)
    x_step = dble(boundary(1)/nbins)
    y_step = dble(boundary(2)/nbins)
    inv_z_step = 1./z_step
    inv_x_step = 1./x_step
    inv_y_step = 1./y_step
    surf_z = boundary(1)*boundary(2)
    surf_x = boundary(3)*boundary(2)
    surf_y = boundary(1)*boundary(3)
    count_obs_b = 0
case(1)   ! Order N algorithm
    count_obs_b = count_obs_b + 1
    r_scaled(3,:) = r(3,:)*inv_z_step
    r_scaled(1,:) = r(1,:)*inv_x_step
    r_scaled(2,:) = r(2,:)*inv_y_step
    do i_part = 1,N
        z_index=int(r_scaled(3,i_part))+1
        x_index=int(r_scaled(1,i_part))+1
        y_index=int(r_scaled(2,i_part))+1
        if (z_index<1) then
            z_index = 1
        else if (z_index>nbins) then
            z_index = nbins
        end if
        dens_z_aux(z_index,tipe(i_part)) = dens_z_aux(z_index,tipe(i_part)) + 1
        dens_x_aux(x_index,tipe(i_part)) = dens_z_aux(x_index,tipe(i_part)) + 1
        dens_y_aux(y_index,tipe(i_part)) = dens_z_aux(y_index,tipe(i_part)) + 1
    end do
    !dens_z(:,:) = dens_z_aux(:,:)+dens_z(:,:)
case(2)  ! Writing files and normalizing
    print '(/a,i6/)','   *  Density profiles over steps= '
    open(unit=73,file='dens_z_prof.txt',status='replace')
    open(unit=173,file='dens_x_prof.txt',status='replace')
    open(unit=273,file='dens_y_prof.txt',status='replace')
    dens_z_aux(:,:) =  dens_z_aux(:,:)*dble(dble(nbins*inv_boundary(3))/(dble(count_obs_b)*surf_z)) !!normalización
    dens_x_aux(:,:) =  dens_x_aux(:,:)*dble(dble(nbins*inv_boundary(1))/(dble(count_obs_b)*surf_x)) !!normalización
    dens_y_aux(:,:) =  dens_y_aux(:,:)*dble(dble(nbins*inv_boundary(2))/(dble(count_obs_b)*surf_y)) !!normalización
    !histo_out(:,:) = dens_z(:,:)  
    r_dummy_z = boundary(3)/dble(nbins)
    r_dummy_x = boundary(1)/dble(nbins)
    r_dummy_y = boundary(2)/dble(nbins)
    r_bin_z = r_dummy_z/2.
    r_bin_x = r_dummy_x/2.
    r_bin_y = r_dummy_y/2.
    do i_dummy = 1,nbins
        write(73,'(4f16.7)') r_bin_z,dens_z_aux(i_dummy,1),dens_z_aux(i_dummy,2)!,dens_z_aux(i_dummy,3)
        write(173,'(4f16.7)') r_bin_x,dens_x_aux(i_dummy,1),dens_x_aux(i_dummy,2)!,dens_z_aux(i_dummy,3)
        write(273,'(4f16.7)') r_bin_y,dens_y_aux(i_dummy,1),dens_y_aux(i_dummy,2)!,dens_z_aux(i_dummy,3)
        r_bin_z = r_bin_z+ r_dummy_z
        r_bin_x = r_bin_x+ r_dummy_x
        r_bin_y = r_bin_y+ r_dummy_y
    end do
    close(unit=73)
    close(unit=173)
    close(unit=273)
end select
end subroutine dens