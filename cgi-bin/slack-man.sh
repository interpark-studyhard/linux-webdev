#!/bin/sh

# include config
. `dirname $0`/slack-man.conf

man=/usr/bin/man
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

# check token
token=$SLACK_TOKEN
if [ x"$token" != x"$req_token" ]; then
    echo "Status: 403 Forbidden"
    echo "Content-Type: text/html"
    echo
    echo "Forbidden. This CGI script serve for <a href=\"https://interpark-studyhard.slack.com/\">https://interpark-studyhard.slack.com/</a>."
    exit 0
fi

# get parameters
user_name=${req_user_name:-UnknownUser}
text=${req_text:-man}

set -- $text

LANG=ko_KR.UTF-8
export LANG
if [ $# -gt 1 ]; then
    sec=$1
    cmd=$2
    whatis_rs=`$whatis $cmd | egrep "^$cmd\\s+\\($sec\\)\\s+" | head -1`
else
    sec=
    cmd=$1
    whatis_rs=`$whatis $cmd | egrep "^$cmd\\s+" | head -1`
fi
cmd=`echo $whatis_rs | cut -d" " -f1`
if [ x$cmd != x ]; then
    sec=`echo $whatis_rs | sed -e 's/^.*(//' -e 's/).*$//'`
    desc=`echo $whatis_rs | sed -e 's/^.* - //'`
    page=`man -w $sec $cmd`
fi

url="http://studyhard.yidigun.com/linux-webdev/cgi-bin/man.sh?cmd=$cmd&sec=$sec"

echo "Content-Type: application/json"
echo "Cache-Control: no-cache"
echo

if [ x$cmd = x -o x$page = x ]; then
    cat <<EOF
{"response_type":"ephemeral","text":"매뉴얼 페이지를 찾을 수 없습니다: $text"}
EOF
else
    cat <<EOF
{"response_type":"in_channel","text":"${cmd} ($sec) - ${desc}","attachments":[{"title":"${cmd} ($sec) - ${desc}","title_link":"${url}"}]}
EOF
fi

# end of script
