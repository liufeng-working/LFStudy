//
//  LFRACViewController.m
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/6/12.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFRACViewController.h"
#import "NSObject+LFCaculator.h"
#import "LFCaculator.h"
#import "ReactiveObjC.h"

@interface LFRACViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation LFRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@123];
        [subscriber sendCompleted];
        
        return nil;
    }] doNext:^(id  _Nullable x) {
        NSLog(@"doNext-%@", x);
    }] doCompleted:^{
        NSLog(@"doCompleted");
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [[[RACSignal interval:1 onScheduler:[RACScheduler currentScheduler]] delay:20] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)test
{
    NSInteger result = [NSObject makeCaculator:^(LFCaculatorMaker *maker) {
        maker.add(1).add(2).add(3);
    }];
    
    NSLog(@"%ld", (long)result);
    
    LFCaculator *cc = [LFCaculator new];
    
    NSInteger isequal = [[[cc caculator:^NSInteger(NSInteger value) {
        value += 10;
        value *= 4;
        value *= 30;
        value *= 40;
        return value;
    }] equal:^BOOL(NSInteger value) {
        return value == 100;
    }] result];
    
    NSLog(@"%ld", (long)isequal);
}

@end
