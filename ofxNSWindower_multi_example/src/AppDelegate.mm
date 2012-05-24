
#import "AppDelegate.h"

@implementation AppDelegate


- (void) applicationDidFinishLaunching: (NSNotification*) notification {
	
	
	ofxNSWindower::instance()->addWindow(new graphicsExample(), "graphicsExample");
	ofxNSWindower::instance()->addWindow(new fontsExample(), "fontsExample");
	ofxNSWindower::instance()->addWindow(new movieExample(), "movieExample");
}

- (void) applicationWillTerminate: (NSNotification*) notification {
	ofxNSWindower::destroy();
}

@end
