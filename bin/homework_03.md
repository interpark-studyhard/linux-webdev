# 3회차 숙제 하는 방법

## 3회차 숙제 내용

> 1회차 숙제 제출 스크립트의 소스를 분석하여 제출한 파일을 다운로드 받아 현재 위치에 설정파일들을 복원하는 스크립트를 작성하시오.

* 1회차 숙제 제출 방법 :   
[https://github.com/interpark-studyhard/linux-webdev/blob/master/bin/homework_01.md](https://github.com/interpark-studyhard/linux-webdev/blob/master/bin/homework_01.md)

* 1회차 숙제 제출 스크립트 소스:   
[https://github.com/interpark-studyhard/linux-webdev/blob/master/bin/homework_01.sh](https://github.com/interpark-studyhard/linux-webdev/blob/master/bin/homework_01.sh)

## 1. 숙제 파일 다운로드

1회차때 제출한 숙제 파일은 아래와 같은 규칙으로 업로드 되어있다.

> http://studyhard.yidigun.com/linux-webdev/homeworks/homework_01/${email}/${hostname}.patch

* `${email}`: 제출 시 입력한 이메일 주소
* `${hostname}`: 제출 당시 설정했던 호스트명


## 2. 설정 파일 복원

다운로드 받은 파일을 이용하여 `/etc` 에 있던 설정 파일을 현재 디렉토리 위치에서 복원해야 한다.

## 3. 스크립트 실행 예시

스크립트를 `myscript.sh` 에 작성했다 치고.

    dagui@yura:~]$ vi myscript.sh
    dagui@yura:~]$ mkdir t
    dagui@yura:~]$ cd t
    dagui@yura:~/t]$ sh ../myscript.sh
    dagui@yura:~/t]$ ls -Rl
    .:
    합계 12
    -rw-rw-r-- 1 studyhard studyhard   26 2016-04-25 04:59 hostname
    -rw-rw-r-- 1 studyhard studyhard  272 2016-04-25 04:59 hosts
    drwxrwxr-x 3 studyhard studyhard 4096 2016-04-25 04:59 sysconfig
    
    ./sysconfig:
    합계 4
    drwxrwxr-x 2 studyhard studyhard 4096 2016-04-25 04:59 network-scripts
    
    ./sysconfig/network-scripts:
    합계 8
    -rw-rw-r-- 1 studyhard studyhard 413 2016-04-25 04:59 ifcfg-eno16777736
    -rw-rw-r-- 1 studyhard studyhard 254 2016-04-25 04:59 ifcfg-lo
    dagui@yura:~/t]$ 

## 제출 방법

숙제 제출은 2회차때 다운받은 리포지토리에서 제출할 수 있다. 기존의 리포지토리를 업데이트를 한다.

    dagui@yura:~]$ cd linux-webdev/
    dagui@yura:~/linux-webdev]$ git pull
    remote: Counting objects: 6, done.
    remote: Compressing objects: 100% (5/5), done.
    remote: Total 6 (delta 1), reused 6 (delta 1), pack-reused 0
    Unpacking objects: 100% (6/6), done.
    From https://github.com/interpark-studyhard/linux-webdev
       3a235e4..cf5f3eb  master     -> origin/master
    Updating 3a235e4..cf5f3eb
    Fast-forward
     bin/homework_01.md | 38 ++++++++++++++++++++++++++++++++++++++
     bin/homework_03.md | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     bin/homework_03.sh | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     3 files changed, 204 insertions(+)
     create mode 100644 bin/homework_01.md
     create mode 100644 bin/homework_03.md
     create mode 100755 bin/homework_03.sh
    dagui@yura:~/linux-webdev]$

리포지토리를 지웠다면 새로 받도록 한다.

    dagui@yura:~]$ git clone https://github.com/interpark-studyhard/linux-webdev.git
    Cloning into 'linux-webdev'...
    remote: Counting objects: 221, done.
    remote: Compressing objects: 100% (15/15), done.
    remote: Total 221 (delta 6), reused 0 (delta 0), pack-reused 206
    Receiving objects: 100% (221/221), 744.76 KiB | 348.00 KiB/s, done.
    Resolving deltas: 100% (80/80), done.
    dagui@yura:~]$ ls
    homework_01.sh  linux-webdev  myscript.sh  t  공개  다운로드  문서  바탕화면  비디오  사진  서식  음악
    dagui@yura:~]$ cd linux-webdev/
    dagui@yura:~/linux-webdev]$ ls
    README.md  SCHEDULE.md  TOC.md  bin  cgi-bin  images  src
    dagui@yura:~/linux-webdev]$

