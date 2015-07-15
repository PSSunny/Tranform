//
//  CustomView.m
//  Transform
//
//  Created by macmini25 on 07/07/15.
//  Copyright (c) 2015 macmini25. All rights reserved.
//

#import "CustomView.h"

#define kWidth 36.0f
#define kMinWidth 48.0

@implementation CustomView
@synthesize resizingControl;
@synthesize prevPoint;
@synthesize deltaAngle;


-(void)setUpView{
    
    self.type =1;
    self.resizingControl = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-kWidth,
                                                                        self.frame.size.height-kWidth,
                                                                        kWidth, kWidth)];
    self.resizingControl.backgroundColor = [UIColor clearColor];
    self.resizingControl.userInteractionEnabled = YES;
    self.resizingControl.image = [UIImage imageNamed:@"rotate"];
    
    UIPanGestureRecognizer*panResizeGesture = [[UIPanGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(resizeTranslate:)];
    [self.resizingControl addGestureRecognizer:panResizeGesture];
    [self addSubview:self.resizingControl];
}
- (void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateBegan)
    {
        self.prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        
        // preventing from the picture being shrinked too far by resizing
       
            CGPoint point = [recognizer locationInView:self];
            float wChange = 0.0, hChange = 0.0;
            
            wChange = (point.x - self.prevPoint.x);
            float wRatioChange = (wChange/(float)self.bounds.size.width);
            
            hChange = wRatioChange * self.bounds.size.height;
            
            if (ABS(wChange) > 50.0f || ABS(hChange) > 50.0f)
            {
                self.prevPoint = [recognizer locationOfTouch:0 inView:self];
                return;
            }
                          
            
            
            self.resizingControl.frame =CGRectMake(self.bounds.size.width-kWidth,
                                                   self.bounds.size.height-kWidth,
                                                   kWidth, kWidth);
        
            self.prevPoint = [recognizer locationOfTouch:0 inView:self];
        
        
        float ang = atan2([recognizer locationInView:self.superview].y - self.center.y,
                          [recognizer locationInView:self.superview].x - self.center.x);
        
        float angleDiff = self.deltaAngle - ang;
        
        
            self.transform = CGAffineTransformMakeRotation(-angleDiff);
        //self.transform = CGAffineTransformMakeRotation(-angleDiff);
        
        

        
        [self setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        self.prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
        [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGRect(self.frame) forKey:@"frame"];
        [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGAffineTransform(self.transform) forKey:@"transform"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
}
@end
