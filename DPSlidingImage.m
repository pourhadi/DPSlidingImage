//
//  DPSlidingImage.M
//
//The MIT License (MIT)
//Copyright (c) 2012 Daniel Pourhadi
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "DPSlidingImage.h"


@implementation DPSlidingImage

@synthesize currentImage=_currentImage, image=_image, animating, widthBorder;
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		[self initStuff];

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {

        [self initStuff];

	}
	return self;
}

-(void)initStuff
{
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
 
}

-(UIImageView*)imageView
{
	if (_currentImage)
		return _currentImage;
	
	UIImageView *tmp = [[UIImageView alloc] initWithFrame:self.bounds];
	tmp.image = _image;
	
	return tmp;
}
-(void)setImage:(UIImage*)img goRight:(BOOL)goRight animate:(BOOL)animate
{		
	
	[self setImage:img];
	@autoreleasepool {
		
		
		
		if (!animating)
		{

			if (!_currentImage)
			{

				UIImageView *current = [[UIImageView alloc] initWithFrame:CGRectZero];
				current.frame = CGRectMake((widthBorder / 2), 0, self.frame.size.width-widthBorder, self.frame.size.height);
				current.image = img;
				[self setCurrentImage:current];
				
				[self addSubview:_currentImage];
			}
			else 
			{
		
				
				CGRect oldFrame = _currentImage.frame;
				
				
				UIImageView *newImg = [[UIImageView alloc] initWithFrame:CGRectZero];
				newImg.frame = CGRectMake((goRight ? -oldFrame.size.width-(widthBorder / 2): self.frame.size.width+(widthBorder / 2)), 0, self.frame.size.width-widthBorder, self.frame.size.height);
				newImg.image = img;
				CGRect newFrame = newImg.frame;
				
	
				
				[self addSubview:newImg];
				
				oldFrame.origin.x = (goRight ? self.frame.size.width+(widthBorder / 2) : -oldFrame.size.width-(widthBorder / 2));
				
				newFrame.origin.x = widthBorder / 2;
				
				
				
				if (animate){
					[UIView animateWithDuration:DEFAULT_ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
						newImg.frame = newFrame;
						_currentImage.frame = oldFrame;
						animating = YES;
					} completion:^(BOOL finished){
						
						[_currentImage removeFromSuperview];
						
						[self setCurrentImage:nil];

						[self setCurrentImage:newImg];
						
						CGRect anotherFrame = _currentImage.frame;
						anotherFrame.size.width = anotherFrame.size.width-widthBorder;
						anotherFrame.origin.x = (widthBorder / 2);
						_currentImage.frame = anotherFrame;

						
						animating = NO;
						
						
					}];
				}
				else
				{
					newImg.frame = newFrame;
					_currentImage.frame = oldFrame;
					
					[_currentImage removeFromSuperview];
					[self setCurrentImage:nil];
				
					
					[self setCurrentImage:newImg];
					
					CGRect anotherFrame = _currentImage.frame;
					anotherFrame.size.width = anotherFrame.size.width-widthBorder;
					anotherFrame.origin.x = (widthBorder / 2);
					_currentImage.frame = anotherFrame;
			
					
				}
				
				
				
			}
		}
	}
}





@end
