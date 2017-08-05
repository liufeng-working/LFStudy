//
//  ViewController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/9.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

#define metamacro_stringify(VALUE) \
metamacro_stringify_(VALUE)
#define metamacro_stringify_(VALUE) @#VALUE

#define NUMBER   10
#define ADD(a,b) (a+b)

#define STRINGIFY(S) #S
#define CALCULATE(A,B)   _CALCULATE(A,B)   // 转换宏
#define _CALCULATE(A,B)  A##10##B
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%d+%d=%d",NUMBER, NUMBER, ADD(NUMBER,NUMBER));
    NSLog(@"int max: %s",STRINGIFY(INT_MAX));
    NSLog(@"%d", CALCULATE(NUMBER,NUMBER));
}

@end
