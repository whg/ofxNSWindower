
#pragma once

#include "ofMain.h"
#include "ofxNSWindowApp.h"

class graphicsExample : public ofxNSWindowApp {

public:
	graphicsExample() {}
	
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
	
	float 	counter;
	bool	bSmooth;
	
};