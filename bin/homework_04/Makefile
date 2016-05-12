
submit_url = http://studyhard.yidigun.com/linux-webdev/cgi-bin/submit.sh
homework = homework_04

.PHONY: help download init clean distclean check submit cleancheck

help:
	@echo -e "Study Hard: Linux homework_04\n"; \
	echo -e "make init\tInstall hompage files."; \
	echo -e "make check\tCheck permission setting works."; \
	echo -e "make submit\tSubmit homework. (If you get pass 'make check'.)\n";

init:
	@echo Please enter root password.; \
	wd=`pwd`; \
	su - root -c "rm -rf /var/www/html/pororo /var/www/html/crong; \
	chown root:root /var/www/html; \
	chmod 0755 /var/www/html; \
	cp -r $${wd}/pororo $${wd}/crong /var/www/html"

check:
	@echo Please enter root password.; \
	wd=`pwd`; \
	su - root -c "cd $$wd; $(MAKE) check-root"

check-root:
	@su apache -s /bin/bash -c 'if [ -r /var/www/html/pororo/index.html -a -r /var/www/html/crong/index.html ]; then \
		echo "User apache can read both pororo and crong: PASS."; \
	else \
		echo "User apache cannot read pororo or crong: FAIL."; \
	fi; \
	if [ -w /var/www/html/pororo/index.html -o -w /var/www/html/crong/index.html ]; then \
		echo "User apache can write pororo or crong: FAIL."; \
	else \
		echo "User apache cannot write both pororo and crong: PASS."; \
	fi'; \
	su pororo -s /bin/bash -c 'if [ -r /var/www/html/pororo/index.html -a ! -r /var/www/html/crong/index.html ]; then \
		echo "User pororo can read pororo and cannot read crong: PASS."; \
	elif [ ! -r /var/www/html/pororo/index.html ]; then \
		echo "User pororo cannot read pororo: FAIL."; \
	elif [ -r /var/www/html/crong/index.html ]; then \
		echo "User pororo can read crong: FAIL."; \
	else \
		echo "User pororo cannot read both pororo and crong: FAIL."; \
	fi; \
	if [ -w /var/www/html/pororo/index.html -a ! -w /var/www/html/crong/index.html ]; then \
		echo "User pororo can write pororo and cannot write crong: PASS."; \
	elif [ ! -w /var/www/html/pororo/index.html ]; then \
		echo "User pororo cannot write pororo: FAIL."; \
	elif [ -w /var/www/html/crong/index.html ]; then \
		echo "User pororo can write crong: FAIL."; \
	else \
		echo "User pororo cannot write both pororo and crong: FAIL."; \
	fi'; \
	su crong -s /bin/bash -c 'if [ -r /var/www/html/crong/index.html -a ! -r /var/www/html/pororo/index.html ]; then \
		echo "User crong can read crong and cannot read pororo: PASS."; \
	elif [ ! -r /var/www/html/crong/index.html ]; then \
		echo "User crong cannot read crong: FAIL."; \
	elif [ -r /var/www/html/pororo/index.html ]; then \
		echo "User crong can read pororo: FAIL."; \
	else \
		echo "User crong cannot read both crong and pororo: FAIL."; \
	fi; \
	if [ -w /var/www/html/crong/index.html -a ! -w /var/www/html/pororo/index.html ]; then \
		echo "User crong can write crong and cannot write pororo: PASS."; \
	elif [ ! -w /var/www/html/crong/index.html ]; then \
		echo "User crong cannot write crong: FAIL."; \
	elif [ -w /var/www/html/pororo/index.html ]; then \
		echo "User crong can write pororo: FAIL."; \
	else \
		echo "User crong cannot write both crong and pororo: FAIL."; \
	fi'
	

submit:
	@confirm=n; \
	until [ x$$confirm = xY -o x$$confirm = xy ]; do \
	    echo -n "Enter your e-mail: "; \
	    read email; \
	    echo -ne "It it correct? ($$email) [y/N] "; \
	    read confirm; \
	done; \
	configs="passwd group"; \
	tmpdir=/tmp/${myname}-$$$$; \
	mkdir -p $$tmpdir/a $$tmpdir/b; \
	(cd /etc; tar cf - $$configs) | (cd $$tmpdir/b; tar xf -); \
	(cd /var/www/html; ls -Ral) >$$tmpdir/b/ls-Ral.txt; \
	echo -n "Submit config files... "; \
	(cd $$tmpdir; \
	    diff -Nuar a b | \
	    curl -T - $(submit_url)/$(homework)/$${email}.patch) && \
	rm -rf $$tmpdir


