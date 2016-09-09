//
//  AnimatorViewController.m
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/8/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import "AnimatorViewController.h"

@interface AnimatorViewController ()


@end

@implementation AnimatorViewController

static const CGFloat kRadius = 30;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeApperance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (BOOL)supportsTap
{
    return YES;
}

- (BOOL)supportsPan
{
    return NO;
}

- (CGFloat)radius
{
    return kRadius;
}

#pragma mark - Subviews

- (void)customizeApperance
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadBall];
    [self loadConstraints];
}

- (void)loadBall
{
    UIView *ball = [UIView new];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor yellowColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineWidth = 4;
    layer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, kRadius * 2, kRadius * 2)].CGPath;
    
    [ball.layer addSublayer:layer];
    [self.view addSubview:ball];
    self.ball = ball;
    
    if ([self supportsTap])
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [ball addGestureRecognizer:tap];
    }
    
    if ([self supportsPan])
    {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [ball addGestureRecognizer:pan];
    }
}

#pragma mark - Constraints

- (void)loadConstraints
{
    [self.ball setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // pin width
    [[NSLayoutConstraint constraintWithItem:self.ball attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:(kRadius * 2)] setActive:YES];
    
    // pin height
    [[NSLayoutConstraint constraintWithItem:self.ball attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:(kRadius * 2)] setActive:YES];
    
    // pin center x
    [[NSLayoutConstraint constraintWithItem:self.ball attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0] setActive:YES];
    
    // pin to top (inactive)
    self.topConstraint = [NSLayoutConstraint constraintWithItem:self.ball attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:(kRadius * 2)];
    [self.topConstraint setActive:NO];
    
    // pin to bottom
    self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.ball attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-(kRadius * 2)];
    [self.bottomConstraint setActive:YES];
}

#pragma mark - Gesture Recognizers

- (void)tap:(UITapGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
    {
        return;
    }
    
    [self handleTap];
}

- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer
{
    [self handlePan:gestureRecognizer];
}

#pragma mark - Overrides

- (void)handleTap
{
    
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    
}

#pragma mark - Animations

- (void)makeAnimation
{
    BOOL isBottom = self.ball.center.y > self.view.center.y;
    
    id<UITimingCurveProvider> timing = [[UICubicTimingParameters alloc] initWithAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:4 timingParameters:timing];
    
    [animator addAnimations:^{
        
        self.ball.center = CGPointMake(CGRectGetMidX(self.view.bounds), isBottom? (kRadius * 2) : CGRectGetMaxY(self.view.bounds) - (kRadius * 2));
    }];
    
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        self.animator = nil;
    }];
    
    [animator startAnimation];
    self.animator = animator;
}

@end
