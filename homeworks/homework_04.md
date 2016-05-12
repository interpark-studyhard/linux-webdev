# 4회차 숙제 하는 법

## 4회차 숙제 내용

> 고객들의 홈페이지를 서비스하는 웹 호스팅 서버의 운영자가 되었다 생각하자.  
> 각각의 고객들의 사업비밀을 보장하기 위해서, 고객들은 자신의 소스파일에만 접근할 수 있고  
> 다른 고객의 소스파일을 볼 수 없어야 한다.

## 업데이트

이제 `git pull`은 기본이다.

    $ cd linux-webdev
    $ git pull

## 아파치 서버 설치

아파치 서버가 설치되어있지 않다면 설치한다. 그런데 기본으로 설치되어있을 가능성이 높다.

    # rpm -q httpd
    # yum install httpd

설치되어있는 아파치 서버를 활성화 시키고, 서비스를 시작한다.

    # systemctl enable httpd.service
    # systemctl start httpd

실행중인지 확인해 본다.

    # systemctl status httpd
    ● httpd.service - The Apache HTTP Server
       Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
       Active: active (running) since 목 2016-05-12 07:17:01 KST; 1min 23s ago
         Docs: man:httpd(8)
               man:apachectl(8)
      Process: 8902 ExecStop=/bin/kill -WINCH ${MAINPID} (code=exited, status=0/SUCCESS)
     Main PID: 8915 (httpd)
       Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
       CGroup: /system.slice/httpd.service
               ├─8915 /usr/sbin/httpd -DFOREGROUND
               ├─8916 /usr/sbin/httpd -DFOREGROUND
               ├─8917 /usr/sbin/httpd -DFOREGROUND
               ├─8918 /usr/sbin/httpd -DFOREGROUND
               ├─8919 /usr/sbin/httpd -DFOREGROUND
               ├─8920 /usr/sbin/httpd -DFOREGROUND
               └─8921 /usr/sbin/httpd -DFOREGROUND
    
     5월 12 07:17:01 yura.girlsday.yidigun.com systemd[1]: Starting The Apache H...
     5월 12 07:17:01 yura.girlsday.yidigun.com httpd[8915]: AH00558: httpd: Coul...
     5월 12 07:17:01 yura.girlsday.yidigun.com systemd[1]: Started The Apache HT...
    Hint: Some lines were ellipsized, use -l to show in full.

브라우저에서 접속해 본다. CentOS 페이지가 뜨면 정상.

    http://yura.girlsday.yidigun.com/

## 고객 계정 등록

뽀로로 고객과 크롱 고객의 계정을 등록한다.

    # useradd pororo; passwd pororo
    # useradd crong; passwd crong

고객들의 홈페이지 파일을 `/var/www/html` 에 복사해준다.

    # cd /var/www/html
    # cp -r ~dagui/linux-webdev/bin/homework_04/* .

고객들의 홈페이지가 제대로 보이는지 확인한다.

    http://yura.girlsday.yidigun.com/pororo/
    http://yura.girlsday.yidigun.com/crong/

## 권한을 설정한다.

아파치 웹서버는 `apache`라는 계정으로 실행된다. 따라서 웹서비스가 정상적으로 되려면 `apache` 유저는 모든 파일에 읽기 권한을 가지고 있어야 한다.

* `apache` 계정은 `/var/www/html/pororo` 와 `/var/www/html/crong` 을 읽을 수 있다. 쓰기 권한은 없어야 한다.
* `pororo` 계정은 `/var/www/html/pororo` 에는 읽기/쓰기 권한이 있어야 한다. 그렇지만 `/var/www/html/crong` 폴더는 읽을 수 없어야 한다.
* `crong` 계정은 `/var/www/html/crong` 에는 읽기/쓰기 권한이 있어야 한다. 그렇지만 `/var/www/html/pororo` 폴더는 읽을 수 없어야 한다.

[chown](http://linux.die.net/man/1/chown), [chmod](http://linux.die.net/man/1/chmod) 등의 명령을 이용하여 `/var/www/html/pororo` 와 `/var/www/html/crong` 폴더의 권한을 설정한다. 

필요하다면 `pororo`, `crong` 계정의 그룹을 변경해도 좋다.

## 검사하고 제출하는 방법

일단 make check 를 입력해서 검사를 해본다. 계정을 바꿔가면서 검사하기 때문에 `root`의 권한이 필요하다.

    dagui@yura:~/linux-webdev/bin/homework_04]$ make check
    Please enter root password.
    암호:
    User apache can read both pororo and crong: PASS.
    User apache cannot write both pororo and crong: PASS.
    User pororo can read crong: FAIL.
    User pororo cannot write pororo: FAIL.
    User crong can read pororo: FAIL.
    User crong cannot write crong: FAIL.
    dagui@yura:~/linux-webdev/bin/homework_04]$ 

성공한 경우

    dagui@yura:~/linux-webdev/bin/homework_04]$ make check
    Please enter root password.
    암호:
    User apache can read both pororo and crong: PASS.
    User apache cannot write both pororo and crong: PASS.
    User pororo can read pororo and cannot read crong: PASS.
    User pororo can write pororo and cannot write crong: PASS.
    User crong can read crong and cannot read pororo: PASS.
    User crong can write crong and cannot write pororo: PASS.
    dagui@yura:~/linux-webdev/bin/homework_04]$ 

`make submit` 으로 숙제를 제출한다.

    dagui@yura:~/linux-webdev/bin/homework_04]$ make submit
    Enter your e-mail: dklee@interpark.com
    It it correct? (dklee@interpark.com) [y/N] y
    Submit config files... Thanks for your submission: dklee@interpark.com.patch
    dagui@yura:~/linux-webdev/bin/homework_04]$ 

작업하다 망했을 경우 `make init` 을 쳐서 처음부터 다시 시작할 수 있다. 역시 `root` 권한이 필요하므로 비밀번호를 입력해야 한다.
단, 계정/그룹의 수정은 복원되지 않는다.

    dagui@yura:~/linux-webdev/bin/homework_04]$ make init
    Please enter root password.
    암호:
    dagui@yura:~/linux-webdev/bin/homework_04]$ 

