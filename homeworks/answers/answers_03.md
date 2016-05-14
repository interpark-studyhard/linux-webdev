# 3회차 숙제 해설

1회차 숙제 제출 파일을 복원하는 쉘 스크립트를 작성하시오.

숙제의 의도는 [diff](http://linux.die.net/man/1/diff) 의 역연산(inversion)인 [patch](http://linux.die.net/man/1/patch) 를 검색으로 찾아내는 것.


인데... 솔직히 난이도 조절에 실패했다는 것을 인정합니다.
문제는 `patch`가 이제는 잘 사용안되서 잊혀진 명령어가 되어가고 있다는 것.

## B. comm

    #!/bin/sh
    base=http://studyhard.yidigun.com/linux-webdev/homeworks/homework_01
    email=dklee@interpark.com
    hostname=yura

    patch=myscript-$$.patch
    curl -o $patch $base/$email/$hostname.patch

    files=`grep '^diff ' $patch | sed -e 's/^.*b\///'`
    for file in $files; do
        mkdir -p `dirname $file`
        comm -2 /etc/$file $patch >$file
    done
    rm -f $patch

이 방법은 관점에 따라서는 숙제를 해결했다고 볼 수도 있으나, 정확하게 일치하는 원본 파일이 없으면 복원이 불가능하다.
백업된 설정을 다운로드 받아서 복원한다는 숙제의 설정과는 맞지 않는다.

실행시켜보면 `comm: file 2 is not in sorted order` 라는 오류가 발생하는데, 원래 `comm` 명령은 미리 정렬된 두개의 파일에서 교집합을 찾는 명령이다.
정렬되지 않은 파일에 대해서 실행했다는 warning이라고 생각하면 될듯.

![교집합](http://cfile2.uf.tistory.com/image/123D65424FDAC68B2AAB90)

인터넷에 검색해 보면 `diff`의 반대는 `comm` 이라고 나온다고 하는데, 이는 올바른 이해라고 볼 수 없다.
`diff`는 기본적으로 입력 파일들이 정렬될 필요가 없다. 하지만 정렬된 파일에 대해서 `diff`를 사용한다면 차집합을 구할 수 있기는 하다.

![차집합](http://cfile7.uf.tistory.com/image/146C854B4FE6BB680F65FE)


## A. patch

    #!/bin/sh
    base=http://studyhard.yidigun.com/linux-webdev/homeworks/homework_01
    email=dklee@interpark.com
    hostname=yura

    curl $base/$email/$hostname.patch | patch -p1

patch 명령이 기본으로 설치되어있지 않다. 수동으로 설치해야 한다.

    $ su -
    # yum install patch

## S. sed

    #!bin/sh
    base=http://studyhard.yidigun.com/linux-webdev/homeworks/homework_01
    email=dklee@interpark.com
    hostname=yura

    patch=myscript-$$.patch
    curl -o $patch $base/$email/$hostname.patch

    nfiles=`grep -n '^diff ' $patch | sed -e 's/:.*b\//:/'`
    for nfile in $nfiles; do
        line=`echo $nfile | cut -d: -f1`
        file=`echo $nfile | cut -d: -f2`
        start=`expr $line + 3`

        mkdir -p `dirname $file`
        sed -e "1,${start}d" -e '/^diff /,$d' -e 's/^+//' $patch >$file
    done
    rm -f $patch

참고로 S 등급은 쉘성애자(Shell fetish)를 의미한다.

