subroutine lgv_fuerza
use globals
use ziggurat
implicit none
integer :: i, j


do i =1,N
	do j=1,3
		fl(j,i) = rnor()*lambda-gamma*v(j,i)
	end do
end do

f(:,:) = f(:,:)+fl(:,:) !! Sumo la fuerza

end subroutine lgv_fuerza