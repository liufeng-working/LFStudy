//
//  LFTool.m
//  extension
//
//  Created by 刘丰 on 2017/12/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTool.h"

#define lf_groupName @"group.liufeng.uavmanager"
#define lf_todayKey @"lf_todayKey"
@implementation LFTool

+ (void)add
{
    NSUserDefaults *def = [[NSUserDefaults alloc] initWithSuiteName:lf_groupName];
    NSMutableArray *todays = self.get;
    [todays addObject:@"iOS"];
    [def setObject:todays forKey:lf_todayKey];
    [def synchronize];
}

+ (void)remove
{
    NSUserDefaults *def = [[NSUserDefaults alloc] initWithSuiteName:lf_groupName];
    NSMutableArray *todays = self.get;
    if (todays.count) {
        [todays removeLastObject];
    }
    [def setObject:todays forKey:lf_todayKey];
    [def synchronize];
}

+ (NSMutableArray<NSString *> *)get
{
    NSUserDefaults *def = [[NSUserDefaults alloc] initWithSuiteName:lf_groupName];
     NSArray *todays = [def stringArrayForKey:lf_todayKey];
    return todays.count ? todays.mutableCopy : [NSMutableArray array];
}

@end

