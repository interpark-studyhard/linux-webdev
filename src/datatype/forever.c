#include <stdio.h>
#include <stdbool.h>

#include <unistd.h>

const char* FOREVER_LYRICS[];
const int FOREVER_LYRICS_LEN;

int main(int argc, char** argv) {
	
	pid_t pid = getpid();
	int i = 0;

	printf("My pid is: %d\n", pid);

	while (true) {

		sleep(1);

		printf("%s\n", FOREVER_LYRICS[i++]);

		if (i >= FOREVER_LYRICS_LEN)
			i = 0;
	}

	return 0;
}


const char* FOREVER_LYRICS[] = {
	"",
	"Forever",
	"- Stratovarius",
	"",
	"I stand alone in the darkness, the winter of my life came so fast",
	"Memories go back to childhood today I still recall",
	"Oh how happy I was then, there was no sorrow, there was no pain",
	"Walking through the green fields, sunshine's in my eyes",
	"",
	"I'm still there everywhere, I'm the dust in the wind",
	"I'm the star in the Northern sky",
	"I never stayed anywhere, I'm the wind in the trees",
	"Would you wait for me forever ?",
	"",
	"Oh yeah, oh yeah",
	"",
	"I'm still there everywhere, I'm the dust in the wind",
	"I'm the star in the northern sky",
	"I never stayed anywhere, I'm the wind in the trees",
	"Would you wait for me forever?",
};

const int FOREVER_LYRICS_LEN = sizeof(FOREVER_LYRICS) / sizeof(char**);
