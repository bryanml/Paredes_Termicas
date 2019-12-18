subroutine velocity_prof(mode,n_layers,z_min,z_width) 
    implicit none
    integer ,intent(in) :: mode,n_layers
    real (kind=8) , intent(in) , optional   :: z_width,z_min
    integer :: i,j,ii,jj,kk,z_count_b,z_count_m
    real(kind=8) :: zmin,zmax,v_cell_b(3),v_cell_m(3)
    real(kind=8) , allocatable, save ::  r_scaled(:,:)
    real(kind=8) ,save :: dz,inv_z_step
    real(kind=8)       :: inv_n_time
    integer, save :: n_time
    integer       ::  z_index

select case (mode)

    case(0) ! Initialize

    v_prof(:,:,:) = 0.
    v_prof_2(:,:,:) = 0.

    allocate( r_scaled(3,n_mon_tot) )

!            n_time = 0
    dz = boundary(3) /dble(n_layers)
    inv_z_step = 1/dz

    print '(/a/)',"   *  Velocity prof initialized. "

    n_time = 0

    case(1) ! Final normalization

     
    inv_n_time = 1/dble(n_time)

    v_prof(:,:,:)   = v_prof(:,:,:)   *inv_n_time 
    v_prof_2(:,:,:) = v_prof_2(:,:,:) *inv_n_time    


! velocity profile

    open(unit=74,file='vel_prof.mide',status='unknown')

    write(74,'(13a15)') "#z","vx_brush","vy_brush","vz_brush","vx2_brush","vy2_brush","vz2_brush" &
    ,"vx_melt","vy_melt","vz_melt","vx2_melt","vy2_melt","vz2_melt"
    do i = 1 , n_layers
    write(74,'(13e16.7)') z_min+dz/2.+dble(i-1)*dz,v_prof(i,:,1),v_prof_2(i,:,1),v_prof(i,:,2),v_prof_2(i,:,2)
    end do


    case(2) ! Profile calculation

         n_time = n_time + 1

         r_scaled(3,:) = r0(3,:)*inv_z_step

! Particle type 1 

        do i_part = 1, part_init_d

            z_index = int (r_scaled(3,i_part) ) + 1

            if(z_index<1) z_index =1  
            if(z_index>n_bins) z_index = n_bins  

            v_prof(z_index,:,1) =   v_prof(z_index,:,1) + v(:,i_part) 
            v_prof_2(z_index,:,1) =   v_prof_2(z_index,:,1) + v(:,i_part)*v(:,i_part)
        end do

! Particle type 2

        do i_part = part_init_d+1,n_part

            z_index = int (r_scaled(3,i_part) ) + 1

            if(z_index<1) z_index =1  
            if(z_index>n_bins) z_index = n_bins  

            v_prof(z_index,:,2) =   v_prof(z_index,:,2) + v(:,i_part) 
            v_prof_2(z_index,:,2) =   v_prof_2(z_index,:,2) + v(:,i_part)*v(:,i_part)

        end do

    case default
    print*,"*mode* must have the values 1,2, or 3. Stop here."
    stop

    end select            
end subroutine velocity_prof
