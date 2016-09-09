//
//  PreviewInteractionControllerViewController.m
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/8/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import "PreviewInteractionControllerViewController.h"

@interface PreviewInteractionControllerViewController ()<UIPreviewInteractionDelegate>

@property (nonatomic, weak) UIView *ball;
@property (nonatomic, strong) UIViewPropertyAnimator *previewAnimator;
@property (nonatomic, strong) UIViewPropertyAnimator *commitAnimator;
@property (nonatomic, strong) UIPreviewInteraction *previewInteraction;

@end

@implementation PreviewInteractionControllerViewController

static const CGFloat kRadius = 50;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeApperance];
    
    self.previewInteraction = [[UIPreviewInteraction alloc] initWithView:self.view];
    self.previewInteraction.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    ball.backgroundColor = [UIColor yellowColor];
    ball.layer.borderColor = [UIColor blackColor].CGColor;
    ball.layer.borderWidth = 4;
    ball.layer.cornerRadius = 4;
    ball.clipsToBounds = YES;
    
    [self.view addSubview:ball];
    self.ball = ball;
}

#pragma mark - Constraints

- (void)loadConstraints
{
    [self.ball setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[NSLayoutConstraint constraintWithItem:self.ball attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:(kRadius * 2)] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.ball attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:(kRadius * 2)] setActive:YES];
    
    [[NSLayoutConstraint constraintWithItem:self.ball attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.ball attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0] setActive:YES];
}

- (void)makePreviewAnimation
{
    UICubicTimingParameters *timing = [[UICubicTimingParameters alloc] initWithAnimationCurve:UIViewAnimationCurveEaseInOut];
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:3 timingParameters:timing];
    
    [animator addAnimations:^{
        
        self.ball.transform = CGAffineTransformMakeScale(2, 2);
    }];
    
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        self.previewAnimator = nil;
    }];
    
    self.previewAnimator = animator;
    [self.previewAnimator pauseAnimation];
}

- (void)makeCommitAnimation
{
    UICubicTimingParameters *timing = [[UICubicTimingParameters alloc] initWithAnimationCurve:UIViewAnimationCurveEaseInOut];
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:3 timingParameters:timing];
    
    [animator addAnimations:^{
        
        CGAffineTransform transform = CGAffineTransformMakeScale(4, 4);
        transform = CGAffineTransformRotate(transform, 6.99 * M_PI);
        self.ball.transform = transform;
        self.ball.alpha = 0.25;
        self.ball.backgroundColor = [UIColor orangeColor];
    }];
    
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        self.commitAnimator = nil;
    }];
    
    self.commitAnimator = animator;
    [self.commitAnimator pauseAnimation];
}

- (void)makeCancelAnimation
{
    UICubicTimingParameters *timing = [[UICubicTimingParameters alloc] initWithAnimationCurve:UIViewAnimationCurveEaseInOut];
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:1 timingParameters:timing];
    
    [animator addAnimations:^{
        
        self.ball.transform = CGAffineTransformIdentity;
        self.ball.alpha = 1;
        self.ball.backgroundColor = [UIColor yellowColor];
    }];
    
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        self.previewAnimator = nil;
    }];
    
    self.previewAnimator = animator;
    [self.previewAnimator startAnimation];
}

#pragma mark - Animations

#pragma mark - UIPreviewInteractionDelegate

- (void)previewInteraction:(UIPreviewInteraction *)previewInteraction didUpdatePreviewTransition:(CGFloat)transitionProgress ended:(BOOL)ended
{
    NSLog(@"update preview: %f", transitionProgress);
    if (!self.previewAnimator)
    {
        [self makePreviewAnimation];
    }
    
    [self.previewAnimator setFractionComplete:transitionProgress];
}

- (void)previewInteractionDidCancel:(UIPreviewInteraction *)previewInteraction
{
    if (self.previewAnimator)
    {
        [self.previewAnimator stopAnimation:YES];
        self.previewAnimator = nil;
    }
    if (self.commitAnimator)
    {
        [self.commitAnimator stopAnimation:YES];
        self.commitAnimator = nil;
    }
    
    [self makeCancelAnimation];
}

- (void)previewInteraction:(UIPreviewInteraction *)previewInteraction didUpdateCommitTransition:(CGFloat)transitionProgress ended:(BOOL)ended
{
    NSLog(@"update commit: %f", transitionProgress);
    if (self.previewAnimator)
    {
        [self.previewAnimator stopAnimation:YES];
        self.previewAnimator = nil;
    }
    
    if (!self.commitAnimator)
    {
        [self makeCommitAnimation];
    }
    
    [self.commitAnimator setFractionComplete:transitionProgress];
    
    if (ended)
    {
        if (self.commitAnimator)
        {
            [self.commitAnimator stopAnimation:YES];
            self.commitAnimator = nil;
        }
        
        [self makeCancelAnimation];
    }
}

@end
