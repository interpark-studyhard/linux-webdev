# 2회차 숙제 하는 방법

## git 설치

GitHub에 접속하기 위해 git을 설치한다.

    dagui@yura:~]$ su -
    암호:
    마지막 로그인: 수  4월 13 15:14:00 KST 2016 일시 :0
    root@yura:~]# yum install git
    Loaded plugins: fastestmirror, langpacks
    base                                                     | 3.6 kB     00:00     
    extras                                                   | 3.4 kB     00:00     
    updates                                                  | 3.4 kB     00:00     
    updates/7/x86_64/primary_db                                | 4.1 MB   00:17     
    Loading mirror speeds from cached hostfile
     * base: ftp.daumkakao.com
     * extras: ftp.daumkakao.com
     * updates: mirrors.zju.edu.cn
    Resolving Dependencies
    --> Running transaction check
    ---> Package git.x86_64 0:1.8.3.1-6.el7_2.1 will be installed
    --> Processing Dependency: perl-Git = 1.8.3.1-6.el7_2.1 for package: git-1.8.3.1-6.el7_2.1.x86_64
    --> Processing Dependency: perl(Term::ReadKey) for package: git-1.8.3.1-6.el7_2.1.x86_64
    --> Processing Dependency: perl(Git) for package: git-1.8.3.1-6.el7_2.1.x86_64
    --> Processing Dependency: perl(Error) for package: git-1.8.3.1-6.el7_2.1.x86_64
    --> Running transaction check
    ---> Package perl-Error.noarch 1:0.17020-2.el7 will be installed
    ---> Package perl-Git.noarch 0:1.8.3.1-6.el7_2.1 will be installed
    ---> Package perl-TermReadKey.x86_64 0:2.30-20.el7 will be installed
    --> Finished Dependency Resolution

    Dependencies Resolved

    ================================================================================
     Package               Arch        Version                   Repository    Size
    ================================================================================
    Installing:
     git                   x86_64      1.8.3.1-6.el7_2.1         updates      4.4 M
    Installing for dependencies:
     perl-Error            noarch      1:0.17020-2.el7           base          32 k
     perl-Git              noarch      1.8.3.1-6.el7_2.1         updates       53 k
     perl-TermReadKey      x86_64      2.30-20.el7               base          31 k

    Transaction Summary
    ================================================================================
    Install  1 Package (+3 Dependent packages)

    Total download size: 4.5 M
    Installed size: 22 M
    Is this ok [y/d/N]: y
    Downloading packages:
    경고: /var/cache/yum/x86_64/7/base/packages/perl-Error-0.17020-2.el7.noarch.rpm: Header V3 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY
    Public key for perl-Error-0.17020-2.el7.noarch.rpm is not installed
    (1/4): perl-Error-0.17020-2.el7.noarch.rpm                 |  32 kB   00:00     
    (2/4): perl-TermReadKey-2.30-20.el7.x86_64.rpm             |  31 kB   00:00     
    Public key for perl-Git-1.8.3.1-6.el7_2.1.noarch.rpm is not installed --:-- ETA 
    (3/4): perl-Git-1.8.3.1-6.el7_2.1.noarch.rpm               |  53 kB   00:05     
    (4/4): git-1.8.3.1-6.el7_2.1.x86_64.rpm                    | 4.4 MB   00:10     
    --------------------------------------------------------------------------------
    Total                                              452 kB/s | 4.5 MB  00:10     
    Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    Importing GPG key 0xF4A80EB5:
     Userid     : "CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>"
     Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5
     Package    : centos-release-7-2.1511.el7.centos.2.10.x86_64 (@anaconda)
     From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    Is this ok [y/N]: y
    Running transaction check
    Running transaction test
    Transaction test succeeded
    Running transaction
      Installing : 1:perl-Error-0.17020-2.el7.noarch                            1/4 
      Installing : perl-TermReadKey-2.30-20.el7.x86_64                          2/4 
      Installing : git-1.8.3.1-6.el7_2.1.x86_64                                 3/4 
      Installing : perl-Git-1.8.3.1-6.el7_2.1.noarch                            4/4 
      Verifying  : perl-Git-1.8.3.1-6.el7_2.1.noarch                            1/4 
      Verifying  : perl-TermReadKey-2.30-20.el7.x86_64                          2/4 
      Verifying  : 1:perl-Error-0.17020-2.el7.noarch                            3/4 
      Verifying  : git-1.8.3.1-6.el7_2.1.x86_64                                 4/4 

    Installed:
      git.x86_64 0:1.8.3.1-6.el7_2.1                                                

    Dependency Installed:
      perl-Error.noarch 1:0.17020-2.el7       perl-Git.noarch 0:1.8.3.1-6.el7_2.1  
      perl-TermReadKey.x86_64 0:2.30-20.el7  

    Complete!
    root@yura:~/linux-webdev/bin/homework_02]# logout
    dagui@yura:~]$

# 스터디 하드 repository 다운로드

GitHub에서 다운로드 한다.

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

# 숙제 환경 생성

2주차 숙제 작업 폴더로 이동한다.

    dagui@yura:~]$ cd linux-webdev/
    dagui@yura:~/linux-webdev]$ ls
    README.md  SCHEDULE.md  TOC.md  bin  cgi-bin  images  src
    dagui@yura:~/linux-webdev]$ cd bin
    dagui@yura:~/linux-webdev/bin]$ ls
    homework_01.sh  homework_02
    dagui@yura:~/linux-webdev/bin]$ cd homework_02/
    dagui@yura:~/linux-webdev/bin/homework_02]$ ls
    Makefile
    dagui@yura:~/linux-webdev/bin/homework_02]$

