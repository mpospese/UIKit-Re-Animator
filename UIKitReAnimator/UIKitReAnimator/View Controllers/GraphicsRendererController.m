//
//  GraphicsRendererController.m
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/8/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import "GraphicsRendererController.h"
#import "RenderCell.h"

@interface GraphicsRendererController ()

@property (nonatomic, strong) NSArray *rows;

@end

@implementation GraphicsRendererController

static NSString *const kRenderCellIdentifier = @"com.crazymilksoftware.renderCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadData];
    
    [self.tableView registerClass:[RenderCell class] forCellReuseIdentifier:kRenderCellIdentifier];
}

- (void)loadData
{
    NSMutableArray *rows = [NSMutableArray array];
    
    // 10 rows worth of data
    for (NSInteger row = 0; row < 100; row++)
    {
        NSMutableArray *items = [NSMutableArray array];
        
        // each row will have 20 data points
        for (NSInteger item = 0; item < 20; item++)
        {
            // values range from 0 to 1 in increments of 0.01
            [items addObject:@(arc4random_uniform(101) / 100.f)];
        }
        
        [rows addObject:[items copy]];
    }
    
    self.rows = [rows copy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RenderCell *cell = (RenderCell *)[tableView dequeueReusableCellWithIdentifier:kRenderCellIdentifier forIndexPath:indexPath];
    
    NSArray *rowData = self.rows[indexPath.row];
    [cell setChart:[self chartForArray:rowData]];
    
    return cell;
}

#pragma mark - Table view delegate

#pragma mark - Drawing

- (UIImage *)chartForArray:(NSArray *)rowData
{
    CGSize size = CGSizeMake(CGRectGetWidth(self.tableView.bounds) - 16, self.tableView.rowHeight - 16);
    return [self chartForArray_new:rowData size:size];
}

- (UIImage *)chartForArray_old:(NSArray *)rowData size:(CGSize)size
{
    // Configure the context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Draw the chart
    [self drawChartWithContext:context data:rowData size:size];
    
    // Fetch the image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)chartForArray_new:(NSArray *)rowData size:(CGSize)size
{
    UIGraphicsImageRenderer* renderer = [[UIGraphicsImageRenderer alloc] initWithSize:size];
    
    return [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        CGContextRef context = rendererContext.CGContext;
        [self drawChartWithContext:context data:rowData size:size];
    }];
}

- (void)drawChartWithContext:(CGContextRef)context data:(NSArray *)rowData size:(CGSize)size
{
    NSUInteger count = [rowData count];
    
    UIColor *fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    CGFloat barWidth = size.width / count;
    
    // Configure the context
    
    // Draw the background
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddPath(context, [UIBezierPath bezierPathWithRect:(CGRect){CGPointZero, size}].CGPath);
    CGContextFillPath(context);
    
    CGFloat maxBarHeight = size.height;
    
    // Build clipping path from motion scores
    CGContextSaveGState(context);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, size.height)];
    CGFloat x = barWidth;
    
    for (NSNumber *value in rowData)
    {
        CGFloat barHeight = [value doubleValue] * maxBarHeight;
        
        [path addLineToPoint:CGPointMake(x - barWidth/2, size.height - barHeight)];
        
        x += barWidth;
    }
    [path addLineToPoint:CGPointMake(size.width, size.height)];
    [path closePath];
    
    // clip area under the line graph (motion scores)
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    
    // draw pinstripes
    x = 1.5;
    CGContextSetLineWidth(context, 1);
    
    // path for a single stripe
    UIBezierPath *bar = [UIBezierPath bezierPath];
    [bar moveToPoint:CGPointMake(x, 0)];
    [bar addLineToPoint:CGPointMake(x, size.height)];
    
    CGContextSetFillColorWithColor(context, NULL);
    CGContextSetStrokeColorWithColor(context, fillColor.CGColor);
    
    while (x < size.width)
    {
        // stroke a single pinstripe
        CGContextAddPath(context, bar.CGPath);
        CGContextStrokePath(context);
        
        // translate context over to stroke the next stripe
        CGContextTranslateCTM(context, 2, 0);
        x += 2;
    }
    
    // this will remove the clipping path, translations, etc
    CGContextRestoreGState(context);
    
    
    // draw yellow line around clipping path
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextAddPath(context, path.CGPath);
    CGContextStrokePath(context);
}

@end
