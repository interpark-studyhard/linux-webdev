#!/bin/sh

myname=`basename $0 .sh`

submit_url=http://studyhard.yidigun.com/linux-webdev/cgi-bin/submit.sh
homework=homework_03
EDITOR=${EDITOR:-/usr/bin/vim}

if tty -s; then
    is_tty=1
else
    is_tty=0
fi

verbose=0
editor=0
script=
email=
while getopts "vef:" OPTION; do
    case $OPTION in
    v)
        verbose=1
        ;;
    f)
        script=$OPTARG
        ;;
    e)
        editor=1
        ;;
    ?)
        echo "usage: $0 [ -ev ] [ -f script ] email"
        echo -e "  -f 스크립트\t: 스크립트 파일을 지정합니다."
        echo -e "  -e\t\t: 편집기를 실행시켜서 스크립트를 입력합니다."
        echo -e "  -v\t\t: 전송 과정을 자세히 표시합니다."
        exit 1
        ;;
    esac
done
shift `expr $OPTIND - 1`

if [ $# -ge 1 ];then
    email=$1
else
    echo "usage: $0 [ -ev ] [ -f script ] email"
    echo -e "  -f 스크립트\t: 스크립트 파일을 지정합니다."
    echo -e "  -e\t\t: 편집기를 실행시켜서 스크립트를 입력합니다."
    echo -e "  -v\t\t: 전송 과정을 자세히 표시합니다."
    exit 2
fi
if [ $verbose -eq 1 ]; then
    curl_opts=" -v "
else
    curl_opts=""
fi

if [ \( x$script = x -o x$script = x- \) -a $is_tty ]; then
    tmpfile=/tmp/$myname-$$
    echo "#!/bin/sh" >$tmpfile

    if [ $editor -eq 1 ]; then
        echo >>$tmpfile
        $EDITOR +2 $tmpfile
    else
        cat <<EOF
* 스크립트를 직접 입력합니다. 입력을 종료하려면 Ctrl-D를 누르세요.
EOF
        cat $tmpfile
        cat >>$tmpfile
    fi

    script=$tmpfile
fi

[ $verbose -eq 1 ] && (cat $script | sed -e 's/^/script> /')
curl $curl_opts -T $script "$submit_url/$homework/$email.sh.txt"

if [ x$tmpfile -a -f $tmpfile ]; then
    rm -f $tmpfile
fi

# end of script
