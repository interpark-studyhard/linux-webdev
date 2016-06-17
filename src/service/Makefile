
TARGETS = innad1 innad2 innad3 innad4 innad5
OBJS = innad1.o innad2.o innad3.o innad4.o innad5.o
LIBS = -lc

.SUFFIXES: .c .o
.PHONY: all compile clean install

all: compile $(TARGETS)

compile: $(OBJS)

clean:
	rm -f $(TARGETS) $(OBJS) a.out core *.log

init-install: innad4
	cp innad4 /usr/local/sbin/innad
	cp innad.cfg /etc/innad.cfg
	cp innad.init /etc/init.d/innad

init-uninstall:
	service innad stop
	chkconfig --del innad
	rm -f /usr/local/sbin/innad /etc/innad.cfg \
              /etc/init.d/innad /var/log/innad.log

upstart-install: innad5
	cp innad5 /usr/local/sbin/innad
	cp innad.cfg /etc/innad.cfg
	cp innad.upstart /etc/init/innad.conf

upstart-uninstall:
	initctl status innad | grep -q 'run' \
             && initctl stop innad; true
	rm -f /usr/local/sbin/innad /etc/innad.cfg \
		/etc/init/innad.conf /var/log/innad.log

systemd-install: innad5
	cp innad5 /usr/local/sbin/innad
	cp innad.cfg /etc/innad.cfg
	cp innad.systemd /lib/systemd/system/innad.service

systemd-uninstall:
	systemctl stop innad
	systemctl disable innad
	rm -f /usr/local/sbin/innad /etc/innad.cfg \
		/lib/systemd/system/innad.service \
		 /var/log/innad.log

