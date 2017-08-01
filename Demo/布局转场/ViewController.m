//
//  ViewController.m
//  布局转场
//
//  Created by 刘丰 on 2017/7/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFLayoutViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.view.center];
    [path addCurveToPoint:CGPointMake(23, 10) controlPoint1:CGPointMake(150, 150) controlPoint2:CGPointMake(200, 200)];
    CAShapeLayer *shapeL = [CAShapeLayer layer];
    shapeL.path = path.CGPath;
    [self.view.layer addSublayer:shapeL];
}

- (void)click
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 50);
    LFLayoutViewController *vc = [[LFLayoutViewController alloc] initWithCollectionViewLayout:layout];
    vc.title = @"年度";
    vc.useLayoutToLayoutNavigationTransitions = false;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
    NSLog(@"%@", nav.interactivePopGestureRecognizer);
}

@end
