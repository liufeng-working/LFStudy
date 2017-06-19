//
//  NSObject+LFCaculator.h
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/6/12.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFCaculatorMaker.h"

@interface NSObject (LFCaculator)

+ (NSInteger)makeCaculator:(void(^)(LFCaculatorMaker *maker))maker;

@end
