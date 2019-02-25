DASM=dasm

all: matrix64 matrix20

matrix64: matrix64c000 matrix64bas

matrix64c000: matrix.a65
	$(DASM) matrix.a65 -omatrix-c000.prg -smatrix-c000.sym

matrix64bas: matrix.a65
	$(DASM) matrix.a65 -DBASIC -omatrix-basic.prg -smatrix-basic.sym

matrix20: matrix.a65
	$(DASM) matrix.a65 -DBASIC -DVIC20 -omatrix-3k.prg -smatrix-3k.sym
	c1541 -format matrix,m2 d64 matrix-vic.d64 8 -write matrix-3k.prg matrix-3k

