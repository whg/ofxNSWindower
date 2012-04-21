/*
 *  ofxNSWindower.cpp
 *
 *  Created by Will Gallia on 15/04/2012.
 *  Copyright 2012 . All rights reserved.
 *
 */

#include "ofxNSWindower.h"

using namespace std;

ofxNSWindower::ofxNSWindower(float frameRate) {
	
//	[[OpenGLContext instance] context];
//	
//	Timer *timer = [[Timer alloc] init];
//	[timer setCallbackWithObject:this function:&ofxNSWindower::loop];
//	[timer startTimer: frameRate];
//
//	[timer release];
}

ofxNSWindower::~ofxNSWindower() {
	cout << "windower deconstrutor" << endl;
	for (map<string, ofxNSWindow*>::iterator it = windows.begin(); it != windows.end(); it++) {
		windows.erase(it);
	}
}


void ofxNSWindower::addWindow(ofxNSWindowApp *app, string name) {
	
	if (name == "") {
		string randomstring = ofToString((int) ofRandom(1000));
		windows[randomstring] = new ofxNSWindow(app);
	}
	else {
		windows[name] = new ofxNSWindow(app, name);
	}

	
}

void ofxNSWindower::loop() {

	for (map<string, ofxNSWindow*>::iterator it = windows.begin(); it != windows.end(); ++it) {

		[(*it).second->getView() renderLoop];

	}
	
	[[[OpenGLContext instance] context] flushBuffer];
	
}


////////////////////////////////////////////////////////////////////////

//implementation of Objective-C timer...
//is passed an ofxNSWindower object and a callback function
//fuck! i just realised that i could have hard coded it to call 
//the loop function of ofxNSWindower!!! damn!!!

//anyway, sets up a NSTimer to fire a C++ function

@implementation Timer

- (void) setCallbackWithObject: (ofxNSWindower*) obj function: (func) cb {
	callback = cb;
	object = obj;
}

- (void) startTimer: (float) frameRate {

		NSTimer *timer = [NSTimer timerWithTimeInterval: 1/frameRate
																		target:self 
																	selector:@selector(loop)
																	userInfo:nil 
																	 repeats:YES];
		
		
		[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
		
}

- (void) loop {
	(object->*callback)();
}

@end