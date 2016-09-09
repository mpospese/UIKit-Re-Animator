//
//  MainViewController.m
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/9/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import "MainViewController.h"
#import "Animator1ViewController.h"
#import "Animator2ViewController.h"
#import "Animator3ViewController.h"
#import "Animator4ViewController.h"
#import "PreviewInteractionControllerViewController.h"
#import "GraphicsRendererController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *tabs = @[
                      [self navigationControllerWithRootController:[Animator1ViewController new] title:@"1"],
                      [self navigationControllerWithRootController:[Animator2ViewController new] title:@"2"],
                      [self navigationControllerWithRootController:[Animator3ViewController new] title:@"3"],
                      [self navigationControllerWithRootController:[Animator4ViewController new] title:@"4"]
                      ];
    
    [self setViewControllers:tabs];
    self.selectedIndex = 0;
    self.tabBar.translucent = NO;
}

- (UIViewController *)navigationControllerWithRootController:(UIViewController *)rootController title:(NSString *)title
{
    [rootController setTitle:title];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    navController.navigationBar.translucent = NO;
    navController.tabBarItem.title = title;
    
    return navController;
}


@end
