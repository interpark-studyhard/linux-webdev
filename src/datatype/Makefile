
TARGETS = error hello forever fork fork2 fork3 exec1
OBJS = error.o hello.o forever.o fork.o fork2.o fork3.o exec1.o
LIBS = -lc

.SUFFIXES: .c .o
.PHONY: all compile clean

all: compile $(TARGETS)

compile: $(OBJS)

clean:
	rm -f $(TARGETS) $(OBJS) a.out core

fork2.o fork3.o starwars.o: starwars.h
fork3: fork3.o starwars.o