일단 한번 제출 스크립트를 실행시켜보자. 설명이 한글로 나온다.(콩글리시도 귀찮다)

    dagui@yura:~/linux-webdev/bin]$ sh homework_03.sh
    usage: homework_03.sh [ -ev ] [ -f script ] email
      -f 스크립트   : 스크립트 파일을 지정합니다.
      -e            : 편집기를 실행시켜서 스크립트를 입력합니다.
      -v            : 전송 과정을 자세히 표시합니다.

작성한 스크립트 파일을 -f 옵션으로 제출할 수 있다.

    dagui@yura:~/linux-webdev]$ cd bin
    dagui@yura:~/linux-webdev/bin]$ sh homework_03.sh -f ~/myscript.sh dklee@interpark.com
    Thanks for your submission: dklee@interpark.com.sh.txt
    dagui@yura:~/linux-webdev/bin]$

전송 과정을 자세히 보고 싶다면 -v 옵션을 주면 된다.

    dagui@yura:~/linux-webdev/bin]$ sh homework_03.sh -vf ~/myscript.sh dklee@interpark.com
    script> #!/bin/sh
    script> echo "I'm sorry T,.T"
    * About to connect() to studyhard.yidigun.com port 80 (#0)
    *   Trying 115.68.23.160...
    * Connected to studyhard.yidigun.com (115.68.23.160) port 80 (#0)
    > PUT /linux-webdev/cgi-bin/submit.sh/homework_03/dklee@interpark.com.sh.txt HTTP/1.1
    > User-Agent: curl/7.29.0
    > Host: studyhard.yidigun.com
    > Accept: */*
    > Content-Length: 31
    > Expect: 100-continue
    >
    < HTTP/1.1 100 Continue
    * We are completely uploaded and fine
    < HTTP/1.1 201 Created
    < Date: Sun, 24 Apr 2016 20:25:04 GMT
    < Server: Apache/2.4.12 (Unix) OpenSSL/1.0.1e-fips Phusion_Passenger/5.0.8
    < Transfer-Encoding: chunked
    < Content-Type: text/plain; charset=UTF-8
    < Connection: close
    <
    Thanks for your submission: dklee@interpark.com.sh.txt
    * Closing connection 0
    dagui@yura:~/linux-webdev/bin]$

스크립트 파일을 따로 만들지 않았다면 아무 옵션을 주지 않으면 직접 입력할 수 있다.

    dagui@yura:~/linux-webdev/bin]$ sh homework_03.sh dklee@interpark.com
    * 스크립트를 직접 입력합니다. 입력을 종료하려면 Ctrl-D를 누르세요.
    #!/bin/sh
    echo "I'm so sorry T,.T"
    Thanks for your submission: dklee@interpark.com.sh.txt
    dagui@yura:~/linux-webdev/bin]$

스크립트 내용이 여러줄이라서 입력하기 힘들면 -e 옵션을 줘서 편집기를 이용할 수 있다.

    dagui@yura:~/linux-webdev/bin]$ EDITOR=/usr/bin/vi
    dagui@yura:~/linux-webdev/bin]$ export EDITOR
    dagui@yura:~/linux-webdev/bin]$ sh homework_03.sh -ve dklee@interpark.com
    script> #!/bin/sh
    script> echo "I'm sorry T,.T"
    script> echo T,.T
    script> echo T,.T
    script> echo T,.T
    * About to connect() to studyhard.yidigun.com port 80 (#0)
    *   Trying 115.68.23.160...
    * Connected to studyhard.yidigun.com (115.68.23.160) port 80 (#0)
    > PUT /linux-webdev/cgi-bin/submit.sh/homework_03/dklee@interpark.com.sh.txt HTTP/1.1
    > User-Agent: curl/7.29.0
    > Host: studyhard.yidigun.com
    > Accept: */*
    > Content-Length: 58
    > Expect: 100-continue
    >
    < HTTP/1.1 100 Continue
    * We are completely uploaded and fine
    < HTTP/1.1 201 Created
    < Date: Sun, 24 Apr 2016 20:22:22 GMT
    < Server: Apache/2.4.12 (Unix) OpenSSL/1.0.1e-fips Phusion_Passenger/5.0.8
    < Content-Length: 55
    < Content-Type: text/plain; charset=UTF-8
    < Connection: close
    <
    Thanks for your submission: dklee@interpark.com.sh.txt
    * Closing connection 0
    dagui@yura:~/linux-webdev/bin]$

