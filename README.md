# paint-ios
Herein lies a simple paint app, built in Swift.

--Requirements--

A few features are required to make a drawing app.

1. User can select color
2. User can draw on screen
3. User can clear "canvas"

--Process--

Quick & Dirty

The first prototype was pretty fast.  I set up a couple gesture recognizers (tap and pan) through Interface builder
and linked them to the view controller with a method to handle each type.  When a gesture would occur, I would get 
the location of the gesture and create a small UIView with the location of the gesture.  The new view would then be
added as a subview of the view controller.  This resulted in a protoype that only had feature 2.

Adding features

The next task was feature 3, since that was the quickest.  Since the view stores its subviews as an array, its a 
simple task to iterate through them and remove each from the subview.  I had subclassed the UIView, so I was sure
that I was removing only the ones that were a member of the subclass.  The next step was choosing the color, which
also was pretty simple.  I used a cocoapod
I suppose I has known all along that this was a poor approach to drawing.  After observing the memory use of this
technique to draw, I knew I had to change how the draw was done.

Graphic Overhaul

more to come...
