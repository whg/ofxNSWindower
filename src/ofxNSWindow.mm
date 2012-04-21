/*
 *  ofxNSWindow.mm
 *
 *  Created by Will Gallia on 14/04/2012.
 *  Copyright 2012 . All rights reserved.
 *
 */



#include "ofxNSWindow.h"


ofxNSWindow::ofxNSWindow(ofxNSWindowApp *app, string name, float frameRate):
name(name), frameRate(frameRate) {

	frame = ofRectangle(100, 500, 320, 240);
	
	initWindow(frame, app);
	setWindowTitle(name);
	
	//set the parent so we can gain information 
	//about the window from inside the app
	app->setParent(this);
}

//this is almost identical to the constructor above, i just wanted an optional frame argument
//and as far as i am aware you cant have default constructors for compound types
ofxNSWindow::ofxNSWindow(ofxNSWindowApp *app, string name, ofRectangle frame, float frameRate):
frame(frame), name(name), frameRate(frameRate) {
	
	initWindow(frame, app);
	setWindowTitle(name);
	

	//set the parent so we can gain information 
	//about the window from inside the app
	app->setParent(this);

}

void ofxNSWindow::initWindow(ofRectangle frame, ofxNSWindowApp *app) {
	
	NSRect nsframe = NSMakeRect(frame.x, frame.y, frame.width, frame.height);
	
	window = [[NSWindow alloc] initWithContentRect:nsframe 
																			 styleMask:NSTitledWindowMask
																				 backing:NSBackingStoreBuffered 
																					 defer:NO];
	
	[window setFrameTopLeftPoint:NSMakePoint(frame.x, frame.y)];
	
	glview = [[OpenGLView alloc] initWithFrame:nsframe :app];
		
	//display the window
	[window setContentView:glview];
	[window makeKeyAndOrderFront:nil];
	
}

ofxNSWindow::~ofxNSWindow() {
	cout << "destructed" << endl;
	[window release];
	[glview release];
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

void ofxNSWindow::setWindowSize(int w, int h) {

	[window setContentSize:NSMakeSize(w, h)];
//	[glview setFrameSize:NSMakeSize(w, h)];
	[glview setFrame:NSMakeRect(0, 0, w, h)];
	[glview prepareOpenGL];
}

void ofxNSWindow::setWindowPosition(int x, int y) {
	
	[window setFrameTopLeftPoint:NSMakePoint(x, y)];
}


