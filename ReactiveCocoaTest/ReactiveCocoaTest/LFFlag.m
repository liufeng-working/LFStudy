//
//  LFFlag.m
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/5/31.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFlag.h"

@implementation LFFlag

+ (instancetype)flagWithDic:(NSDictionary *)dic;
{
    LFFlag *flag = [[self alloc] init];
    [flag setValuesForKeysWithDictionary:dic];
    return flag;
}

@end
