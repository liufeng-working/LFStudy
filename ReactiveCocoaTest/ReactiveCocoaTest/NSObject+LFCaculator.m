//
//  NSObject+LFCaculator.m
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/6/12.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "NSObject+LFCaculator.h"

@implementation NSObject (LFCaculator)

+ (NSInteger)makeCaculator:(void(^)(LFCaculatorMaker *maker))caculatorMaker
{
    LFCaculatorMaker *maker = [[LFCaculatorMaker alloc] init];
    caculatorMaker(maker);
    return maker.result;
}

@end
