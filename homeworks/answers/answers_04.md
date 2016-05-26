# 4회차 숙제 해설

호스팅 고객들의 파일 접근권한을 잘 설정하여 개별 사용자들의 격리 공간을 만드시오.

진짜로 정답은 없는 문제인데, 무수히 많은 다양한 설정이 나올 수 있다.
다만 대략 아래 설명하는 방식중 한가지와 비슷할 것이다.

숙제의 의도는 잠깐 쉬어가는 페이지.

...는 훼이크고, 퍼미션 설정도 개발처럼 정책 - 설계 - 설정의 단계가 있다는 것을 설명하기 위함


## 1. forbidden group 정책

격리 대상자 그룹 `hosting`을 만들고, 그룹 권한을 제거한다.

    # groupadd hosting
    # usermod -G hosting crong
    # usermod -G hosting pororo
    # chown -R crong:crong crong
    # chown -R pororo:pororo pororo
    # chgrp hosting crong pororo
    # chmod g-rwx crong pororo
    # ls -Rl
    .:
    합계 0
    drwx---r-x. 2 crong  hosting 23  5월 18 02:34 crong
    drwx---r-x. 2 pororo hosting 23  5월 18 02:34 pororo
    
    ./crong:
    합계 4
    -rw-r--r--. 1 crong crong 250  5월 18 02:34 index.html
    
    ./pororo:
    합계 4
    -rw-r--r--. 1 pororo pororo 272  5월 18 02:34 index.html

rwx---r-x 가 좀 보기 안좋기는 하지만 잘 동작한다. 게다가 격리 대상자 그룹이 아닌 다른 그룹 소속 사용자들은
접근할 수 있기 때문에 나쁘지 않은 선택이라고 생각함. (이를테면 시스템 데몬이라던가..)

## 2. private group 정책

서비스 데몬용 그룹 `websvc`를 만들고, 서비스데몬 유저인 `apache`를 그룹에 추가한다.
각 사용자들의 폴더는 private으로 설정한다. 

    # groupadd websvc
    # usermod -G websvc apache
    # chown -R pororo:pororo pororo
    # chown -R crong:crong crong
    # chgrp websvc crong pororo
    # chmod o-rwx crong pororo
    # ls -Rl
    .:
    합계 0
    drwxr-x---. 2 crong  websvc 23  5월 18 02:34 crong
    drwxr-x---. 2 pororo websvc 23  5월 18 02:34 pororo
    
    ./crong:
    합계 4
    -rw-r--r--. 1 crong crong 250  5월 18 02:34 index.html
    
    ./pororo:
    합계 4
    -rw-r--r--. 1 pororo pororo 272  5월 18 02:34 index.html

RedHat 계열의 홈 디렉토리 기본 권한 설정이 바로 이 방식. 모든 사용자들이 격리 대상이 되고, 접근 가능해야할 서비스 데몬들을 관리해줘야한다. (1번 방식의 반대)

## 3. project group 정책

만약에 `pororo`의 부인 `petty`와 `crong`의 부인 `loopy`가 있다면, 그리고 부인들은 남편 홈페이지에 접근할 수 있어야한다면 어떨까?

`/var/www/html/pororo`는 `pororo`와 `petty`가 참여하는 프로젝트 `pj-pororo`의 작업 공간이라고 생각해야한다.

    # groupadd pj-pororo
    # useradd -G pj-pororo pororo
    # useradd -G pj-pororo petty

    # groupadd pj-crong
    # useradd -G pj-crong crong
    # useradd -G pj-crong loopy

    # for u in crong pororo; do
    >     chown -R $u:pj-$u $u
    >     chmod -R g+w $u
    >     find $u -type d -exec chmod g+s {} \;
    > done
    # ls -Rl
    .:
    합계 0
    drwxrwsr-x. 2 crong  pj-crong  39  5월 18 04:47 crong
    drwxrwsr-x. 2 pororo pj-pororo 39  5월 18 04:45 pororo
    
    ./crong:
    합계 8
    -rw-rw-r--. 1 crong pj-crong 250  5월 18 03:12 index.html
    -rw-rw-r--. 1 loopy pj-crong 254  5월 18 04:47 wife.html
    
    ./pororo:
    합계 8
    -rw-rw-r--. 1 pororo pj-pororo 273  5월 18 04:07 index.html
    -rw-rw-r--. 1 petty  pj-pororo 255  5월 18 04:45 wife.html

기본적인 project 설정은 마쳤다. 그런데 다른 프로젝트 그룹 사용자들을 접근 못하도록 차단해야 한다.

    # chmod o-rwx crong pororo
    # ls -Rl
    .:
    합계 0
    drwxrws---. 2 crong  pj-crong  39  5월 18 04:47 crong
    drwxrws---. 2 pororo pj-pororo 39  5월 18 04:45 pororo
    
    ./crong:
    합계 8
    -rw-rw-r--. 1 crong pj-crong 250  5월 18 03:12 index.html
    -rw-rw-r--. 1 loopy pj-crong 254  5월 18 04:47 wife.html
    
    ./pororo:
    합계 8
    -rw-rw-r--. 1 pororo pj-pororo 273  5월 18 04:07 index.html
    -rw-rw-r--. 1 petty  pj-pororo 255  5월 18 04:45 wife.html

좀 골치아픈 문제가 남았는데 `apache` 계정이 접근하도록 할 수가 없다.
만약 `apache`계정을 project group에 추가하면 쓰기 권한도 가져가게 되는 문제가 생긴다.

    # chown apache crong pororo
    # chmod u-w crong pororo
    # ls -lR
    .:
    합계 0
    dr-xrws---. 2 apache pj-crong  39  5월 18 04:47 crong
    dr-xrws---. 2 apache pj-pororo 39  5월 18 04:45 pororo
    
    ./crong:
    합계 8
    -rw-rw-r--. 1 crong pj-crong 250  5월 18 03:12 index.html
    -rw-rw-r--. 1 loopy pj-crong 254  5월 18 04:47 wife.html
    
    ./pororo:
    합계 8
    -rw-rw-r--. 1 pororo pj-pororo 273  5월 18 04:07 index.html
    -rw-rw-r--. 1 petty  pj-pororo 255  5월 18 04:45 wife.html

꼼수로 각 사이트 root의 소유권을 apache에게 주었다.(쓰기 권한은 제외하고)

RedHat의 project 그룹 개념을 적용한 사례. private / project 그룹 개념을 설명하기 위해서 억지로 만들어낸 설정임을 인정합니다.

## S.

참고로 S 등급은 쉘성애자(Shell fetish)를 의미하는데 이번주는 쉽니다.

