//
//  ViewController.m
//  帧动画
//
//  Created by 刘丰 on 2017/7/15.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFMoveButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,weak) LFMoveButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LFMoveButton *btn = [[LFMoveButton alloc] initWithFrame:CGRectMake(50, 120, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    _btn = btn;
}

- (void)click
{
    NSLog(@"%@", [self targetForAction:@selector(touchesBegan:withEvent:) withSender:nil]);
    NSLog(@"%@", [self targetViewControllerForAction:@selector(touchesBegan:withEvent:) sender:nil]);
    [self dismissViewControllerAnimated:YES completion:nil];
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
