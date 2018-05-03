#import "AppDelegate.h"
#import <dlfcn.h>
#import <unistd.h>

void patch_setuid() {
    void* handle = dlopen("/usr/lib/libjailbreak.dylib", RTLD_LAZY);
    if (!handle) 
        return;

    // Reset errors
    dlerror();
    typedef void (*fix_setuid_prt_t)(pid_t pid);
    fix_setuid_prt_t ptr = (fix_setuid_prt_t)dlsym(handle, "jb_oneshot_fix_setuid_now");
    
    const char *dlsym_error = dlerror();
    if (dlsym_error) 
        return;

    ptr(getpid());
}

int main(int argc, char *argv[]) {
    @autoreleasepool
    {	
	if (access("/usr/lib/libjailbreak.dylib", F_OK) == 0)
		patch_setuid();
        if (!(setuid(0) == 0 && setgid(0) == 0))
        {
            NSLog(@"Failed Root, Exitting");
            exit(EXIT_FAILURE);
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
