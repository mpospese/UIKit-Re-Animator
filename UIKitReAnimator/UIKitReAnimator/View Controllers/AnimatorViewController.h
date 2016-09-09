//
//  AnimatorViewController.h
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/8/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimatorViewController : UIViewController

@property (nonatomic, weak) UIView *ball;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@property (nonatomic, strong) UIViewPropertyAnimator *animator;
@property (nonatomic, readonly) CGFloat radius;

- (void)makeAnimation;

@end
