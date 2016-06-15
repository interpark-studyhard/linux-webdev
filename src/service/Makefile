
TARGETS = innasrv1 innasrv2 innasrv3 innasrv4
OBJS = innasrv1.o innasrv2.o innasrv3.o innasrv4.o
LIBS = -lc

.SUFFIXES: .c .o
.PHONY: all compile clean install

all: compile $(TARGETS)

compile: $(OBJS)

clean:
	rm -f $(TARGETS) $(OBJS) a.out core *.log

install: innasrv4
	cp innasrv4 /sbin/innasrv
	cp innasrv.cfg /etc/innasrv.cfg
	cp innasrv.init /etc/init.d/innasrv

uninstall:
	rm -f /sbin/innasrv /etc/innasrv.cfg /etc/init.d/innasrv

