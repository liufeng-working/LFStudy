//
//  LFPerson.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/2.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFPerson.h"
#import <objc/message.h>

@implementation LFPerson

+ (__kindof LFPerson *)person
{
    return nil;
}

+ (void)eat
{
    NSLog(@"调用类方法吃东西");
}

- (void)eat
{
    NSLog(@"调用对象方法吃东西");
}

- (void)run:(NSInteger)meter
{
    NSLog(@"跑了%ld米", (long)meter);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(jump:)) {
        class_addMethod(self, sel, (IMP)jump, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void jump(id self, SEL _cmd, id meter)
{
    NSLog(@"%@-%@-%@", self, NSStringFromSelector(_cmd), meter);
}

- (void)setLanguage:(id)language
{
    _language = language;
}

@end
