#include <stdio.h>

#include <unistd.h>
#include <sys/wait.h>

#define PARENT_NAME "Darth Vader"
#define PARENT_SAYS "I'm your father."
#define CHILD_NAME "Luke Skywalker"
#define CHILD_SAYS "Noooooooooooooooooooooo!"

static void parent_job();
static void child_job();

int main(int argc, char** argv) {

	char ** name;
	pid_t pid = fork();
	pid_t mypid = 0;

	if (pid == 0) {
		child_job();
		return 0;
	}
	else if (pid > 0) {
		parent_job();
		return 0;
	}
	else {
		perror("fork() failed");
		return 1;
	}
}

static void parent_job() {

	pid_t mypid = getpid();

	printf("%s(pid=%d): %s\n", PARENT_NAME, mypid, PARENT_SAYS);
}

static void child_job() {

	pid_t mypid = getpid();

	printf("%s(pid=%d): %s\n", CHILD_NAME, mypid, CHILD_SAYS);
}
