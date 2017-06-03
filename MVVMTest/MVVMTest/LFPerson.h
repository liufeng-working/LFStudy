//
//  LFPerson.h
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/2.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFiOS.h"

/**
 __covariant 协变
 __contravariant 逆变
 */
@interface LFPerson<__contravariant T> : NSObject

@property(nonatomic,strong) T language;

+ (__kindof LFPerson *)person;

+ (void)eat;
- (void)eat;
- (void)run:(NSInteger)meter;

@end
