
#include "fontsExample.h"


void fontsExample::setup() {
	
	testFont2.loadFont("cooperBlack.ttf", 52, true, true, true);
	
	
	setWindowSize(850, 250);
}

void fontsExample::update() {
		
}

void fontsExample::draw() {
	
	ofBackgroundHex(0xffffff);

	ofSetColor(0, 90, 60);
	ofFill();
		
	testFont2.drawString("Hello - I am bitmap", 15, 80);
	
	ofFill();
	testFont2.drawStringAsShapes("Hello - I am vector", 15, 160);
	ofNoFill();
	testFont2.drawStringAsShapes("Hello - I am vector", 15, 230);
	
}


void fontsExample::keyPressed(int key) { 

}

void fontsExample::keyReleased(int key) { 
	
}

void fontsExample::mouseMoved(int x, int y) { 
	
}

void fontsExample::mouseDragged(int x, int y, int button) {
	
}

void fontsExample::mousePressed(int x, int y, int button) { 
	
}

void fontsExample::mouseReleased() { 
	
}

void fontsExample::mouseReleased(int x, int y, int button ){ 
	
}

void fontsExample::mouseScrolled(float x, float y) { 
	
}


