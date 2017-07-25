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
    
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", [self targetForAction:@selector(touchesBegan:withEvent:) withSender:nil]);
    NSLog(@"%@", [self targetViewControllerForAction:@selector(touchesBegan:withEvent:) sender:nil]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
