/*
 *  ofxNSWindow.mm
 *
 *  Created by Will Gallia on 14/04/2012.
 *  Copyright 2012 . All rights reserved.
 *
 */



#include "ofxNSWindow.h"


ofxNSWindow::ofxNSWindow(ofxNSWindowApp *app, string name, int options, float frameRate):
name(name), frameRate(frameRate), isFullscreen(false) {

	frame = ofRectangle(100, 500, 320, 240);
	oframe = ofRectangle(100, 500, 320, 240); //used when we go fullscreen
	
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

    glview = [[OpenGLView alloc] initWithFrame:nsframe windowApp:app frameRate:frameRate];
	//setup and display the window
	
	[window setContentView:glview];
	[window makeKeyAndOrderFront:nil];
	[glview release];
	
	windowDelegate = [[WindowDelegate alloc] init];
	[windowDelegate setApp:app];
	[windowDelegate setView:[window contentView]];
	[window setDelegate:windowDelegate];
	[window setReleasedWhenClosed:YES];

	setWindowTitle(name);
}

void ofxNSWindow::setup() {
	[glview setup];
}

//windows should be close with the close button
ofxNSWindow::~ofxNSWindow() {
//	[[window contentView] release];
//	[window close];
//	[window release];
	[windowDelegate release];
}

void ofxNSWindow::showCursor() {
	[NSCursor unhide];
}

void ofxNSWindow::hideCursor() {
	[NSCursor hide];
}

void ofxNSWindow::setWindowTitle(string title) {
	
	NSString *nstitle = [NSString	stringWithUTF8String:title.c_str()];
	[window setTitle:nstitle];
}

string ofxNSWindow::getWindowTitle() {
	return string([[window title] UTF8String]);
}

float ofxNSWindow::getFrameRate() { 
	return [glview getRealFrameRate];
}

void ofxNSWindow::setFrameRate(float fr) { 
	[glview setFrameRate: fr]; 
}

int ofxNSWindow::getFrameNum() { 

	return [glview getFrameNum]; 
}

float ofxNSWindow::getSetFrameRate() {
	return [glview getFrameRate];
}

void ofxNSWindow::setWindowShape(int w, int h) {

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

void	ofxNSWindow::setFullscreen(bool fullscreen){
	
	
	if(fullscreen) {
		NSScreen *screen = [NSScreen mainScreen];
		[glview enterFullScreenMode:screen withOptions:nil];
		NSRect f = [screen frame];
		[glview setFrame:f];
		oframe = frame;
		frame.set(0, 0, f.size.width, f.size.height);
	}
	else {
		[glview exitFullScreenModeWithOptions:nil];
		[glview setFrame:NSMakeRect(0, 0, oframe.width, oframe.height)];
		frame = oframe;
	}

	[glview prepareOpenGL];
	[window makeFirstResponder:glview];

	isFullscreen = fullscreen;
}

void	ofxNSWindow::toggleFullscreen(){

	setFullscreen(!isFullscreen);
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

	return YES;
}


@end


