//
//  RenderCell.m
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/8/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import "RenderCell.h"

@interface RenderCell();

@property (nonatomic, weak) UIImageView *chartView;

@end

@implementation RenderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self loadContentView];
    }
    return self;
}

#pragma mark - Subviews

- (void)loadContentView
{
    self.contentView.backgroundColor = [UIColor colorWithWhite:0.16 alpha:1];
    [self loadChartView];
    
    [self loadConstraints];
}

- (void)loadChartView
{
    UIImageView *chartView = [UIImageView new];
    chartView.frame = CGRectInset(self.contentView.bounds, 8, 8);
    
    [self.contentView addSubview:chartView];
    self.chartView = chartView;
}

#pragma mark - Constraints

- (void)loadConstraints
{
    [[NSLayoutConstraint constraintWithItem:self.chartView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:8] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.chartView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-8] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.chartView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:8] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.chartView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8] setActive:YES];
}

#pragma mark - Subviews

- (void)setChart:(UIImage *)chartImage;
{
    self.chartView.image = chartImage;
    self.chartView.frame = CGRectInset(self.contentView.bounds, 8, 8);
}

@end
