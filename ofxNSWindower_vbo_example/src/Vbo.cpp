/*
 *  Vbo.cpp
 *  ofxNSWindower_vbo_example
 *
 *  Created by Will Gallia on 24/05/2012.
 *  Copyright 2012 . All rights reserved.
 *
 */

#include "Vbo.h"

static const ofIndexType Faces[] = {
	2, 1, 0,
	3, 2, 0,
	4, 3, 0,
	5, 4, 0,
	1, 5, 0,
	11, 6,  7,
	11, 7,  8,
	11, 8,  9,
	11, 9,  10,
	11, 10, 6,
	1, 2, 6,
	2, 3, 7,
	3, 4, 8,
	4, 5, 9,
	5, 1, 10,
	2,  7, 6,
	3,  8, 7,
	4,  9, 8,
	5, 10, 9,
	1, 6, 10 
};

static const float Verts[] = {
	0.000f,  0.000f,  1.000f,
	0.894f,  0.000f,  0.447f,
	0.276f,  0.851f,  0.447f,
	-0.724f,  0.526f,  0.447f,
	-0.724f, -0.526f,  0.447f,
	0.276f, -0.851f,  0.447f,
	0.724f,  0.526f, -0.447f,
	-0.276f,  0.851f, -0.447f,
	-0.894f,  0.000f, -0.447f,
	-0.276f, -0.851f, -0.447f,
	0.724f, -0.526f, -0.447f,
	0.000f,  0.000f, -1.000f 
};




Vbo::Vbo() {
	
	int i, j = 0;
	for ( i = 0; i < 12; i++ )
	{
		
		c[i].r = ofRandom(1.0);
		c[i].g = ofRandom(1.0);
		c[i].b = ofRandom(1.0);
		
		v[i][0] = Verts[j] * 100.f;
		j++;
		v[i][1] = Verts[j] * 100.f;
		j++;
		v[i][2] = Verts[j] * 100.f;
		j++;
		
	}
	
	vbo.setVertexData( &v[0], 12, GL_STATIC_DRAW );
	vbo.setColorData( &c[0], 12, GL_STATIC_DRAW );
	vbo.setIndexData( &Faces[0], 60, GL_STATIC_DRAW );
	
	glEnable(GL_DEPTH_TEST);
}

void Vbo::draw(){

	vbo.drawElements( GL_TRIANGLES, 60);
}

void Vbo::changeColour() {

	for (int i = 0; i < 12; i++) {
		c[i].r = ofRandom(1.0);
		c[i].g = ofRandom(1.0);
		c[i].b = ofRandom(1.0);
	}
	vbo.setColorData( &c[0], 12, GL_STATIC_DRAW );

}