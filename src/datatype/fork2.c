#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include "starwars.h"

static void do_parent_job();
static void do_child_job();

int main(int argc, char** argv) {

	char ** name;
	pid_t pid = fork();
	pid_t mypid = 0;

	if (pid == 0) {
		do_parent_job();
		return 0;
	}
	else if (pid > 0) {
		do_child_job();
		return 0;
	}
	else {
		perror("fork() failed");
		return 1;
	}
}

static void do_parent_job() {

	pid_t mypid = getpid();

	printf("%s(%d): %s\n", PARENT_NAME, mypid, PARENT_SAYS);
}


static void do_child_job() {

	pid_t mypid = getpid();

	printf("%s(%d): %s\n", CHILD_NAME, mypid, CHILD_SAYS);
}
