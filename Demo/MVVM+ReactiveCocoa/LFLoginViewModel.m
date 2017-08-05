//
//  LFLoginViewModel.m
//  LFStudy
//
//  Created by 刘丰 on 2017/8/5.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFLoginViewModel.h"

@interface LFLoginViewModel ()

@property(nonatomic,strong,readwrite) RACSignal *loginSignal;

@property(nonatomic,strong,readwrite) RACCommand *loginCommand;

@end

@implementation LFLoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self bindSignal];
    }
    return self;
}

- (void)bindSignal
{
    self.loginSignal = [RACSignal combineLatest:@[RACObserve(self, user), RACObserve(self, pwd)] reduce:^id _Nullable(NSString *user, NSString *pwd){
        return @(user.length && pwd.length);
    }];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"发送了登录请求");
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"登录成功"];
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
    
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [LFNotification autoHideWithText:x];
    }];
    
    [[self.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {//正在执行
            [LFNotification manuallyHideIndicatorWithText:@"登录中"];
        }
    }];
}

@end
