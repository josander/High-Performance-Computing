OBJS = jac.o #subjac.o

# Name of your compiler
FC = /chalmers/sw/unsup64/mpich-3.1.3/bin/mpif90

# Compiler options
FFLAGS = -O3

jac: $(OBJS)
	$(FC) -o $@ $(FFLAGS) $(OBJS) $(LIBS)

clean:
	rm -f jac *.o

.SUFFIXES: .f90
.f90.o:
	$(FC) -c $(FFLAGS) $<
