#!/bin/sh

BASEDIR=/home/vhosts/studyhard/linux-webdev/homeworks

path=`echo $PATH_INFO | sed -e 's/^\///'`
dir=`dirname $path`
file=`basename $path`.patch

umask 002
mkdir -p $BASEDIR/$dir
cat > $BASEDIR/$dir/$file

echo "Status: 201 Created"
echo "Content-Type: text/plain; charset=UTF-8"
echo
echo "Thanks for your submission."
