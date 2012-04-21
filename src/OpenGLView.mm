//
//  OpenGLView.m
//
//  Created by Will Gallia on 14/04/2012.
//  Copyright 2012 . All rights reserved.
//

#import "OpenGLView.h"

#include <OpenGL/OpenGL.h>


@implementation OpenGLView


- (id) initWithFrame: (NSRect) frame: (ofxNSWindowApp*) app {
	
	windowApp = app;
	[self initWithFrame:frame];
}


- (id) initWithFrame: (NSRect)frame {
	
	self = [super initWithFrame:frame];
	
	if (self) {
		
		pixelFormat = [[OpenGLContext instance] pixelFormat];
		
		if (pixelFormat == nil) {
			NSLog(@"OpenGLView: no pixel format");
		}
	}
	
	//we need to do this to enable mouseMoved events
	NSTrackingArea *trackingArea;
	trackingArea = [[NSTrackingArea alloc] initWithRect:frame
																							options:NSTrackingMouseMoved | NSTrackingInVisibleRect | NSTrackingActiveInKeyWindow
																								owner:self
																						 userInfo:nil];
	
	[self addTrackingArea:trackingArea];
	[trackingArea release];
	
	setupCalled = FALSE;
	
	frameRate = 30;
	[self startTimer];
	
	context = nil;
	return self;
}

- (void) setApp: (ofxNSWindowApp*) app {
	windowApp = app;
}

//returns pointer to shared GL context
- (NSOpenGLContext*) openGLContext {
	
	if (context == nil) {
		
		context = [[NSOpenGLContext alloc] initWithFormat:pixelFormat 
																				 shareContext:[[OpenGLContext instance] context]];
		
		if (context == nil) {
			NSLog(@"OpenGLView: can't create context");
		}
	}
	
	
	
	return context;
}

- (void) prepareOpenGL {
	
	//really basic OpenGL initialisation...
	glViewport(0, 0, (GLsizei) self.frame.size.width, (GLsizei) self.frame.size.height);
	
	//this is taken from oF's ofGLRenderer::setupScreenPerspective()
		
	float viewW = self.frame.size.width;
	float viewH = self.frame.size.height;
	
	float fov = 60;
	float eyeX = viewW / 2;
	float eyeY = viewH / 2;
	float halfFov = PI * fov / 360;
	float theTan = tanf(halfFov);
	float dist = eyeY / theTan;
	float aspect = (float) viewW / viewH;
	
	float nearDist = dist / 10.0f;
	float farDist = dist * 10.0f;
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(fov, aspect, nearDist, farDist);
	
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(eyeX, eyeY, dist, eyeX, eyeY, 0, 0, 1, 0);
	
	//put the origin in the top left corner...
	glScalef(1, -1, 1);
	glTranslatef(0, -self.frame.size.height, 0);
	

	[[self openGLContext] update];
}

- (void) lockFocus {
	
	//make sure we are ready to draw
	[super lockFocus];
	
	NSOpenGLContext *ctx = [self openGLContext];
	
	//as far as i can understand, just make 
	//the context draw into this view
	if ([ctx view] != self) {
		[ctx setView:self];
	}
	
	//make this the current context
	//we only have one...
	[ctx makeCurrentContext];
}

- (void) renderLoop {
	
	if (!setupCalled) {
		windowApp->setup();
		setupCalled = TRUE;
	}
	
	//VERY IMPORTANT!!!
	//we need to lock focus so that things are drawn here
	//this won't make a difference with just one window
	//but with multiple ones only one window will redraw
	[self lockFocus];
	
	glClearColor(0, 0, 0, 1);
	glClear(GL_COLOR_BUFFER_BIT);
	
	windowApp->update();
	
	windowApp->draw();
	
	[[self openGLContext] flushBuffer];	
	
	//now unlock so we can draw to others...
	[self unlockFocus];
	
	
	frameCounter++;
}

- (void) setFrameRate: (float) fr {
	
	[self eraseTimer];
	frameRate = fr;
	[self startTimer];
	
}

- (int) getFrameNum {
	return frameCounter;
}

- (float) getFrameRate {
	return frameRate;
}

- (void) startTimer {
	timer = [NSTimer timerWithTimeInterval: 1/frameRate
																	target:self 
																selector:@selector(renderLoop) 
																userInfo:nil 
																 repeats:YES];
	
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void) eraseTimer {
	
	[timer invalidate];
}

- (void) drawRect: (NSRect) rect {
	//do nothing here...
}


- (BOOL) acceptsFirstResponder {
	return YES;
}

// - - - - LEFT MOUSE BUTTON - - - - 


- (void) mouseDown: (NSEvent*) event {
	
	NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
	windowApp->mousePressed(p.x, self.frame.size.height - p.y, 0);
}

- (void) mouseDragged: (NSEvent*) event {
	
	NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
	windowApp->mouseDragged(p.x, self.frame.size.height - p.y, 0);
}

- (void) mouseUp: (NSEvent*) event {
	
	NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
	windowApp->mouseReleased(p.x, self.frame.size.height - p.y, 0);
	windowApp->mouseReleased();
}

// - - - - RIGHT MOUSE BUTTON - - - - 

- (void) rightMouseDown: (NSEvent*) event {
	
	NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
	windowApp->mousePressed(p.x, self.frame.size.height - p.y, 1);
}

- (void) rightMouseDragged: (NSEvent*) event {
	
	NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
	windowApp->mouseDragged(p.x, self.frame.size.height - p.y, 1);
}

- (void) rightMouseUp: (NSEvent*) event {
	
	NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
	windowApp->mouseReleased(p.x, self.frame.size.height - p.y, 1);
	windowApp->mouseReleased();
}

- (void) mouseMoved: (NSEvent*) event {
	
	NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
	windowApp->mouseX = p.x;
	windowApp->mouseY = self.frame.size.height - p.y;
	windowApp->mouseMoved(p.x, self.frame.size.height - p.y);
}

// - - - - KEYS - - - - 

- (void) keyDown: (NSEvent*) event {
	
	unichar c = [[event characters] characterAtIndex:0];
	windowApp->keyPressed(c);
}

- (void) keyUp: (NSEvent*) event {
	
	unichar c = [[event characters] characterAtIndex:0];
	windowApp->keyReleased(c);
}

// - - - - SCROLLWHEEL - - - -

- (void) scrollWheel: (NSEvent*) event {
	
	windowApp->mouseScrolled(event.deltaX, event.deltaY);
}



- (void) dealloc {
	
	[self eraseTimer];
	
	[super dealloc];
}

@end
