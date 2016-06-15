
TARGETS = innasrv1 innasrv2 innasrv3 innasrv4 innasrv5
OBJS = innasrv1.o innasrv2.o innasrv3.o innasrv4.o innasrv5.o
LIBS = -lc

.SUFFIXES: .c .o
.PHONY: all compile clean install

all: compile $(TARGETS)

compile: $(OBJS)

clean:
	rm -f $(TARGETS) $(OBJS) a.out core *.log

init-install: innasrv4
	cp innasrv4 /usr/local/sbin/innasrv
	cp innasrv.cfg /etc/innasrv.cfg
	cp innasrv.init /etc/init.d/innasrv

init-uninstall:
	service innasrv stop
	chkconfig --del innasrv
	rm -f /usr/local/sbin/innasrv /etc/innasrv.cfg \
              /etc/init.d/innasrv /var/log/innasrv.log
