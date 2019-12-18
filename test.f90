subroutine test
use globals
implicit none
integer:: i

N1conteo = N1
do i=1,N1
	if(r(3,i)<0 .OR. r(3,i)>z_space_wall) then
		N1conteo=N1conteo-1
	end if
end do

N2conteo = N2
do i=N1+1,N
	if(r(3,i)<0 .OR. r(3,i)>z_space_wall) then
		N2conteo=N2conteo-1
	end if
end do

end subroutine test