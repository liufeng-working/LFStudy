//
//  LFRuntimeViewController.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/2.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFRuntimeViewController.h"
#import "LFPerson.h"
#import <objc/message.h>
#import "UIImage+LFImage.h"
#import "NSObject+LFOBJC.h"

@interface LFRuntimeViewController ()

@end

@implementation LFRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //运行时机制，消息机制，任何方法调用，都是发送消息
    //SEL：方法编号，根据方法编号就可找到对应的方法
    LFPerson *person = [LFPerson new];
//    [person eat];
//    
//    [person performSelector:@selector(eat)];
//    
//    //运行时发送消息
//    /**
//     1.导入框架<objc/message.h>
//     2.Build Setting -> 搜索msg -> 设置为NO
//     */
//    objc_msgSend(person, @selector(eat));
//    objc_msgSend(person, @selector(run:), 10);
//    
//    [LFPerson eat];
//    Class Person = LFPerson.class;
//    [Person performSelector:@selector(eat)];
//    [Person eat];
//    objc_msgSend(Person, @selector(eat));
    
//    [person performSelector:@selector(jump)];
    [person performSelector:@selector(jump:) withObject:@"10米"];
    
    NSObject *objc = [NSObject new];
    objc.name = @"123";
    NSLog(@"%@", objc.name);
}

@end
