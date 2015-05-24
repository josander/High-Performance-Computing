OBJS = distances.o fsecond.o 

# Name of your compiler
FC = gfortran

# Compiler options
FFLAGS = -O3 -fbounds-check -fopenmp

distances: $(OBJS)
	$(FC) -o $@ $(FFLAGS) $(OBJS) $(LIBS)

clean:
	rm -f distances *.o

.SUFFIXES: .f90
.f90.o:
	$(FC) -c $(FFLAGS) $<
