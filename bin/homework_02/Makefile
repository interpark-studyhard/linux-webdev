
submit_url = http://studyhard.yidigun.com/linux-webdev/cgi-bin/submit.sh
homework = homework_02

.PHONY: help download init clean distclean check submit cleancheck extract

help:
	@echo -e "Study Hard: Linux homework_02\n"; \
	echo -e "make init\tDownload and extract example archive."; \
	echo -e "make check\tCheck resolve all the problems."; \
	echo -e "make submit\tSubmit homework. (If you get pass 'make check'.)\n"; \
	echo -e "make clean\tClean work directory."; \
	echo -e "make distclean\tClean work directory and also clean downloaded files.\n"

download: data/broken.zip

init: clean extract

extract: data/broken.zip
	unzip -q data/broken.zip

clean:
	rm -rf soo jin jin.md5 soo.md5

distclean: clean
	rm -rf data

cleancheck:
	rm -f jin.md5 soo.md5

check: data/merged.md5 cleancheck jin.md5 soo.md5
	@if diff -q jin.md5 soo.md5; then \
		echo "You have synchronized soo and jin. 1st step: PASSED"; \
		if diff -q data/merged.md5 jin.md5; then \
			echo "Congraturation! 2nd step: PASSED"; \
		else \
			echo "2nd step: NOT PASSED"; \
		fi; \
	else \
		echo "Dir soo and jin is still different. 1st step: NOT PASSED"; \
		echo "2nd step: NOT PASSED"; \
	fi

submit: jin.md5 soo.md5
	@confirm=n; \
	until [ x$$confirm = xY -o x$$confirm = xy ]; do \
	    echo -n "Enter your e-mail: "; \
	    read email; \
	    echo -ne "It it correct? ($$email) [y/N] "; \
	    read confirm; \
	done; \
	curl -T jin.md5 $(submit_url)/$(homework)/$${email}/jin.md5; \
	curl -T soo.md5 $(submit_url)/$(homework)/$${email}/soo.md5; \

soo: extract

jin: extract

jin.md5:
	(cd jin; find . -type f -exec md5sum {} \; | sort ) >jin.md5

soo.md5:
	(cd soo; find . -type f -exec md5sum {} \; | sort ) >soo.md5

data:
	mkdir -p data

data/broken.zip: data
	curl -o data/broken.zip http://studyhard.yidigun.com/dist/broken.zip

data/merged.md5: data
	curl -o data/merged.md5 http://studyhard.yidigun.com/dist/merged.md5

