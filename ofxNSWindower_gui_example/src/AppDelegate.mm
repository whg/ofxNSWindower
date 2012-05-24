
#import "AppDelegate.h"

@implementation AppDelegate


- (void) applicationDidFinishLaunching: (NSNotification*) notification {
	
	
	ofxNSWindower::instance()->addWindow(new testApp(), "saver", NSTitledWindowMask, 0);

}

- (void) applicationWillTerminate: (NSNotification*) notification {

	ofxNSWindower::destroy();
}


@end
