# 4회차 숙제 하는 법

## 4회차 숙제 내용

> 고객들의 홈페이지를 서비스하는 웹 호스팅 서버의 운영자가 되었다 생각하자.  
> 각각의 고객들의 사업비밀을 보장하기 위해서, 고객들은 자신의 소스파일에만 접근할 수 있고  
> 다른 고객의 소스파일을 볼 수 없어야 한다.

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

브라우저에서 접속해 본다.

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

# 




