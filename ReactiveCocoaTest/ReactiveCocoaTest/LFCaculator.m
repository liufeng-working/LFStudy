//
//  LFCaculator.m
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/6/12.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFCaculator.h"

@implementation LFCaculator

- (LFCaculator *)caculator:(NSInteger(^)(NSInteger value))caculator
{
    self.result = caculator(self.result);
    return self;
}

- (LFCaculator *)equal:(BOOL(^)(NSInteger value))operation
{
    self.equal = operation(self.result);
    return self;
}

@end
