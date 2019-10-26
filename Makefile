DASM=dasm
C1541=c1541

all: matrix-64 matrix-vic20 

matrix-64: matrix-basic.prg matrix-c000.prg headliner-033c.prg headliner-c200.prg
	$(C1541) -format matrix-64,m2 d64 matrix-64.d64 8 \
		-write matrix-basic.prg matrix \
		-write matrix-c000.prg matrix-c000 \
		-write headliner-033c.prg headliner-033c \
		-write headliner-c200.prg headliner-c200

headliner: headliner-033c.prg headliner-c200.prg

headliner-033c.prg: headliner.a65
	$(DASM) headliner.a65 -oheadliner-033c.prg -sheadliner-033c.sym

headliner-c200.prg: headliner.a65
	$(DASM) headliner.a65 -DORIGIN=49664 -oheadliner-c200.prg -sheadliner-c200.sym

matrix-c000.prg: matrix.a65
	$(DASM) matrix.a65 -omatrix-c000.prg -smatrix-c000.sym

matrix-basic.prg: matrix.a65
	$(DASM) matrix.a65 -DBASIC -omatrix-basic.prg -smatrix-basic.sym

matrix-3k.prg: matrix.a65
	$(DASM) matrix.a65 -DBASIC -DVIC20 -omatrix-3k.prg -smatrix-3k.sym

matrix-big.prg: matrix.a65
	$(DASM) matrix.a65 -DBIG -DVIC20 -omatrix-big.prg -smatrix-big.sym

matrix-828.prg: matrix.a65
	$(DASM) matrix.a65 -DVIC20 -omatrix-828.prg -smatrix-828.sym

matrix-vic20: matrix-3k.prg matrix-big.prg matrix-828.prg
	$(C1541) -format matrix,m2 d64 matrix-vic.d64 8 \
		-write matrix-3k.prg matrix \
		-write matrix-big.prg big-matrix \
		-write matrix-828.prg matrix-828

