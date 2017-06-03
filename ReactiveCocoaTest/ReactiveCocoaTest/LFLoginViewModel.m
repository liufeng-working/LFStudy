//
//  LFLoginViewModel.m
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFLoginViewModel.h"
#import "LFNotification.h"

@implementation LFLoginViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

/**
 初始化
 */
- (void)setup
{
    _loginButtonEnableSignal = [RACSignal combineLatest:@[RACObserve(self, user), RACObserve(self, pwd)] reduce:^id _Nullable(NSString *user, NSString *pwd){
        return @(user.length && pwd.length);
    }];
    
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //发送数据
                [subscriber sendNext:[NSString stringWithFormat:@"%@:%@+%@", @"登陆的数据", self.user, self.pwd]];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [self willChangeValueForKey:@"loginData"];
        _loginData = x;
        [self didChangeValueForKey:@"loginData"];
    }];
    
    [[self.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if (x.boolValue) {
            [LFNotification manuallyHideIndicatorWithText:@"正在登录"];
        }else {
            [LFNotification hideNotification];
        }
    }];
}

@end
