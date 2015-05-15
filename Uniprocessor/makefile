OBJS = lapackTest.o fsecond.o #subLapack.o

# Name of your compiler
FC = gfortran

# Compiler options
FFLAGS = -O3    #-llapack  Use -O0 for no optimization 
LIBS = -llapack -lblas #/chalmers/users/davsven/OpenBLAS-0.2.14/libopenblas_sandybridgep-r0.2.14.a  -lpthread #/chalmers/users/davsven/lapack-3.5.0/liblapack.a


lapackTest: $(OBJS)
	$(FC) -o $@ $(FFLAGS) $(OBJS) $(LIBS)

clean:
	rm -f lapackTest *.o


# Some make-programs do not know about the f90 suffix,
# so we may have to add a rule for how to produce
# an object file (.o) from a Fortran90 file (.f90).
.SUFFIXES: .f90
.f90.o:
	$(FC) -c $(FFLAGS) $<

