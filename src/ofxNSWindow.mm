/*
 *  ofxNSWindow.mm
 *
 *  Created by Will Gallia on 14/04/2012.
 *  Copyright 2012 . All rights reserved.
 *
 */



#include "ofxNSWindow.h"


ofxNSWindow::ofxNSWindow(ofxNSWindowApp *app, string name, int options, float frameRate):
name(name), frameRate(frameRate) {

	frame = ofRectangle(100, 500, 320, 240);
	
	//set the parent so we can gain information 
	//about the window from inside the app
	app->setParent(this);
	this->app = app;
	
	//create the window...
	NSRect nsframe = NSMakeRect(frame.x, frame.y, frame.width, frame.height);
	
	window = [[NSWindow alloc] initWithContentRect:nsframe 
																			 styleMask:options
																				 backing:NSBackingStoreBuffered 
																					 defer:NO];
	
	[window setFrameTopLeftPoint:NSMakePoint(frame.x, frame.y)];

	glview = [[OpenGLView alloc] initWithFrame:nsframe :app :frameRate];
	
	windowDelegate = [[WindowDelegate alloc] init];
	[windowDelegate setApp:app];
	[windowDelegate setView:glview];
	[window setDelegate:windowDelegate];
	
	
	//setup and display the window

	[window setContentView:glview];
	[glview setup];
	[window makeKeyAndOrderFront:nil];
	
	
	setWindowTitle(name);
	
}


ofxNSWindow::~ofxNSWindow() {
	[window release];
	[glview release];
	[windowDelegate release];
}

void ofxNSWindow::setWindowTitle(string title) {
	
	NSString *nstitle = [NSString	stringWithUTF8String:title.c_str()];
	[window setTitle:nstitle];
}

float ofxNSWindow::getFrameRate() { 
	return [glview getFrameRate]; 
}

void ofxNSWindow::setFrameRate(float fr) { 
	[glview setFrameRate: fr]; 
}

int ofxNSWindow::getFrameNum() { 

	return [glview getFrameNum]; 
}

float ofxNSWindow::getRealFrameRate() {
	return [glview getRealFrameRate];
}

void ofxNSWindow::setWindowSize(int w, int h) {

	[window setContentSize:NSMakeSize(w, h)];
	[glview setFrame:NSMakeRect(0, 0, w, h)];
	[glview prepareOpenGL];
	
	frame.width = w;
	frame.height = h;
}

void ofxNSWindow::setWindowPosition(int x, int y) {
	
	[window setFrameTopLeftPoint:NSMakePoint(x, y)];
	frame.x = x;
	frame.y = y;
}

//////////////////////////////////////////////////////////////
//NSWindow delegate implementation for close events

@implementation WindowDelegate

@synthesize app;
@synthesize view;


- (BOOL) windowShouldClose: (id) sender {

	[view eraseTimer];
	app->close();

	ofxNSWindower::instance()->deleteWindow(app);

	return NO;
}


@end


