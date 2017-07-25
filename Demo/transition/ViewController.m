//
//  ViewController.m
//  transition
//
//  Created by 刘丰 on 2017/7/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFRedViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LFRedViewController *redVC = [LFRedViewController new];
//    [self showViewController:redVC sender:nil];
    redVC.modalPresentationStyle = UIModalPresentationCustom;
//    redVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:redVC animated:NO completion:nil];
}

@end
