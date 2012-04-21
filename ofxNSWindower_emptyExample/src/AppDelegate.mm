
#import "AppDelegate.h"

@implementation AppDelegate


- (void) applicationDidFinishLaunching: (NSNotification*) notification {
	
	windower.addWindow(new testApp());

}

- (void) applicationWillTerminate: (NSNotification*) notification {

}

@end
