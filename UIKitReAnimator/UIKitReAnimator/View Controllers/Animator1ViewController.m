//
//  Animator1ViewController.m
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/9/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import "Animator1ViewController.h"

@implementation Animator1ViewController

- (void)handleTap
{
    if (self.animator.isRunning)
    {
        self.animator.reversed = !self.animator.isReversed;
        
        return;
    }
    
    [self makeAnimation];
}

@end
