//
//  LFBeauty.m
//  LFStudy
//
//  Created by 刘丰 on 2017/8/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFBeauty.h"

@implementation LFBeauty

- (instancetype)initWithDic:(NSDictionary *)dic
{
    LFBeauty *beauty = [LFBeauty new];
    [beauty setValuesForKeysWithDictionary:dic];
    return beauty;
}
+ (instancetype)beautyWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

@end
