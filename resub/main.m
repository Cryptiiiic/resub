#import "AppDelegate.h"

int main(int argc, char *argv[]) {
    @autoreleasepool
    {
        if (!(setuid(0) == 0 && setgid(0) == 0))
        {
            NSLog(@"Failed Root, Exitting");
            exit(EXIT_FAILURE);
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
