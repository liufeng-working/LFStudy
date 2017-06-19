//
//  LFCaculatorMaker.m
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/6/12.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFCaculatorMaker.h"

@implementation LFCaculatorMaker

- (LFCaculatorMaker *(^)(NSInteger value))add
{
    return ^LFCaculatorMaker *(NSInteger value){
        self.result += value;
        return self;
    };
}

@end
