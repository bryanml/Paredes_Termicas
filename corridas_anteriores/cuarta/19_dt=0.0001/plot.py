import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt('test.txt');
data3 = np.loadtxt('mediciones.txt');
dataz = np.loadtxt('dens_z_prof.txt');
datax = np.loadtxt('dens_x_prof.txt');
datay = np.loadtxt('dens_y_prof.txt');
E_cin = data3[:,0];
E_pot = data3[:,1];
E_mec = data3[:,2];
t = data3[:,3];

z = dataz[:,0];
x = datax[:,0];
y = datay[:,0];
densz1 = dataz[:,1];
densz2 = dataz[:,2];
densx1 = datax[:,1];
densx2 = datax[:,2];
densy1 = datay[:,1];
densy2 = datay[:,2];

plt.figure(1)
plt.title('Temperatura')
plt.plot(t,2*E_cin/3,'-ok')
plt.figure(2)
plt.title('densidad en z')
#plt.title('Temperatura', fontsize=16)
plt.plot(z, densz1, 'ok',z, densz2+1, 'or')
plt.figure(3)
plt.title('densidad en x')
plt.plot(x, densx1, 'ok',x, densx2+1, 'or')
plt.figure(4)
plt.title('densidad en y')
plt.plot(y, densy1, 'ok',y, densy2+1, 'or')
plt.show()

# data = np.loadtxt('mediciones.txt');
# rho = data[:,0];
# n = len(rho);
# T = data[:,1];
# p = data[:,2];
# sigma_p = data[:,3];

# plt.figure(1)
# plt.title(r'N=343, T=1.1',fontsize=16)
# plt.plot(rho,p,'-ok')
# plt.xlabel(r'$\rho$',fontsize=16)
# plt.xticks(fontsize=16)
# plt.ylabel('P',fontsize=16)
# plt.yticks(fontsize=16)
# plt.figure(2)
# plt.title(r'N=343, T=1.1',fontsize=16)
# plt.xlabel(r'$\rho$',fontsize=16)
# plt.xticks(fontsize=16)
# plt.ylabel(r'$\sigma_P = \sqrt{\langle P^2\rangle - \langle P \rangle^2}$',fontsize=16)
# plt.yticks(fontsize=16)
# plt.plot(rho,sigma_p,'ok')
# plt.show()
