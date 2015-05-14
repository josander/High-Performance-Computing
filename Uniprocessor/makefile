OBJS = indirectAdressing.o fsecond.o subIndirectAdressing.o

# Name of your compiler
FC = gfortran

# Compiler options
FFLAGS = -O3 -lblas # Use -O0 for no optimization

indirectAdressing: $(OBJS)
	$(FC) -o $@ $(FFLAGS) $(OBJS)

clean:
	rm -f indirectAdressing *.o

# Some make-programs do not know about the f90 suffix,
# so we may have to add a rule for how to produce
# an object file (.o) from a Fortran90 file (.f90).
.SUFFIXES: .f90
.f90.o:
	$(FC) -c $(FFLAGS) $<

