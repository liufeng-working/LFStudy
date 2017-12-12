//
//  ViewController.m
//  运行时（runtime）
//
//  Created by 刘丰 on 2017/7/11.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "LFStudent.h"

@interface ViewController ()

@end

@implementation ViewController

void (*test)(id, SEL, BOOL);

- (void)viewDidLoad {
    [super viewDidLoad];

    // 当一个方法被连续调用很多次时，可以这样获取方法地址
    test = (void(*)(id, SEL, BOOL))[self methodForSelector:@selector(setFail:)];
    test(self, @selector(setFail:), YES);
    
    LFPerson *p = [LFPerson new];
    [p performSelector:NSSelectorFromString(@"testInva")];
    
    LFStudent *s = [LFStudent new];
    [s test];
}

- (void)setFail:(BOOL)fail
{
    NSLog(@"%d", fail);
    
    Method m = class_getInstanceMethod(self.class, @selector(setFail:));
    const char *type = method_getTypeEncoding(m);
    NSString *t = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
    NSLog(@"%@", t);
    
    char *i = @encode(Class);
    NSLog(@"%s", i);
}

@end
