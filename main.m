#import "AppDelegate.h"
#import <dlfcn.h>
#import <unistd.h>
#include <mach/mach.h>

mach_port_t kernel_task = 0;

void electra1131()
{
    void* handle = dlopen("/electra/libjailbreak.dylib", RTLD_LAZY);
    if (!handle) 
        return;

    dlerror();
    typedef void (*fix_setuid_prt_t)(pid_t pid);
    fix_setuid_prt_t ptr = (fix_setuid_prt_t)dlsym(handle,"jb_oneshot_fix_setuid_now");
    
    const char *dlsym_error = dlerror();
    if (dlsym_error) 
        return;

    ptr(getpid());
    host_get_special_port(mach_host_self(), -1, 4, &kernel_task);
    setuid(0);
    setgid(0);
    setuid(0);
    setgid(0);
}

int main(int argc, char *argv[])
{
    @autoreleasepool
    {	
        if (access("/electra/libjailbreak.dylib", F_OK) == 0)
            electra1131();
        if (!(setuid(0) == 0 && setgid(0) == 0))
        {
            NSLog(@"Failed Root, Exitting");
            exit(EXIT_FAILURE);
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
