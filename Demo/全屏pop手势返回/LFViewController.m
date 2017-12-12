//
//  LFViewController.m
//  全屏pop手势返回
//
//  Created by 刘丰 on 2017/11/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFViewController.h"

@interface LFViewController ()

@end

@implementation LFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
