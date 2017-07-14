//
//  AppDelegate.m
//  window学习
//
//  Created by 刘丰 on 2017/7/12.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property(nonatomic,strong) UIWindow *window1;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    window.backgroundColor = [UIColor redColor];
//    window.rootViewController = [[UIViewController alloc] init];
//    [window makeKeyAndVisible];
//    self.window = window;
    NSLog(@"%s", __func__);
    
    UIWindow *window1 = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 414, 20)];
    window1.windowLevel = UIWindowLevelNormal + 1;
    window1.backgroundColor = [UIColor blueColor];
    window1.rootViewController = [[UIViewController alloc] init];
    window1.hidden = NO;
    self.window1 = window1;

    return YES;
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
