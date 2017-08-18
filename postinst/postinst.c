#include <CoreFoundation/CoreFoundation.h>
#include <spawn.h>
#include <sys/stat.h>

static int run_mv(char *path, char *cmd)
{
    char *args[] = {"/bin/mv", cmd, path, NULL};
    pid_t pid;
    int stat;
    posix_spawn(&pid, args[0], NULL, NULL, args, NULL);
    waitpid(pid, &stat, 0);
    return stat;
}

int main(int argc, char **argv, char **envp)
{
    if (geteuid() != 0) {
        printf("Failed Root, Quitting");
        return 1;
    }
    
    chown("/Applications/resub.app/resub", 0, 0);
    chmod("/Applications/resub.app/resub", 6755);
    
    run_mv("/Applications/resub.app/resub1", "/Applications/resub.app/resub");
    run_mv("/Applications/resub.app/resub", "/Applications/resub.app/re");
    run_mv("/Applications/resub.app/resub-app", "/Applications/resub.app/resub1");
    
    chown("/Applications/resub.app/resub", 0, 0);
    chmod("/Applications/resub.app/resub", 0755);
    
	return 0;
}
