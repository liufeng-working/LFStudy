//
//  LFPerson.m
//  运行时（runtime）
//
//  Created by 刘丰 on 2017/11/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFPerson.h"
#import "LFStudent.h"

@implementation LFPerson

- (void)test
{
    [self learn];
}

- (void)learn
{
    NSLog(@"人类在学习");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == NSSelectorFromString(@"testInva")) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if (anInvocation.selector == NSSelectorFromString(@"testInva")) {
        [anInvocation invokeWithTarget:[LFStudent new]];
    }else {
        [super forwardInvocation:anInvocation];
    }
}

@end
