DASM=dasm

all: matrix64 matrix20 headliner

matrix64: matrix64c000 matrix64bas

headliner: headliner.a65
	$(DASM) headliner.a65 -oheadliner-033c.prg -sheadliner-033c.sym
	$(DASM) headliner.a65 -DORIGIN=49664 -oheadliner-c200.prg -sheadliner-c200.sym

matrix64c000: matrix.a65
	$(DASM) matrix.a65 -omatrix-c000.prg -smatrix-c000.sym

matrix64bas: matrix.a65
	$(DASM) matrix.a65 -DBASIC -omatrix-basic.prg -smatrix-basic.sym

matrix20: matrix.a65
	$(DASM) matrix.a65 -DBASIC -DVIC20 -omatrix-3k.prg -smatrix-3k.sym
	$(DASM) matrix.a65 -DBIG -DVIC20 -omatrix-big.prg -smatrix-big.sym
	$(DASM) matrix.a65 -DVIC20 -omatrix-828.prg -smatrix-828.sym
	c1541 -format matrix,m2 d64 matrix-vic.d64 8 \
		-write matrix-3k.prg matrix \
		-write matrix-big.prg big-matrix \
		-write matrix-828.prg matrix-828

