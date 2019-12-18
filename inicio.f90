subroutine inicio
    use globals
    use ziggurat
    implicit none
    integer :: i,j,x,y,z,n_lado
    real(8) :: dL


!!ESTADO INICIAL AL AZAR
    do j=1,N
        r(1,j) = L*uni()
        v(1,j) = 0.5-uni()
        r(2,j) = L*uni()
        v(2,j) = 0.5-uni()
        r(3,j) = thermal_skin+(z_space_wall-2*thermal_skin)*uni()
        v(3,j) = 0.5-uni()
    end do
    ultimo_tiempo = 0
!!ESTADO INICIAL SOBRE UNA LATTICE
    ! n_lado = 1
    ! do while (n_lado*n_lado*n_lado.lt.N)
    !     n_lado = n_lado + 1
    ! end do
    ! dL = L/n_lado
    ! do j=1,3
    !     do i=1,N
    !         v(j,i) = rnor()*sigma
    !     end do
    ! end do
    ! i = 1
    ! do x=1,n_lado
    !     do y=1,n_lado
    !         do z=1,n_lado
    !             if (i.lt.(N+1)) then
    !                 r(1,i) = dL*(x - 0.5)
    !                 r(2,i) = dL*(y - 0.5)
    !                 r(3,i) = dL*(z - 0.5)
    !             end if
    !             i = i + 1
    !         end do
    !     end do
    ! end do
!!

end subroutine inicio
