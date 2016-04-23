#!/bin/sh

man=/usr/bin/man
groff=/usr/bin/groff
groff_args=" -Thtml -mandoc "
zcat=/bin/zcat
whatis=/usr/bin/whatis

# parse parameters
ifsbk=$IFS; IFS="&"
set -- $QUERY_STRING
IFS=$ifsbk

for p in $*; do
    p_nm=`echo $p | sed -e 's/=.*$//'`
    p_vl=`echo $p | sed -e 's/^.*=//' | sed -e 's@+@ @g;s@%@\\\\x@g' | xargs -0 printf "%b"`
    eval "req_${p_nm}='${p_vl}'"
done

sec=${req_sec}
cmd=${req_cmd:-man}

LANG=C
export LANG


if [ x$sec = x ]; then
    whatis_rs=`whatis $cmd | egrep "^$cmd\\s+" | head -1`
else
    whatis_rs=`whatis $cmd | egrep "^$cmd\\s+\\($sec\\)\\s+" | head -1`
fi
cmd=`echo $whatis_rs | cut -d" " -f1`
if [ x$cmd != x ]; then
    sec=`echo $whatis_rs | sed -e 's/^.*(//' -e 's/).*$//'`
    desc=`echo $whatis_rs | sed -e 's/^.* - //'`
    page=`man -w $sec $cmd`
fi

if [ x$cmd = x -o x$page = x ]; then
    echo "Status: 404 Not Found"
    echo "Content-Type: text/plain; charset=UTF-8"
    echo
    echo "Not found: man $sec $cmd"
    exit 0
fi

echo "Content-Type: text/html; charset=UTF-8"
echo
$zcat $page | $groff $groff_args

# end of script
