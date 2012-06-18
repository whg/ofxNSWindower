/*
 *  ofxNSWindow.h
 *
 *  Created by Will Gallia on 14/04/2012.
 *  Copyright 2012 . All rights reserved.
 *
 */

#pragma once

#include "ofMain.h"
#include "ofxNSWindower.h"

#import "OpenGLView.h"
#import <Cocoa/Cocoa.h>

class ofxNSWindowApp;
class ofxNSWindow;
class ofxNSWindower;
@class OpenGLView;
@class WindowDelegate;

class ofxNSWindow {
	
public:
	ofxNSWindow() {}
	ofxNSWindow(ofxNSWindowApp *app, string name="", int options=NSTitledWindowMask, float frameRate=30);

	~ofxNSWindow();
		
	NSWindow* getWindow() { return window; }
	OpenGLView* getView() { return glview; }
	ofxNSWindowApp* getApp() { return app; }
	
	void setWindowTitle(string title);
	
	ofPoint	getWindowPosition() { return ofPoint(frame.x, frame.y); }
	ofPoint	getWindowSize(){ return ofPoint(frame.width, frame.height); }
	ofRectangle getFrame() { return frame; }
	
	void setPos(int x, int y) { [window setFrameOrigin:NSMakePoint(x, y)]; }
	
	float getFrameRate();
	void setFrameRate(float fr);
	int getFrameNum();
	float getRealFrameRate();
	
	void setWindowSize(int w, int h);
	void setWindowPosition(int x, int y);
    	
private:
	
	ofRectangle frame;
	string name;
	float frameRate;
	
	NSWindow *window;
	OpenGLView *glview;
	
	WindowDelegate *windowDelegate;
	
	ofxNSWindowApp *app;
	
};


/////////////////////////////////////////////////
//window delegate to handle close events

@interface WindowDelegate : NSObject<NSWindowDelegate> { 
	ofxNSWindowApp *app;
	OpenGLView *view;
}

@property (assign) ofxNSWindowApp* app;
@property (retain) OpenGLView* view;

- (BOOL) windowShouldClose: (id) sender;

@end

