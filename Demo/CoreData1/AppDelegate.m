//
//  AppDelegate.m
//  CoreData1
//
//  Created by 刘丰 on 2017/10/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "AppDelegate.h"
#import "MagicalRecord.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MagicalRecord setupCoreDataStack];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
}

@end
