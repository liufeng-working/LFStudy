//
//  LFHomeViewController.m
//  转场动画
//
//  Created by 刘丰 on 2017/11/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFHomeViewController.h"
#import "LFTempViewController.h"

@interface LFHomeViewController ()

@end

@implementation LFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//99366.087633
    CFTimeInterval time = [self.view.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    NSLog(@"%f", time);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    view.backgroundColor = [UIColor whiteColor];
    self.view.maskView = view;
    
    [UIView animateWithDuration:10 animations:^{
        view.frame = CGRectMake(0, 0, 500, 500);
    }];
}

@end
