subroutine thermal_walls(mode)
use globals
use ziggurat
implicit none
integer, intent(in) :: mode
real(kind=8), dimension(3) :: v_new
integer ::  i_part, i, j
real(kind=8), dimension(2) :: inv_mass
real(kind=8) :: fac

inv_mass(1) = 1/mass(1)
inv_mass(2) = 1/mass(2)

  select case(mode)
    case(1) ! *** Thermal walls in top and bottom walls ***

      !!print *, thermal_skin,T1,T2

  do i_part = 1 , N 
 
! Top wall
        if (r(3,i_part)>(z_space_wall-thermal_skin) .and. (v(3,i_part)>0.0)) then 
            fac= sqrt(kb*T1*inv_mass(tipe(i_part))) !! inv_mass es 1/m
            v_new(:) = fac*(/rnor(),rnor(),-sqrt(2.)*sqrt(-log( uni() ) )/)
            v(:,i_part) = v_new(:)
        endif
! Bottom wall
       if (r(3,i_part)<thermal_skin .and. (v(3,i_part)<0.0)) then
           fac = sqrt(kb*T2*inv_mass(tipe(i_part)))
           v_new(:) = fac*(/rnor(),rnor(),sqrt(2.)*sqrt(-log( uni() ) )/)
           v(:,i_part) = v_new(:)
       end if
  end do
  end select 

end subroutine thermal_walls