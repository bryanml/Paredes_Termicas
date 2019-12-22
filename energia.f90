subroutine energia
    use globals     
    implicit none
    integer :: i,j,k
    real(kind=8) :: d2, d2i,d6i, ff, d
    real(kind=8), dimension(3) :: r_ij

E_mec = 0 
E_cin1 = 0
E_cin2 = 0
E_pot = 0   
p = 0

do i=1,N-1
    do j=1+i,N
        r_ij = r(:,i)-r(:,j)
        r_ij(1) = r_ij(1) -L*anint(r_ij(1)/L)
        r_ij(2) = r_ij(2) -L*anint(r_ij(2)/L) !! Encuentra la copia de r_j más cercana
        d2 = r_ij(1)*r_ij(1)+r_ij(2)*r_ij(2)+r_ij(3)*r_ij(3) !! Calcula la distancia con esa copia
        if (d2<rc2) then
            d2i = sigma**2/d2
            d6i = d2i*d2i*d2i
            ff = eps(tipe(i),tipe(j))*24*d2i*d6i*(2*d6i - 1)
            E_pot = E_pot + eps(tipe(i),tipe(j))*4*d6i*(d6i-1) - ecut(tipe(i),tipe(j)) !! Energía potencial
            p = p + ff !! Presion
        end if                                  
    end do
end do 

do j = 1,N
    E_cin1 = E_cin1+0.5*(v(1,j)*v(1,j)+v(2,j)*v(2,j)+v(3,j)*v(3,j))*mass(tipe(j)) !! Energía cinética
end do

!do j = N1+1,N
!    E_cin2 = E_cin2+0.5*(v(1,j)*v(1,j)+v(2,j)*v(2,j)+v(3,j)*v(3,j))/mass(tipe(j)) !! Energía cinética
!end do
E_mec = E_cin1+E_cin2+E_pot !! Energía mecánica
p = p/(L*L*L)+T*rho !! Presión instantanea
end subroutine energia
