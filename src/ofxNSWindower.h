/*
 *  ofxNSWindower.h
 *
 *  Created by Will Gallia on 15/04/2012.
 *  Copyright 2012 . All rights reserved.
 *
 */

#pragma once

#include "ofxNSWindow.h"
#include "OpenGLContext.h"

#include <map>
#include <string>

class ofxNSWindowApp;

class ofxNSWindower {

public:
	ofxNSWindower() {}
	ofxNSWindower(float frameRate);
	
	~ofxNSWindower();
	
	void addWindow(ofxNSWindowApp *app, std::string name="");
	
private:
	
	void loop();
	
	std::map<std::string, ofxNSWindow*> windows;
	
};

typedef void (ofxNSWindower::*func)();


@interface Timer : NSObject { 
	func callback;
	ofxNSWindower *object;
}

- (void) setCallbackWithObject: (ofxNSWindower*) obj function: (func) cb;
- (void) startTimer: (float) frameRate;
- (void) loop;

@end