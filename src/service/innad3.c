#include <stdio.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#define FOREVER 1

char *config = "innad.cfg";
char *output = "innad.log";

char *msg = NULL;
FILE *out = NULL;

void read_config();
void open_out();
void service();
void finalize();
char *sysdate();

int main(void) {

    pid_t pid = fork();
    if (pid < 0) {
        perror("fork #1 error");
        exit(1);
    }
    else if (pid > 0) {
        // parent shutdown immediately 
        exit(0);
    }
    else {
        pid_t sid = setsid();
        fclose(stdout);
        fclose(stderr);
        fclose(stdin);

        read_config();
        open_out();
        service();
        finalize();
    }

    return 0;
}

void read_config() {

    FILE *fp = fopen(config, "r");
    char buf[1024];
    fgets(buf, 1024, fp);
    fclose(fp);
    buf[strcspn(buf, "\n")] = '\0';

    if (msg != NULL)
        free(msg);
    msg = (char*)malloc(strlen(buf) + 1);
    strcpy(msg, buf);
}

void open_out() {
    if (out != NULL)
        fclose(out);
    out = fopen(output, "a");
}

void service() {

    while (FOREVER) {
        fprintf(out, "%s: %s\n", sysdate(), msg);
        fflush(out);
        sleep(1);
    }
}

void finalize() {
    if (msg != NULL)
        free(msg);
    if (out != NULL)
        fclose(out);
}

char *sysdate() {
    static char buf[1024];
    time_t t = time(NULL);
    strftime(buf, 1024, "%Y-%m-%d %H:%M:%S", localtime(&t));
    return buf;
}
