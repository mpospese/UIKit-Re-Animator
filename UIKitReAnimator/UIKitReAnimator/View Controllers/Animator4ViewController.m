//
//  Animator4ViewController.m
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/9/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import "Animator4ViewController.h"

@interface Animator4ViewController ()

@property (nonatomic, strong) UIViewPropertyAnimator *scaleAnimator;

@end

@implementation Animator4ViewController

- (BOOL)supportsPan
{
    return YES;
}

- (void)makeScaleAnimation
{
    // (0.25, 1) + (0.75, 1) // overshoot and bounce back
    UICubicTimingParameters *timing = [[UICubicTimingParameters alloc] initWithControlPoint1:CGPointMake(0.25, 1) controlPoint2:CGPointMake(0.75, 1.5)];
    
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:2 timingParameters:timing];
    
    BOOL isInflated = !CGAffineTransformIsIdentity(self.ball.transform);
    
    [animator addAnimations:^{
        
        self.ball.transform = isInflated? CGAffineTransformIdentity : CGAffineTransformMakeScale(2, 2);
    }];
    
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        self.scaleAnimator = nil;
    }];
    
    self.scaleAnimator = animator;
    [self.scaleAnimator startAnimation];
}

#pragma mark - Gesture Recognizer

- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if (self.animator)
        {
            if (self.animator.isRunning)
            {
                if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
                {
                    [self.animator pauseAnimation];
                }
            }
            else
            {
                if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
                {
                    [self.animator startAnimation];
                }
            }
        }
        
        if (!self.scaleAnimator)
        {
            [self makeScaleAnimation];
        }
        else
        {
            [self.scaleAnimator pauseAnimation];
            [self.scaleAnimator setReversed:gestureRecognizer.state == UIGestureRecognizerStateEnded];
            [self.scaleAnimator startAnimation];
        }
    }
}

@end
