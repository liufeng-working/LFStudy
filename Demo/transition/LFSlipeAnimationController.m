//
//  LFSlipeAnimationController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/26.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFSlipeAnimationController.h"

@implementation LFSlipeAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromV = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toV = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGFloat duration = [self transitionDuration:transitionContext];
    UIView *containerView = [transitionContext containerView];
    if (toVC.isBeingPresented) {
        
        [containerView addSubview:toV];
        toV.frame = CGRectOffset(containerView.frame, CGRectGetWidth(containerView.frame), 0);
        [UIView animateWithDuration:duration animations:^{
            toV.frame = containerView.bounds;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
    
    if (fromVC.isBeingDismissed) {
        [UIView animateWithDuration:duration animations:^{
            fromV.frame = CGRectOffset(containerView.frame, CGRectGetWidth(containerView.frame), 0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

- (void)animationEnded:(BOOL)transitionCompleted {
    NSLog(@"%s", __func__);
}

@end
