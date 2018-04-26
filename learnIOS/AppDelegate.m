//
//  AppDelegate.m
//  learnIOS
//
//  Created by QiHui Yan on 2018/3/24.
//  Copyright © 2018年 QiHui Yan. All rights reserved.
//

#import "AppDelegate.h"
#import <RESideMenu.h>
#import <SVProgressHUD.h>
#import "MyExNavigationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard* main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController* base = [main instantiateViewControllerWithIdentifier:@"base"];
    UIViewController* menu = [main instantiateViewControllerWithIdentifier:@"menu"];
    RESideMenu* side = [[RESideMenu alloc] initWithContentViewController:base leftMenuViewController:menu rightMenuViewController:nil];
    side.scaleContentView = NO;
    side.contentViewShadowEnabled = YES;
    side.contentViewInPortraitOffsetCenterX = [UIScreen mainScreen].bounds.size.width/3;
    side.bouncesHorizontally = NO;
    side.scaleMenuView = NO;
    side.fadeMenuView = NO;
    _window.rootViewController = side;
    [_window makeKeyAndVisible];
    [self initSVProgressHUD];
    return YES;
}

- (void)initSVProgressHUD{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
