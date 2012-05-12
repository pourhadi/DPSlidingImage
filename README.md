DPSlidingImage
==============

UIView with non-fading sliding image transition


Summary
==============
While attempting to design an interface similar to the Music app's Now Playing screen, I realized there was no built-in option--in either CAAnimation and its subclasses or in the UIView animation methods--to effectively push one image away with its replacement image (i.e., when you skip tracks in the Music app and the album artwork slides from right to left).

There was one option: a CATransition option called Push that would theoretically do what I was looking for -- but unfortunately that particular option also adds a fade effect to the slide, which, in this circumstance, is far less aesthetically appropriate.

So I wrote a simple UIView subclass called DPSlidingImage that essentially acts as UIImageView capable of switching images with a sliding animation to either the left or right.

Installation
==============
Simply add both source files to your project and import DPSlidingImage.h where you need it.

Usage
==============
Simple enough:

1. Create an instance of DPSlidingImage using -initWithFrame: and add it to your view hierarchy.

2. To set the current image, call -setImage:goRight:animate:. (It's pretty straightforward: if you send YES to animate, it will by default slide the images right-to-left. If you send YES for goRight:, the sliding effect will go from left-to-right.

You can also obtain the currently-displayed image conveniently by calling -image, and access the underlying UIImageView object by calling -imageView.

Misc
==============
I wrote this early in my development, um, development, so I imagine it's not the most efficient way to perform this particular task. But it does the job, and I've been using it in OnCue for years.

Please feel free to improve upon on it, or submit questions / comments / suggestions.
