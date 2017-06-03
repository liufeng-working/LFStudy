//
//  NSObject+LFOBJC.h
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LFOBJC)

@property(nonatomic,copy) NSString *name;

+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
