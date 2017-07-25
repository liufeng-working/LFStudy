//
//  ViewController.m
//  transition
//
//  Created by 刘丰 on 2017/7/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFRedViewController.h"
#import "LFAnimationController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) LFAnimationController *animation;

@end

@implementation ViewController

- (LFAnimationController *)animation
{
    if (!_animation) {
        _animation = [LFAnimationController new];
    }
    return _animation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LFRedViewController *redVC = [LFRedViewController new];
    redVC.modalPresentationStyle = UIModalPresentationCustom;
//    redVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    redVC.transitioningDelegate = self;
    [self presentViewController:redVC animated:YES completion:nil];
}

#pragma mark -
#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.animation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.animation;
}

@end
