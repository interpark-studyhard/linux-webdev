#!/bin/bash

# parse parameters
ifsbk=$IFS; IFS="&"
set -- $QUERY_STRING
IFS=$ifsbk

for p in $*; do
    p_nm=`echo $p | sed -e 's/=.*$//'`
    p_vl=`echo $p | sed -e 's/^.*=//'`
    eval "req_${p_nm}=${p_vl}"
done

# check token
token=gTb9no3srtZhelWS7XDQRkdU
if [ x"$token" != x"$req_token" ]; then
    echo "Status: 403 Forbidden"
    echo "Content-Type: text/plain"
    echo
    echo "403 Forbidden"
    exit 0
fi

# get parameters
user_name=${req_user_name:-UnknownUser}
maximum=${req_text:-6}
maximum=`expr $maximum + 0` # force convert number

# throw dice
rand=`expr \( $RANDOM + 1 \) % $maximum`

# output
echo "Content-Type: application/json"
echo "Cache-Control: no-cache"
echo
cat <<EOF
{"response_type":"in_channel","text":"@${user_name} \ub2d8\uc774 ${maximum}\uba74\uccb4 \uc8fc\uc0ac\uc704\ub97c \ub358\uc84c\uc2b5\ub2c8\ub2e4: ${rand}"}
EOF
# end of script
