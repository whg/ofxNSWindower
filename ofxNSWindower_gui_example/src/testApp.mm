
#include "testApp.h"


void testApp::setup() {

	setWindowSize(800, 600);
	
	font.loadFont("Arial.ttf", 80, true, true, true);
	
	pos = ofVec2f(100, 300);
	
	text = "circa 1995";
	speed = 1;
	colcounter = 0;
	colflip = true;
}

void testApp::close() {

}

void testApp::update() {
	
	
}

void testApp::draw() {

	ofBackground(0, 0, 0);
	
	ofPushMatrix();
	ofTranslate(pos.x + getWindowSize().x/2, pos.y + getWindowSize().y/2, 0);

	for (int i = 0; i < 20; i++) {
		ofTranslate(0, 0, 5);
		ofRotateY(ofDegToRad(getFrameNum()*speed));
		ofRotateZ(ofDegToRad(getFrameNum()*speed*0.3));
		ofSetColor(colcounter, colcounter*2, 255-colcounter, 150);
		font.drawString(text, -font.stringWidth(text)/2, 0);
		
		
	}
	
	ofPopMatrix();
	
	pos.x = cos(ofDegToRad(getFrameNum()))*100;
	pos.y = sin(ofDegToRad(getFrameNum()))*100;
	
	colcounter+= (colflip ? 1 : -1);
	if (colcounter >= 255 || colcounter <= 0) {
		colflip = !colflip;
	}
	
}

void testApp::setText(string t) {
	text = t;
}

void testApp::setSpeed(float s) {
	speed = s;
}


void testApp::keyPressed(int key) { 

}

void testApp::keyReleased(int key) { 

}

void testApp::mouseMoved(int x, int y) { 

}

void testApp::mouseDragged(int x, int y, int button) {

}

void testApp::mousePressed(int x, int y, int button) { 

}

void testApp::mouseReleased() { 

}

void testApp::mouseReleased(int x, int y, int button ){ 

}

void testApp::mouseScrolled(float x, float y) { 

}


