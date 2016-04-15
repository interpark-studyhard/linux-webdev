#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char** argv) {

	pid_t pid = fork();

	if (pid == 0) {

		printf("This is child process: %d\n", pid);
		return 0;
	}
	else if (pid > 0) {

		printf("This is parent process: %d\n", pid);
		return 0;
	}
	else {
		perror("fork() failed");
		return 1;
	}
}
