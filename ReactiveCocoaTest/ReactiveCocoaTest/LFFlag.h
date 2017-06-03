//
//  LFFlag.h
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/5/31.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFFlag : NSObject

@property(nonatomic,copy) NSString *name;

+ (instancetype)flagWithDic:(NSDictionary *)dic;

@end
