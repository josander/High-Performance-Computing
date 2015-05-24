OBJS = jac.o subJac.o

# Name of your compiler
FC = /chalmers/sw/unsup64/mpich-3.1.3/bin/mpif90

# Compiler options
FFLAGS = -O3 -fbounds-check

jac: $(OBJS)
	$(FC) -o $@ $(FFLAGS) $(OBJS) $(LIBS)

clean:
	rm -f jac *.o

.SUFFIXES: .f90
.f90.o:
	$(FC) -c $(FFLAGS) $<
