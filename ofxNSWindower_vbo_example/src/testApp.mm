
#include "testApp.h"

testApp::testApp(Vbo *vbo) {
	this->vbo = vbo;
}

void testApp::setup() {

	ofSetWindowShape(400, 300);
	ofSetWindowPosition(ofRandom(400), 400);
	rotx = roty = 0;
}

void testApp::update() {
	
	
}

void testApp::draw() {
	
	glEnable(GL_DEPTH_TEST);

	ofBackground(0, 0, 0);
	
	ofPushMatrix();
	ofTranslate(ofGetWidth()/2, ofGetHeight()/2, 0);
	ofRotateX(rotx);
	ofRotateY(roty);

	vbo->draw();
	
	ofPopMatrix();
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

	vbo->changeColour();
}

void testApp::mouseReleased() { 

}

void testApp::mouseReleased(int x, int y, int button ){ 

}

void testApp::mouseScrolled(float x, float y) { 

	rotx+= y;
	roty-= x;
}


