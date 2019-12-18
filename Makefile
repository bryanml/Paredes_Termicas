MAKEFILE = Makefile
exe = simple
fcomp = gfortran #ifort # /opt/intel/compiler70/ia32/bin/ifc  
# Warning: the debugger doesn't get along with the optimization options
# So: not use -O3 WITH -g option
flags =  -O3 

# Remote compilation
OBJS = ziggurat.o simple.o fuerza.o energia.o min_energia.o inicio.o verlet_pos.o globals.o reubicar.o verlet_vel.o lgv_fuerza.o evol_dinamica.o thermal_walls.o test.o guardar.o 

.SUFFIXES:            # this deletes the default suffixes 
.SUFFIXES: .f90 .o    # this defines the extensions I want 

.f90.o:  
	$(fcomp) -c $(flags) $< 


$(exe):  $(OBJS) Makefile
	$(fcomp) $(flags) -o $(exe) $(OBJS) 


clean:
	rm ./*.o ./*.mod	


simple.o: ziggurat.o simple.f90 energia.o fuerza.o inicio.o verlet_pos.o globals.o min_energia.o reubicar.o verlet_vel.o lgv_fuerza.o evol_dinamica.o thermal_walls.o test.o guardar.o
globals.o: globals.f90
reubicar.o: reubicar.f90 globals.o
inicio.o: inicio.f90 globals.o
fuerza.o: fuerza.f90 globals.o
energia.o: energia.f90 globals.o
min_energia.o: min_energia.f90 globals.o
verlet_pos.o: verlet_pos.f90 globals.o
verlet_vel.o: verlet_vel.f90 globals.o	
lgv_fuerza.o: lgv_fuerza.f90 globals.o 
evol_dinamica.o: evol_dinamica.f90 globals.o
thermal_walls.o: thermal_walls.f90 globals.o 
test.o: test.f90 globals.o
guardar.o: guardar.f90 globals.o