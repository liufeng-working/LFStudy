//
//  ViewController.m
//  GCD
//
//  Created by 刘丰 on 2017/7/16.
//  Copyright © 2017年 liufeng. All rights reserved.
//  重点

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,assign) BOOL finish;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self group];
}

#pragma mark -
#pragma mark - 组
- (void)group
{
    
}

#pragma mark -
#pragma mark - 快速迭代
- (void)apply
{
    
    dispatch_apply(10000, dispatch_get_global_queue(0, 0), ^(size_t idx) {
        NSLog(@"apply-%zu", idx);
    });
}

#pragma mark -
#pragma mark - 栅栏函数
- (void)barrier
{
    //栅栏函数只能用自己创建的队列
    dispatch_queue_t queue = dispatch_queue_create("liufeng", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"1--%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"2--%@", [NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"栅栏--%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSLog(@"3--%@", [NSThread currentThread]);
        }
    });
}

@end
