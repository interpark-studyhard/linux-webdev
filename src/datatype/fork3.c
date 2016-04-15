#include <stdio.h>

#include <unistd.h>
#include <sys/wait.h>

#include "starwars.h"

int main(int argc, char** argv) {

	char ** name;
	pid_t pid = fork();

	if (pid == 0) {

		child_says();

		return 0;
	}
	else if (pid > 0) {

		parent_says();

		/* wait for child precess */
		int status = 0;
		waitpid(pid, &status, 0);

		if (WIFEXITED(status)) {
			printf("%s: %s(pid=%d) died in peace: %d\n", PARENT_NAME, CHILD_NAME, pid, WEXITSTATUS(status));
		}
		else if (WIFSIGNALED(status)) {
			printf("%s: %s(pid=%d) died by signal: %d", PARENT_NAME, CHILD_NAME, pid, WTERMSIG(status));
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
