OBJS = inlining.o fsecond.o subInlining.o

# Name of your compiler
FC = gfortran

# Compiler options
FFLAGS = -O3 #-pg -fprofile-arcs -ftest-coverage  #-llapack  Use -O0 for no optimization. -pg to enable gprof.  -fprofile-arcs -ftest-coverage to enable gcov
#LIBS =  /chalmers/users/davsven/lapack-3.5.0/liblapack.a /chalmers/users/davsven/OpenBLAS-0.2.14/libopenblas_sandybridgep-r0.2.14.a  -lpthread # #-llapack -lblas


inlining: $(OBJS)
	$(FC) -o $@ $(FFLAGS) $(OBJS) $(LIBS)

clean:
	rm -f inlining *.o


# Some make-programs do not know about the f90 suffix,
# so we may have to add a rule for how to produce
# an object file (.o) from a Fortran90 file (.f90).
.SUFFIXES: .f90
.f90.o:
	$(FC) -c $(FFLAGS) $<

