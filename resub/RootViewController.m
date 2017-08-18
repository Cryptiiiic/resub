#import "RootViewController.h"
#include <CoreFoundation/CoreFoundation.h>
#include <spawn.h>
#include <sys/stat.h>

static int run_substrate()
{
    const char *args[] = {"/etc/rc.d/substrate", NULL};
    pid_t pid;
    int stat;
    posix_spawn(&pid, args[0], NULL, NULL, (char **) args, NULL);
    waitpid(pid, &stat, 0);
    return stat;
}

static int run_respring(const char *path, const char *cmd)
{
    const char *args[] = {"/usr/bin/killall", cmd, path, NULL};
    pid_t pid;
    int stat;
    posix_spawn(&pid, args[0], NULL, NULL, (char **) args, NULL);
    waitpid(pid, &stat, 0);
    return stat;
}



@implementation RootViewController
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    run_substrate();
    run_respring("SpringBoard", "-9");
}

    @end
