//
//  LFRedViewController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFRedViewController.h"

@interface LFRedViewController ()

@end

@implementation LFRedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 100, 50)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click
{
    NSLog(@"%@", [self targetForAction:@selector(touchesBegan:withEvent:) withSender:nil]);
    NSLog(@"%@", [self targetViewControllerForAction:@selector(touchesBegan:withEvent:) sender:nil]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
