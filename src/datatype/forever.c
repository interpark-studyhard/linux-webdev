#include <stdio.h>
#include <unistd.h>
#include "forever.h"

int main(int argc, char** argv) {
	
	pid_t pid = getpid();
	int i = 0;

	printf("My pid is: %d\n", pid);

	while (TRUE) {

		sleep(1);

		printf("%s\n", FOREVER_LYRICS[i++]);

		if (i >= FOREVER_LYRICS_LEN)
			i = 0;
	}

	return 0;
}
