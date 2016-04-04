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

dagui@sojin:~]$ curl -O http://studyhard.yidigun.com/linux-webdev/bin/homework_01.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   763  100   763    0     0    137      0  0:00:05  0:00:05 --:--:--   189
dagui@sojin:~]$ sh homework_01.sh
Enter your e-mail: dklee@interpark.com
It it correct? (dklee@interpark.com) [y/N] y
Your hostname is sojin.
Collecting config files..done.
Submit config files... Thanks for your submission.
dagui@sojin:~]$

