//
//  ControlDelegate.h
//  ofxNSWindower_gui_example
//
//  Created by Will Gallia on 24/05/2012.
//  Copyright 2012 . All rights reserved.
//

//this class is instantiated from the nib...
//see MainMenu.xib

#include "testApp.h"
#include "ofxNSWindower.h"

#import <Cocoa/Cocoa.h>


@interface ControlDelegate : NSObject {

	NSTextField *textfield;
}

@property (assign) IBOutlet NSTextField *textfield;

- (IBAction) submit: (id) sender;
- (IBAction) changeSpeed: (id) sender;

@end
