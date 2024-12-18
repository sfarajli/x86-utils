.POSIX: 

.SUFFIXES:
.SUFFIXES: .o .s

BIN = ls touch mkdir unlink rmdir

all: ${BIN}

include Sourcedeps

${BIN}:
	ld -o $@ $<

.s.o:
	nasm -felf64 -o $@ $<

clean:
	rm -f ${BIN} src/*.o

.PHONY: all clean