make를 쳐보면 콩글리시로 도움말이 나온다.

    dagui@yura:~/linux-webdev/bin/homework_02]$ make
    Study Hard: Linux homework_02

    make init	Download and extract example archive.
    make check	Check wheather all the problems are resolved.
    make submit	Submit homework. (If you get pass 'make check'.)

    make clean	Clean work directory.
    make distclean	Clean work directory and also clean downloaded files.

    dagui@yura:~/linux-webdev/bin/homework_02]$ 

make init 을 쳐보면 숙제 파일을 다운로드 받는다.

    dagui@yura:~/linux-webdev/bin/homework_02]$ make init
    rm -rf soo jin jin.md5 soo.md5
    mkdir -p data
    curl -o data/broken.zip http://studyhard.yidigun.com/dist/broken.zip
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100  185M  100  185M    0     0  2481k      0  0:01:16  0:01:16 --:--:-- 2491k
    unzip -q data/broken.zip
    dagui@yura:~/linux-webdev/bin/homework_02]$ ls
    Makefile  data  jin  soo
    dagui@yura:~/linux-webdev/bin/homework_02]$

# 숙제 내용은 2개의 폴더를 동기화 하는 것

숙제 파일은 soo 와 jin 2개의 폴더인데 원래는 동기화 되어 있어야 정상이지만,
어떤 이유료(숙제를 내기위해) 동기화 시스템이 문제가 있어서 없는 파일이 있다.
soo 에 있는 파일이 jin에 있으 수도 있고, 반대로 jin에 있는 파일이 soo에 있을 수도 있다.

    dagui@yura:~/linux-webdev/bin/homework_02]$ ls -l jin
    합계 4
    drwxrwxr-x. 4 dagui dagui   36  1월 31  2013 20130131
    drwxrwxr-x. 3 dagui dagui   19  4월  3  2013 20130403
    drwxrwxr-x. 3 dagui dagui   17  7월 18  2013 20130718
    ...
    drwxr-xr-x. 3 dagui dagui   45 12월  1  2014 20141201
    drwxr-xr-x. 3 dagui dagui   82 12월 30  2014 20141230
    dagui@yura:~/linux-webdev/bin/homework_02]$ ls -l soo
    합계 4
    drwxrwxr-x. 4 dagui dagui   36  1월 31  2013 20130131
    drwxrwxr-x. 3 dagui dagui   19  4월  3  2013 20130403
    drwxrwxr-x. 3 dagui dagui   17  7월 18  2013 20130718
    ....
    drwxr-xr-x. 3 dagui dagui   45 12월  1  2014 20141201
    drwxr-xr-x. 3 dagui dagui   82 12월 30  2014 20141230
    dagui@yura:~/linux-webdev/bin/homework_02]$ 

# 검사하고 제출하는 방법

일단 make check 를 입력해서 검사를 해본다. 당연히 실패할 것이다.

    dagui@yura:~/linux-webdev/bin/homework_02]$ make check
    curl -o data/merged.md5 http://studyhard.yidigun.com/dist/merged.md5
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100 47212  100 47212    0     0   684k      0 --:--:-- --:--:-- --:--:--  688k
    rm -f jin.md5 soo.md5
    rm -rf soo jin jin.md5 soo.md5
    unzip -q data/broken.zip
    (cd jin; find . -type f -exec md5sum {} \; | sort ) >jin.md5
    (cd soo; find . -type f -exec md5sum {} \; | sort ) >soo.md5
    Files jin.md5 and soo.md5 differ
    Dir soo and jin is still different. 1st step: FAIL
    2nd step: FAIL
    dagui@yura:~/linux-webdev/bin/homework_02]$ 

숙제는 이 두 폴더를 동기화시켜서 check 에 2단계 모두 PASS를 받는 것이다.

동기화는 성공했지만 원래 있던 파일이 없어진 경우

    dagui@yura:~/linux-webdev/bin/homework_02]$ make check
    rm -f jin.md5 soo.md5
    (cd jin; find . -type f -exec md5sum {} \; | sort ) >jin.md5
    (cd soo; find . -type f -exec md5sum {} \; | sort ) >soo.md5
    You have synchronized soo and jin. 1st step: PASS
    Files data/merged.md5 and jin.md5 differ
    2nd step: NOT PASS
    dagui@yura:~/linux-webdev/bin/homework_02]$ 

성공한 경우

    dagui@yura:~/linux-webdev/bin/homework_02]$ make check
    rm -f jin.md5 soo.md5
    (cd jin; find . -type f -exec md5sum {} \; | sort ) >jin.md5
    (cd soo; find . -type f -exec md5sum {} \; | sort ) >soo.md5
    You have synchronized soo and jin. 1st step: PASS
    Congraturation! 2nd step: PASS
    dagui@yura:~/linux-webdev/bin/homework_02]$ 

make submit 으로 숙제를 제출한다.

    dagui@yura:~/linux-webdev/bin/homework_02]$ make submit
    Enter your e-mail: dklee@interpark.com
    It it correct? (dklee@interpark.com) [y/N] y
    Thanks for your submission: jin.md5
    Thanks for your submission: soo.md5
    dagui@yura:~/linux-webdev/bin/homework_02]$ 

작업하다 망했을 경우 make init 을 쳐서 처음부터 다시 시작할 수 있다.

    studyhard@inna:~/linux-webdev/bin/homework_02]$ make init
    rm -rf soo jin jin.md5 soo.md5
    unzip -q data/broken.zip
    studyhard@inna:~/linux-webdev/bin/homework_02]$ 



