//
//  ViewController.m
//  MVVM+ReactiveCocoa
//
//  Created by 刘丰 on 2017/8/5.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "LFNotification.h"
#import "LFLoginViewModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userTF;

@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property(nonatomic,strong) LFLoginViewModel *loginVM;

@end

@implementation ViewController

- (LFLoginViewModel *)loginVM
{
    if (!_loginVM) {
        _loginVM = [LFLoginViewModel new];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RAC(self.loginVM, user) = self.userTF.rac_textSignal;
    RAC(self.loginVM, pwd) = self.pwdTF.rac_textSignal;
    
    RAC(self.loginBtn, enabled) = self.loginVM.loginSignal;;
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.loginVM.loginCommand execute:nil];
    }];
}

- (IBAction)loginClick:(UIButton *)sender
{
    NSLog(@"点击了登录按钮");
}


@end
