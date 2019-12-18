subroutine guardar
use globals
implicit none
integer::i, j

open(unit=60,file='posiciones.txt',status='replace')
open(unit=70,file='velocidades.txt',status='replace')
open(unit=90,file='ultimo_tiempo.txt',status='replace')
write(unit=90,fmt=*) ultimo_tiempo
do i=1,N
	write(unit=60,fmt=*) r(:,i)
	write(unit=70,fmt=*) v(:,i)
end do
close(unit=60)
close(unit=70)
close(unit=90)

end subroutine guardar
