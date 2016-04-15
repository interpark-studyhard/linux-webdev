#include <stdio.h>
#include <stdbool.h>

#include <unistd.h>
#include <sys/wait.h>

#include "starwars.h"

void parent_says() {

	pid_t mypid = getpid();

	printf("%s(pid=%d): %s\n", PARENT_NAME, mypid, PARENT_SAYS);
}

void child_says() {

	pid_t mypid = getpid();

	printf("%s(pid=%d): No", CHILD_NAME, mypid);
	fflush(stdout);

	while (true) {
		sleep(1);
		printf("o");
		fflush(stdout);
	}
}
