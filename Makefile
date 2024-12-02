.POSIX: 

.SUFFIXES:
.SUFFIXES: .o .s

BIN = ls touch mkdir unlink rmdir

all: ${BIN}

include Sourcedeps

${BIN}:
	${CC} -o $@ $< -nostdlib -static

.s.o:
	${AS} -o $@ $<

clean:
	rm -f ${BIN} src/*.o

.PHONY: all clean
