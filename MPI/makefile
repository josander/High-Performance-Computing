OBJS = jac.o subjac.o

# Path to MPICH-system
PATH=$PATH:/chalmers/sw/unsup64/mpich-3.1.3/bin/

# Name of your compiler
FC = mpif90

# Compiler options
FFLAGS = -O3

jac: $(OBJS)
	$(FC) -o $@ $(FFLAGS) $(OBJS) $(LIBS)

clean:
	rm -f jac *.o

.SUFFIXES: .f90
.f90.o:
	$(FC) -c $(FFLAGS) $<
