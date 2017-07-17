//
//  ViewController.m
//  帧动画
//
//  Created by 刘丰 on 2017/7/15.
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
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[@0, @(M_PI*2), @(M_PI*4), @(M_PI*2), @(M_PI*4), @(M_PI*2)];
    rotation.duration = 15;
    [self.imageView.layer addAnimation:rotation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
