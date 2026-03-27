.PHONY: all clean run

OCAMLC = ocamlc

all: main.exe

main.exe: main.ml
	$(OCAMLC) -o main.exe main.ml

run: main.exe
	./main.exe

clean:
	rm -f *.exe *.cmi *.cmo *.cmx *.o