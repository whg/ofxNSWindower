ofxNSWindower
=============

With ofxNSWindower, you can create multiple OpenGL windows with a shared context, to draw your openFrameworks apps. ofxNSWindower does not use GLUT, so an openFrameworks app has a slightly different design, but allows for greater flexibility. Features using ofxNSWindower are:

* Multiple Windows
* Mouse Scrolled Events
* Usage of menu bars without blocking the app
* Easier Cocoa GUIs


Usage
-----

ofxNSWindower, implemented as a singleton class, handles all the windows. Each window has an app (what it draws) and also other attributes like a name and window options. To add a window you could do the following:

`ofxNSWindower::instance()->addWindow(new testApp());`

Which is roughly equivalent to `ofRunApp(new testApp());`

Additionally, you can give the window a name, options for the window and a frame rate:

`ofxNSWindower::instance()->addWindow(new testApp(), "hello", NSTitledWindowMask, 60);`

`hello` is the name of the window, `NSTitledWindowMask` is the window option (more on those later) and `60` is the frame rate. If 0 is given as a frame rate, then the frame rate will match the refresh rate of the screen.

Window options can be seen [here](https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/ApplicationKit/Classes/NSWindow_Class/Reference/Reference.html). These can be combined using a boolean OR (|). The default is `NSTitledWindowMask`, so there is a title bar but no buttons.

If a name is not given then the window is assigned a random name which is a number between 0 and 1000. The default frame rate is 30.

To access `testApp` you can use `getAppPtr()`, in a very similar manner to normal openFrameworks apps, only that here you need to pass the name of the window to get the right app:

`testApp *saverApp = (testApp*) ofxNSWindower::instance()->getAppPtr("hello");`


Apps do not subclass `ofBaseApp`, but `ofxNSWindowApp`. This is very similar to `ofBaseApp`, but has a few differences. These are:

* mouseScrolled event is added
* dragEvent() & gotMessage() is removed
* windowResized() is removed
* exit() is now close()

Also, a few of the openFrameworks functions now will not work, such as `ofGetWidth()` and other functions that presume there is only one window. I have tried to re-implement these as much as I could (I have probably forgotten a few):

* `void setWindowTitle(string title);`
* `ofPoint getWindowPosition();`
* `ofPoint	getWindowSize();`
* `int getWidth();`
* `int getHeight();`
* `ofRectangle getFrame();`
* `float getFrameRate();`
* `void setFrameRate(float fr);`
* `int getFrameNum();`
* `float getRealFrameRate();`
* `void setWindowSize(int w, int h);`
* `void setWindowPosition(int x, int y);`

These are defined in `ofxNSWindowApp` so can be called in your subclassed app and are specific to that app/window.


Architecture
------------

The architecture of an ofxNSWindower app is quite different to a standard openFrameworks app using GLUT. Apps are not created in main, but inside the application delegate, which is instantiated from the main .xib file. See the examples for more details.


Compatibility
-------------

I haven't actually upgraded to Lion yet, so I have no idea if it works on anything apart from Snow Leopard. And obviously, this will only work on OSX.
