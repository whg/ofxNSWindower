
#include "testApp.h"


void testApp::setup() {

	ofSetWindowShape(640, 480);

}

void testApp::update() {
	
	
}

void testApp::draw() {

	ofBackgroundHex(0xffffff);

	//draw all images side by side...
	ofSetHexColor(0xffffff);
	ofPushMatrix();
	int acc_width = 0;
	for (int i = 0; i < images.size(); i++) {
		images[i].draw(0, 0);
		ofTranslate(images[i].width, 0);
		acc_width+= images[i].width;
	}
	ofPopMatrix();
	
	//adjust width if we need to...
	if (ofGetWidth() < acc_width) {
		ofSetWindowShape(acc_width, ofGetHeight());
	}


	ofSetHexColor(0xff22ee);
	ofDrawBitmapString("drag and drop image(s) onto this window", 10, 10);

}

void testApp::dragEvent(ofDragInfo info) {
	
	images.clear();
	
	for (int i = 0; i < info.files.size(); i++) {
		images.push_back(ofImage());
		images.back().loadImage(info.files[i]);
		
		cout << info.files[i] << endl;
	}
	
	printf("dragged to position %3.1f, %3.1f\n", info.position.x, info.position.y);
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


