
#pragma once

#include "ofMain.h"
#include "ofxNSWindowApp.h"

class fontsExample : public ofxNSWindowApp {
	
public:
	fontsExample() {}
	
	void setup();
	void update();
	void draw();
	
	void keyPressed(int key);
	void keyReleased(int key);
	
	void mouseMoved(int x, int y);
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased();
	void mouseReleased(int x, int y, int button);
	
	void mouseScrolled(float x, float y);
	
	ofTrueTypeFont testFont2;
	
};