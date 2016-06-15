#include <stdio.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#define FOREVER 1

char *config = "/etc/innasrv.cfg";
char *output = "/var/log/innasrv.log";

char *msg = NULL;
FILE *out = NULL;

void read_config();
void open_out();
void service();
void finalize();
char *sysdate();

void sig_hup_handler(int signo) {
    read_config();
    open_out();
}
void sig_term_handler(int signo) {
    finalize();
    exit(0);
}

int main(void) {
    signal(SIGHUP, (void*)sig_hup_handler);
    signal(SIGTERM, (void*)sig_term_handler);
    signal(SIGINT, (void*)sig_term_handler);

    read_config();
    open_out();
    service();
    finalize();

    return 0;
}

void service() {
    while (FOREVER) {
        fprintf(out, "%s: %s\n", sysdate(), msg);
        fflush(out);
        sleep(1);
    }
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
