#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include "forever.h"
#include "starwars.h"

static void do_parent_job();
static void do_child_job();

int main(int argc, char** argv) {

	char ** name;
	pid_t pid = fork();

	if (pid == 0) {

		do_child_job();

		return 0;
	}
	else if (pid > 0) {

		do_parent_job();

		/* wait for child precess */
		int status = 0;
		waitpid(pid, &status, 0);

		if (WIFEXITED(status)) {
			printf("%s: %s(%d) died in peace: %d\n", PARENT_NAME, CHILD_NAME, pid, WEXITSTATUS(status));
		}
		else if (WIFSIGNALED(status)) {
			printf("%s: %s(%d) died by signal: %d", PARENT_NAME, CHILD_NAME, pid, WTERMSIG(status));
			if (WCOREDUMP(status)) {
				printf(", and core dumped.");
			}
			printf("\n");
		}

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

	printf("%s(%d): No", CHILD_NAME, mypid);
	fflush(stdout);

	while (TRUE) {
		sleep(1);
		printf("o");
		fflush(stdout);
	}
}
