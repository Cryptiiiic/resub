#import "RootViewController.h"
#include <CoreFoundation/CoreFoundation.h>
#include <spawn.h>
#include <sys/stat.h>

static int run_substrate()
{
    if (access("/usr/bin/cynject", F_OK) == 0)
    {
        char *argv[] = { "exec", "/usr/bin/cynject", "1", "/Library/Frameworks/CydiaSubstrate.framework/Libraries/SubstrateLauncher.dylib",  NULL };
        pid_t pid;
        int stat;
        posix_spawn(&pid, "/bin/exec", NULL, NULL, argv, NULL);
        waitpid(pid, &stat, 0);
        return stat;
    }
    return 0;
}

static int run_substitute()
{
    if (access("/electra/inject_criticald", F_OK) == 0)
    {
        char *argv[] = { "inject_criticald", "1", "/electra/pspawn_payload.dylib",  NULL };
        pid_t pid;
        int stat;
        posix_spawn(&pid, "/electra/inject_criticald", NULL, NULL, argv, NULL);
        waitpid(pid, &stat, 0);
        return stat;
    }
    return 0;
}

static int run_respring()
{
    if(access("/usr/bin/ldrestart", F_OK) == 0)
    {
        char *argv[] = { "ldrestart",  NULL };
        pid_t pid;
        int stat;
        posix_spawn(&pid, "/usr/bin/ldrestart", NULL, NULL, argv, NULL);
        waitpid(pid, &stat, 0);
        return stat;
    }
    else
    {
        char *argv[] = { "killall", "-9", "SpringBoard",  NULL };
        pid_t pid;
        int stat;
        posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, argv, NULL);
        waitpid(pid, &stat, 0);
        return stat;
    }
}



@implementation RootViewController
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    run_substrate();
    run_substitute();
    run_respring();
}

    @end
