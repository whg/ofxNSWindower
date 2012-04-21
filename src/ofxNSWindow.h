/*
 *  ofxNSWindow.h
 *
 *  Created by Will Gallia on 14/04/2012.
 *  Copyright 2012 . All rights reserved.
 *
 */

#pragma once

#include "ofMain.h"

#import "OpenGLView.h"
#import <Cocoa/Cocoa.h>

class ofxNSWindowApp;
class ofxNSWindow;
@class OpenGLView;

class ofxNSWindow {
	
public:
	ofxNSWindow() {}
	ofxNSWindow(ofxNSWindowApp *app, string name="", float frameRate=30);
	ofxNSWindow(ofxNSWindowApp *app, string name, ofRectangle frame, float frameRate);

	~ofxNSWindow();
	
	void initWindow(ofRectangle frame, ofxNSWindowApp *app);
	
	NSWindow* getWindow() { return window; }
	OpenGLView* getView() { return glview; }
	
	void setWindowTitle(string title);
	
	ofPoint	getWindowPosition() { return ofPoint(frame.x, frame.y); }
	ofPoint	getWindowSize(){ return ofPoint(frame.width, frame.height); }
	ofRectangle getFrame() { return frame; }
	
	void setPos(int x, int y) { [window setFrameOrigin:NSMakePoint(x, y)]; }
	
	float getFrameRate();
	void setFrameRate(float fr);
	int getFrameNum();
	
	void setWindowSize(int w, int h);
	void setWindowPosition(int x, int y);
	
private:
	
	ofRectangle frame;
	string name;
	float frameRate;
	
	NSWindow *window;
	OpenGLView *glview;
	
	ofxNSWindowApp *app;
	
};

