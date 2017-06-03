//
//  LFModelViewController.m
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/5/31.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFModelViewController.h"
#import "ReactiveObjC.h"

@interface LFModelViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userTF;

@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property(nonatomic,strong) RACSignal *signal;

@end

@implementation LFModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    self.signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSLog(@"%@", self);
        return nil;
    }];
    
    //组合
    RAC(self.backBtn, enabled) = [RACSignal combineLatest:@[self.userTF.rac_textSignal, self.pwdTF.rac_textSignal] reduce:^id _Nullable(NSString *user, NSString *pwd){
        //reduce:就是组合信号的内容
        //reduce:其实是有参数的，组合多少个信号就有多少个参数
        return @(user.length && pwd.length);
    }];
}

- (IBAction)dissmiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
