//
//  Animator3ViewController.m
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/9/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import "Animator3ViewController.h"

@interface Animator3ViewController ()

@end

@implementation Animator3ViewController

- (void)handleTap
{
    if (self.animator.isRunning)
    {
        [self.animator pauseAnimation];
        self.animator.reversed = !self.animator.isReversed;
        [self.animator startAnimation];
        
        return;
    }
    
    [self makeAnimation];
}

- (void)makeAnimation
{
    BOOL isBottom = self.ball.center.y > self.view.center.y;
    
    id<UITimingCurveProvider> timing = [[UICubicTimingParameters alloc] initWithAnimationCurve:UIViewAnimationCurveEaseInOut];
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:4 timingParameters:timing];
    
    // FIX: use constraints instead of absolute positioning
    
    NSLayoutConstraint *oldConstraint = isBottom? self.bottomConstraint : self.topConstraint;
    NSLayoutConstraint *newConstraint = isBottom? self.topConstraint : self.bottomConstraint;
    
    // remove previous constraint
    [oldConstraint setActive:NO];
    [self.view layoutIfNeeded];
    
    [animator addAnimations:^{
        // add new constraint
        [newConstraint setActive:YES];
        [self.view layoutIfNeeded];
    }];
    
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        self.animator = nil;
    }];
    
    [animator startAnimation];
    self.animator = animator;    
}

@end
