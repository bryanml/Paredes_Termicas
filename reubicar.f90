subroutine reubicar
use globals
implicit none
integer :: j
real(8):: h

do j=1,N
	h =floor(r(1,j)/L)
	r(1,j) = r(1,j)-h*L
	h =floor(r(2,j)/L)
	r(2,j) = r(2,j)-h*L
!	if (r(3,j)>z_space_wall) then
!		r(3,j) = 2*z_space_wall-r(3,j)
!		v(3,j) = -abs(v(3,j))
!	end if 
!	if (r(3,j)<0) then
!		r(3,j) = -r(3,j)
!		v(3,j) = abs(v(3,j))
!	end if
end do


end subroutine reubicar
