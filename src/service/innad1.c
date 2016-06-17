#include <stdio.h>
#include <unistd.h>
#include <time.h>
#define FOREVER 1

char *sysdate();

int main(void) {

    while (FOREVER) {
        printf("%s: Inna Yoo is very beautiful woman.\n", sysdate());
        sleep(1);
    }

    return 0;
}

char *sysdate() {
    static char buf[1024];
    time_t t = time(NULL);
    strftime(buf, 1024, "%Y-%m-%d %H:%M:%S", localtime(&t));
    return buf;
}
