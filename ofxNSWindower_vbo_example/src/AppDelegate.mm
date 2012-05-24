
#import "AppDelegate.h"

@implementation AppDelegate


- (void) applicationDidFinishLaunching: (NSNotification*) notification {
	
	//fire up ofxNSWindower before you do anything else!!!
	ofxNSWindower::instance();
	
	//make the vbo
	vbo = new Vbo();
	
	//pass the vbo to the different windows...
	ofxNSWindower::instance()->addWindow(new testApp(vbo), "one");
	ofxNSWindower::instance()->addWindow(new testApp(vbo), "two");
	ofxNSWindower::instance()->addWindow(new testApp(vbo), "three");
	
}

- (void) applicationWillTerminate: (NSNotification*) notification {

	ofxNSWindower::destroy();
	delete vbo;
}


@end
