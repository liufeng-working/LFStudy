//
//  LFCoreAnimationViewController.m
//  LFAnimation
//
//  Created by 刘丰 on 2017/6/17.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFCoreAnimationViewController.h"

@interface LFCoreAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LFCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //CAAnimation
    //CAAnimationGroup
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.toValue = @0;
    animation.repeatCount = MAXFLOAT;
    animation.duration = 1;
    animation.autoreverses = YES;
    [self.imageView.layer addAnimation:animation forKey:nil];
    
    CABasicAnimation *basicA = [CABasicAnimation animation];
    basicA.keyPath = @"transform.rotation";
//    basicA.fromValue = @(-M_PI_2);
    basicA.toValue = @(M_PI_2);
    basicA.duration = 1;
    basicA.removedOnCompletion = NO;
    basicA.fillMode = kCAFillModeForwards;
    [self.redView.layer addAnimation:basicA forKey:nil];
}

@end
