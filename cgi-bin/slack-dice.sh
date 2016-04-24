#!/bin/sh

# include config
. `dirname $0`/slack-dice.conf

ts=`date +%s`
date=`date +%Y-%m-%d`
time=`date +%H:%M:%S`
logfile=$LOGDIR/dice-${date}.log


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
text=${req_text:-6}

echo "Content-Type: application/json"
echo "Cache-Control: no-cache"
echo
if echo $text | egrep -qi '^check:(0x?)?[0-9a-f]+$'; then
	maximum=`echo $text | sed -e 's/^check://i'`
	maximum=`printf '%d' $maximum`

	# check log
	if [ -f $logfile ]; then
		rank=`grep "\\bmax=$maximum\\b" $logfile | \
		        cut -f 5-6 | \
		          awk -F"\t" '{ if (a[$2] == "") a[$2] = $1; } END { for (n in a) print a[n] "\t@" n; } ' | \
		            sort -nr | \
		              sed -e 's/\t/\\\\t/g' -e 's/$/\\\\n/g' | \
		                tr -d '\n'`
	else
		rank="참여자가 없습니다."
	fi

	if [ x = x$rank ]; then
		rank="참여자가 없습니다."
	fi

	# output
	cat <<EOF
{"response_type":"in_channel","text":"/dice ${maximum} 결과를 발표하겠습니다.","attachments":[{"text":"${rank}"}]}
EOF
elif echo $text | egrep -qi '^(0x?)?[0-9a-f]+$'; then
	maximum=`printf '%d' $text`

	# throw dice
	rand=`expr $RANDOM % $maximum + 1`

	# log
	echo -e "${date}\t${time}\t${ts}\tmax=${maximum}\t${rand}\t${user_name}" >>$LOGDIR/dice-${date}.log

	# output
	cat <<EOF
{"response_type":"in_channel","text":"@${user_name} \ub2d8\uc774 ${maximum}\uba74\uccb4 \uc8fc\uc0ac\uc704\ub97c \ub358\uc84c\uc2b5\ub2c8\ub2e4: ${rand}"}
EOF
else
	# error
	cat <<EOF
{"response_type":"ephemeral","text":"입력 형식이 올바르지 않습니다.($text) /dice 최대값 또는 /dice check:최대값."}
EOF
fi

# end of script
