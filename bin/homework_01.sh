#!/bin/sh

myname=`basename $0 .sh`

submit_url=http://studyhard.yidigun.com/linux-webdev/cgi-bin/submit.sh
homework=homework_01

# accept input
confirm=n
until [ x$confirm = xY -o x$confirm = xy ]; do
    echo -n "Enter your e-mail: "
    read email
    echo -ne "It it correct? ($email) [y/N] ";
    read confirm
done
hostname=`hostname -s`
echo "Your hostname is $hostname."

echo -n "Collecting config files."
configs="hostname hosts sysconfig/network-scripts/ifcfg-*"

tmpdir=/tmp/${myname}-$$
mkdir -p $tmpdir/a $tmpdir/b
echo -n "."

(cd /etc; tar cf - $configs) | \
    (cd $tmpdir/b; tar xf -)
echo "done."

echo -n "Submit config files... "
(cd $tmpdir; \
    diff -Nuar a b | \
    curl -T - $submit_url/$homework/$email/$hostname) && \
rm -rf $tmpdir

# end of script
