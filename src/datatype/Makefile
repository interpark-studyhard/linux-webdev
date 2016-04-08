
TARGETS = error hello forever fork fork2 fork3
OBJS = error.o hello.o forever.o fork.o fork2.o fork3.o
LIBS = -lc

DEP_FOREVER_H = forever.o fork3.o

.SUFFIXES: .c .o
.PHONY: all compile clean

all: compile $(TARGETS)

compile: $(OBJS)

clean:
	rm -f $(TARGETS) $(OBJS)

$(DEP_FOREVER_H): forever.h

