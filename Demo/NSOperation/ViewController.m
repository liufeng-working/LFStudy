//
//  ViewController.m
//  NSOperation
//
//  Created by 刘丰 on 2017/7/16.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", LFPerson.name);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self queue];
}

- (void)queue
{
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test) object:nil];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:invocation];
}

- (void)invocation
{
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test) object:nil];
    [invocation start];
}

- (void)block
{
    NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1-%@", [NSThread currentThread]);
    }];
    
    [block addExecutionBlock:^{
        NSLog(@"1-%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *block1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    [block start];
    [block1 start];
}

- (void)test
{
    NSLog(@"%@", [NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
