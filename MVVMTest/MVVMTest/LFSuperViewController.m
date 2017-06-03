//
//  LFSuperViewController.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

/**
 父子控制器：当有多个控制器，交给一个大控制器去管理
 导航控制器，标签控制器
 */

#import "LFSuperViewController.h"
#import "LFSocialViewController.h"
#import "LFHotViewController.h"
#import "LFTopViewController.h"

@interface LFSuperViewController ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation LFSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController];
    
    [self selectIndex:0];
}

- (IBAction)click:(UIButton *)sender {
    [self selectIndex:sender.tag];
}

- (void)selectIndex:(NSInteger)index
{
    UIView *lastV;
    if (self.contentView.subviews.count) {
        lastV = self.contentView.subviews.firstObject;
    }
    UIViewController *childVC = self.childViewControllers[index];
    childVC.view.frame = self.contentView.bounds;
    [self.contentView addSubview:childVC.view];
    [lastV removeFromSuperview];
}

- (void)addChildViewController
{
    LFSocialViewController *socialVC = [[LFSocialViewController alloc] init];
    [self addChildViewController:socialVC];
    
    LFHotViewController *hotVC = [[LFHotViewController alloc] init];
    [self addChildViewController:hotVC];
    
    LFTopViewController *topVC = [[LFTopViewController alloc] init];
    [self addChildViewController:topVC];
}

@end
