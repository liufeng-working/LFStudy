//
//  LFPhotoBrowserAnimatedTransitioning.m
//  Alert
//
//  Created by 刘丰 on 2017/11/22.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFPhotoBrowserAnimatedTransitioning.h"

@implementation LFPhotoBrowserAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromV = fromVC.view;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toV = toVC.view;
    UIView *container = transitionContext.containerView;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (toVC.isBeingPresented) {
        // 做动画
        toV.transform = CGAffineTransformMakeScale(CGFLOAT_MIN, CGFLOAT_MIN);
        [container addSubview:toV];
        [UIView animateWithDuration:duration animations:^{
            toV.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
        
    if (fromVC.isBeingDismissed) {
        [UIView animateWithDuration:duration animations:^{
            fromV.alpha = CGFLOAT_MIN;
            fromV.transform = CGAffineTransformMakeScale(0.5, 0.5);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

@end
