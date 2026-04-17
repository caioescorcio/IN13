CAMLC=$(BINDIR)ocamlc
CAMLDEP=$(BINDIR)ocamldep
CAMLLEX=$(BINDIR)ocamllex
CAMLYACC=$(BINDIR)ocamlyacc
# COMPFLAGS=-w A-4-6-9 -warn-error A -g
COMPFLAGS=

EXEC = pcfloop
SOURCES = pcfast.ml types.ml subst.ml unify.ml infer.ml pcfloop.ml
GENERATED = pcflex.ml pcfparse.ml pcfparse.mli
MLIS = types.mli subst.mli unify.mli
OBJS = $(GENERATED:.ml=.cmo) $(SOURCES:.ml=.cmo)

# Building the world
all: $(EXEC)

$(EXEC): $(OBJS)
	$(CAMLC) $(COMPFLAGS) $(OBJS) -o $(EXEC)

.SUFFIXES:
.SUFFIXES: .ml .mli .cmo .cmi .cmx
.SUFFIXES: .mll .mly

.ml.cmo:
	$(CAMLC) $(COMPFLAGS) -c $<

.mli.cmi:
	$(CAMLC) $(COMPFLAGS) -c $<

.mll.ml:
	$(CAMLLEX) $<

.mly.ml:
	$(CAMLYACC) $<

# Clean up
clean:
	rm -f *.cm[io] *.cmx *~ .*~ *.o
	rm -f parser.mli
	rm -f $(GENERATED)
	rm -f $(EXEC)
	rm -f tarball-enonce.tgz tarball-solution.tgz

# Dependencies
depend: $(SOURCES) $(GENERATED) $(MLIS)
	$(CAMLDEP) $(SOURCES) $(GENERATED) $(MLIS) > .depend

include .depend

tarball-enonce:
	rm -f tarball-enonce.tgz
	tar cvzhf tarball-enonce.tgz \
		std.pdf Makefile pcfast.ml pcfparse.mly test.pcf unify.ml pcflex.mll subst.ml \
	  types.ml unify.mli pcfloop.ml subst.mli types.mli infer-eleves.ml

tarball-solution:
	rm -f tarball-solution.tgz
	tar cvzhf tarball-solution.tgz \
		ctd.pdf Makefile pcfast.ml pcfparse.mly test.pcf unify.ml pcflex.mll subst.ml \
	  types.ml unify.mli pcfloop.ml subst.mli types.mli infer.ml
