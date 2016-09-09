//
//  AppDelegate.m
//  UIKitReAnimator
//
//  Created by Mark Pospesel on 9/8/16.
//  Copyright © 2016 Crazy Milk Software. All rights reserved.
//

#import "AppDelegate.h"
#import "Animator1ViewController.h"
#import "Animator2ViewController.h"
#import "Animator3ViewController.h"
#import "Animator4ViewController.h"
#import "PreviewInteractionControllerViewController.h"
#import "GraphicsRendererController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
 
    // UI Initialization
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *controller =
        [Animator1ViewController new];
//        [Animator2ViewController new];
//        [Animator3ViewController new];
//          [Animator4ViewController new];
//        [PreviewInteractionControllerViewController new];
//        [GraphicsRendererController new];
    
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
