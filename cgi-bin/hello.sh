#!/bin/sh

echo "Content-Type: text/html; charset=UTF-8"
echo

title="Hello, CGI!"

cat <<EOF
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${title}</title>
</head>
<body>
<h1>${title}</h1>

<p>A Good day to STUDY HARD</p>
<img src="../images/a-good-day-to-study-hard.jpg" alt="" style="max-width:100%;">
EOF


# print source
echo '<h3>This is my source code.</h3>'
echo -n '<blockquote><pre>'
cat $0 | sed -e 's/</\&lt;/g' -e 's/>/\&gt;/g'
echo '</pre></blockquote>'

cat <<EOF
</body>
</html>
EOF
# end of script
