OBJS = profTest.o fsecond.o 
# Name of your compiler
FC = gfortran

# Compiler options
FFLAGS = -fprofile-arcs -ftest-coverage -O3  # Use -O0 for no optimization 
LIBS =  /chalmers/users/davsven/lapack-3.5.0/liblapack_prof.a /chalmers/users/davsven/BLAS/blas_LINUX.a#-lblas # /chalmers/users/davsven/OpenBLAS-0.2.14/libopenblas_sandybridgep-r0.2.14.a  -lpthread 


profTest: $(OBJS)
	$(FC) -o $@ $(FFLAGS) $(OBJS) $(LIBS)  -fprofile-arcs -ftest --coverage

clean:
	rm -f profTest *.o


# Some make-programs do not know about the f90 suffix,
# so we may have to add a rule for how to produce
# an object file (.o) from a Fortran90 file (.f90).
.SUFFIXES: .f90
.f90.o:
	$(FC) -c $(FFLAGS) $<

