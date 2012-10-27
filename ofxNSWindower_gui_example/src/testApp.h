
#pragma once

#include "ofMain.h"
#include "ofxNSWindowApp.h"

class testApp : public ofxNSWindowApp {

public:
	testApp() {}
	~testApp() { cout << "test app deconstructed" << endl; }
	
	void setup();
	void update();
	void draw();
	void close();
	
	void keyPressed(int key);
	void keyReleased(int key);
	
	void mouseMoved(int x, int y);
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased();
	void mouseReleased(int x, int y, int button);
	
	void mouseScrolled(float x, float y);
	
	
	ofTrueTypeFont font;
	ofVec2f pos;
	int colcounter;
	bool colflip;
	
	string text;
	float speed;
	
	void setText(string t);
	void setSpeed(float s);
	
	
};