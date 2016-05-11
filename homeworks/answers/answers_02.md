# 2회차 숙제 해설

soo 와 jin 폴더의 내용을 동기화할것.

숙제의 의도는 [rsync](http://linux.die.net/man/1/rsync) 를 검색으로 찾아내는 것.

## B. cp

    $ cd jin
    jin]$ cp -r ../soo/* .
    jin]$ cd ../soo
    soo]$ cp -r ../jin/* .

이 방법은 숙제 정도는 해결할 수 있으나 실전에서는 사용하기 힘든데, 용량과 파일 수가 많아질 수록 엄청난 시간이 걸릴 것이기 때문이다.

## A. rsync

    $ rsync -r soo/ jin/
    $ rsync -r jin/ soo/

## S. diff

    $ make check
    $ for f in `diff -u jin.md5 soo.md5 | grep '^+' | sed -e '1d' -e 's/^.*\.\///'`; do (cd jin; cp ../soo/$f $f); done
    $ for f in `diff -u jin.md5 soo.md5 | grep '^-' | sed -e '1d' -e 's/^.*\.\///'`; do (cd soo; cp ../jin/$f $f); done

참고로 S 등급은 쉘성애자(Shell fetish)를 의미한다.

