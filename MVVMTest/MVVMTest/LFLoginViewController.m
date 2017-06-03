//
//  LFLoginViewController.m
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFLoginViewController.h"
#import "ReactiveObjC.h"
#import "LFLoginViewModel.h"

int i = 10;

@interface LFLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property(nonatomic,strong) LFLoginViewModel *loginVM;

@end

@implementation LFLoginViewController

- (LFLoginViewModel *)loginVM
{
    if (!_loginVM) {
        _loginVM = [[LFLoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RAC(self.loginVM, user) = self.userTF.rac_textSignal;
    RAC(self.loginVM, pwd) = self.pwdTF.rac_textSignal;
    RAC(self.loginBtn, enabled) = self.loginVM.loginButtonEnableSignal;
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.view endEditing:YES];
        [self.loginVM.loginCommand execute:nil];
    }];
    
    [RACObserve(self.loginVM, loginData) subscribeNext:^(id  _Nullable x) {
        if (x) {
            [self performSegueWithIdentifier:@"to_main" sender:nil];
        }
    }];
}

@end
