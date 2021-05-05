all: solver

dune:
	opam install dune

solver: dune
	dune build
	cp -f _build/default/solver.exe solver

clean:
	rm -rf _build
	rm -f solver
