/*
 *  Vbo.h
 *  ofxNSWindower_vbo_example
 *
 *  Created by Will Gallia on 24/05/2012.
 *  Copyright 2012 . All rights reserved.
 *
 */

#pragma once

#include "ofMain.h"

class Vbo {

public:
	Vbo();
	void draw();
	void changeColour();
	
	ofVec3f v[12];
	ofFloatColor c[12];
	ofVbo vbo;
};