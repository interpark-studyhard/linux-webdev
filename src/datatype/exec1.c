#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char** argv) {

   if (argc < 2) {
     fprintf(stderr, "usage: %s command [ args ... ]\n", argv[0]);
     exit(1);
   }

   pid_t pid = fork();
   if (pid < 0) {
     perror("fork error: ");
   }
   else if (pid == 0) {
     // child process
     int rs = execv(argv[1], argv+1);
     perror("exec error: ");
   }
   else {
     // parent process
     printf("PARENT: child %d created.\n", pid);

     int status = 0;
     waitpid(pid, &status, 0);
     printf("PARENT: child %d terminated: %d\n", pid, status);
   }
}

