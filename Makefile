DASM=dasm

all: matrix64 matrix20

matrix64: matrix.a65
	$(DASM) matrix.a65 -omatrix-c000.prg -smatrix-c000.sym

matrix20: matrix.a65
	$(DASM) matrix.a65 -DVIC20 -omatrix-3k.prg -smatrix-3k.sym

