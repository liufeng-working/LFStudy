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
#import "LFSlipeAnimationController.h"
#import "LFTansitionNavigationController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) LFAnimationController *animation;

@property(nonatomic,strong) LFSlipeAnimationController *slipeAnimaion;

@property(nonatomic,assign) BOOL isActive;
@property(nonatomic,strong) UIPercentDrivenInteractiveTransition *interactive;

@end

@implementation ViewController

- (LFAnimationController *)animation
{
    if (!_animation) {
        _animation = [LFAnimationController new];
    }
    return _animation;
}

- (LFSlipeAnimationController *)slipeAnimaion
{
    if (!_slipeAnimaion) {
        _slipeAnimaion = [LFSlipeAnimationController new];
    }
    return _slipeAnimaion;
}

- (UIPercentDrivenInteractiveTransition *)interactive
{
    if (!_interactive) {
        _interactive = [UIPercentDrivenInteractiveTransition new];
    }
    return _interactive;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIPresentationController
//    UIViewPropertyAnimator
    
    UICollectionViewController *cccc;
    cccc.useLayoutToLayoutNavigationTransitions
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIScreenEdgePanGestureRecognizer *screenPan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePanGesture:)];
    screenPan.edges = UIRectEdgeLeft;
    LFRedViewController *redVC = [LFRedViewController new];
    redVC.modalPresentationStyle = UIModalPresentationCustom;
    redVC.transitioningDelegate = self;
    [redVC.view addGestureRecognizer:screenPan];
    [self presentViewController:redVC animated:YES completion:nil];
}

- (void)handleEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)pan
{
    //根据移动距离计算交互过程的进度。
    CGPoint ppp = [pan translationInView:pan.view];
    CGFloat percent = ppp.x/pan.view.frame.size.width;
//    NSLog(@"percent:%f", percent);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            
            //更新交互状态
            self.isActive = YES;
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            //2.更新进度：
            [self.interactive updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            
            NSLog(@"%@", NSStringFromCGPoint([pan velocityInView:pan.view]));
            //3.结束转场：
            if (percent > 0.4) {
                //完成转场。
                [self.interactive finishInteractiveTransition];
            }else{
                //或者，取消转场。
                [self.interactive cancelInteractiveTransition];
            }
            //无论转场的结果如何，恢复为非交互状态。
            self.isActive = NO;
        }
            break;
        default: {
            self.isActive = NO;
        }
            break;
    }
}

#pragma mark -
#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.slipeAnimaion;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.slipeAnimaion;
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//    return self.interactive;
//}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.isActive ? self.interactive : nil;
}

@end
