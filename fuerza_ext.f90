subroutine fuerza_ext
    use globals
    implicit none
    integer:: i,j,k,h
    real(8) :: d2, d2i,d6i,ff
    real(kind =8), dimension(3) :: r_ij

f(:,:) = 0

do i=1,N-1
    do j=1+i,N
        r_ij = r(:,i)-r(:,j)
        r_ij = r_ij -L*anint(r_ij/L) !! Encuentra la copia de r_j más cercana
        d2 = r_ij(1)*r_ij(1)+r_ij(2)*r_ij(2)+r_ij(3)*r_ij(3) !! Calcula la distancia con esa copia
        if (d2.lt.rc2) then
            d2i = 1/d2 
            d6i = d2i*d2i*d2i
            ff = eps(tipe(i),tipe(j))*24*d2i*d6i*(2*d6i - 1)!!FZA LENNARD JONES  
            f(:,i) = f(:,i) + ff*r_ij 
            f(:,j) = f(:,j) - ff*r_ij 
        end if                                  
    end do
end do

end subroutine fuerza_ext