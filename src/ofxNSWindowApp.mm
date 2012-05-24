/*
 *  ofxNSWindowApp.cpp
 *
 *  Created by Will Gallia on 20/04/2012.
 *  Copyright 2012 . All rights reserved.
 *
 */

#include "ofxNSWindowApp.h"

void ofxNSWindowApp::setWindowTitle(string title) {
	parent->setWindowTitle(title);
}

ofPoint	ofxNSWindowApp::getWindowPosition() { 
	return parent->getWindowPosition(); 
}

ofPoint	ofxNSWindowApp::getWindowSize(){ 
	return parent->getWindowSize(); 
}

int	ofxNSWindowApp::getWidth(){ 
	return (int) parent->getWindowSize().x; 
}

int	ofxNSWindowApp::getHeight(){ 
	return (int) parent->getWindowSize().y; 
}

ofRectangle ofxNSWindowApp::getFrame() { 
	return parent->getFrame();
}

float ofxNSWindowApp::getFrameRate() { 
	return parent->getFrameRate(); 
}

void ofxNSWindowApp::setFrameRate(float fr) { 
	parent->setFrameRate(fr);
}

int ofxNSWindowApp::getFrameNum() { 
	return parent->getFrameNum();
}

float ofxNSWindowApp::getRealFrameRate() {
	return parent->getRealFrameRate();
}

void ofxNSWindowApp::setWindowSize(int w, int h) {
	parent->setWindowSize(w, h);
}

void ofxNSWindowApp::setWindowPosition(int x, int y) {
	parent->setWindowPosition(x, y);
}

