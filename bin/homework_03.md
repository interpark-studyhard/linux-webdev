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

요령은 2회차때 다운받은 리포지토리에서 제출할 수 있다.

    dagui@yura:~]$ git clone https://github.com/interpark-studyhard/linux-webdev.git
    Cloning into 'linux-webdev'...
    remote: Counting objects: 153, done.
    remote: Compressing objects: 100% (57/57), done.
    remote: Total 153 (delta 17), reused 0 (delta 0), pack-reused 93
    Receiving objects: 100% (153/153), 732.40 KiB | 211.00 KiB/s, done.
    Resolving deltas: 100% (41/41), done.
    dagui@yura:~]$ ls
    linux-webdev  공개  다운로드  문서  바탕화면  비디오  사진  서식  음악
    dagui@yura:~]$
    dagui@yura:~]$ cd linux-webdev/
    dagui@yura:~/linux-webdev]$ ls
    README.md  SCHEDULE.md  TOC.md  bin  cgi-bin  images  src
    dagui@yura:~/linux-webdev]$ 

요령은 2회차때 다운받은 리포지토리에서 제출할 수 있다.

    studyhard@inna:~/linux-webdev/bin]$ sh homework_03.sh
    usage: homework_03.sh [ -ev ] [ -f script ] email
      -f 스크립트   : 스크립트 파일을 지정합니다.
      -e            : 편집기를 실행시켜서 스크립트를 입력합니다.
      -v            : 전송 과정을 자세히 표시합니다.
    studyhard@inna:~/linux-webdev/bin]$ sh homework_03.sh dklee@interpark.com
    * 스크립트를 직접 입력합니다. 입력을 종료하려면 Ctrl-D를 누르세요.
    #!/bin/sh
    echo "I'm so sorry. T.T"
    Thanks for your submission: dklee@interpark.com.sh.txt



