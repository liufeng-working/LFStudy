//
//  ViewController.m
//  图标抖动
//
//  Created by 刘丰 on 2017/6/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(200, 100)];
    [path addLineToPoint:CGPointMake(200, 500)];
    animation1.path = path.CGPath;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 0.25;
    animation.values = @[@0, @(-M_PI/36), @(M_PI/36), @0];
    animation.repeatCount = MAXFLOAT;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 10;
    group.animations = @[animation, animation1];
    
    [self.imageView.layer addAnimation:group forKey:nil];
}

@end
