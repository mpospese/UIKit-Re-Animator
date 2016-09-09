//
//  Animator2ViewController.m
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/9/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import "Animator2ViewController.h"

@implementation Animator2ViewController

- (void)handleTap
{
    if (self.animator.isRunning)
    {
        // FIX: pause then re-start animator when reversing
        [self.animator pauseAnimation];
        self.animator.reversed = !self.animator.isReversed;
        [self.animator startAnimation];
        
        return;
    }
    
    [self makeAnimation];
}

@end
