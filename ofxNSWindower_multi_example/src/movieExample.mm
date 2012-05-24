
#include "movieExample.h"


void movieExample::setup() {
	
	frameByframe = false;
	
	fingerMovie.loadMovie("fingers.mov");
	fingerMovie.play();
	
	setWindowSize(fingerMovie.width, fingerMovie.height*2);
}

void movieExample::update() {
	fingerMovie.idleMovie();

}

void movieExample::draw() {
	
	ofBackgroundHex(0xffffff);
	
	ofSetHexColor(0xFFFFFF);
	
	fingerMovie.draw(0, 0);
	
	ofSetHexColor(0x000000);
	ofFill();
	unsigned char * pixels = fingerMovie.getPixels();
	// let's move through the "RGB" char array
	// using the red pixel to control the size of a circle.
	for (int i = 4; i < 320; i+=8){
		for (int j = 4; j < 240; j+=8){
			unsigned char r = pixels[(j * 320 + i)*3];
			float val = 1 - ((float)r / 255.0f);
			ofCircle(i, j+fingerMovie.height, 10*val);
		}
	}
}


void movieExample::keyPressed(int key) { 
	
}

void movieExample::keyReleased(int key) { 
	
}

void movieExample::mouseMoved(int x, int y) { 
	
}

void movieExample::mouseDragged(int x, int y, int button) {
	
}

void movieExample::mousePressed(int x, int y, int button) { 
	
}

void movieExample::mouseReleased() { 
	
}

void movieExample::mouseReleased(int x, int y, int button ){ 
	
}

void movieExample::mouseScrolled(float x, float y) { 
	
}

