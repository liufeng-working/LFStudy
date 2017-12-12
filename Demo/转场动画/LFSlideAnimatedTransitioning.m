//
//  LFSlideAnimatedTransitioning.m
//  转场动画
//
//  Created by 刘丰 on 2017/11/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFSlideAnimatedTransitioning.h"

@implementation LFSlideAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromV = fromVC.view;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toV = toVC.view;
    UIView *containerV = transitionContext.containerView;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // 需要注意UIModalPresentationCustom这个模式下，不能执行下面下句
    [containerV addSubview:toV];
    
    switch (self.type) {
        case LFSlideAnimatedTypeTabbarLeft:
        case LFSlideAnimatedTypeNavigationPop:
        case LFSlideAnimatedTypeModalDismiss: {
            toV.frame = CGRectOffset(containerV.frame, -containerV.frame.size.width, 0);
            [UIView animateWithDuration:duration animations:^{
                toV.frame = containerV.frame;
                fromV.frame = CGRectOffset(containerV.frame, containerV.frame.size.width, 0);
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
        }
            break;
        case LFSlideAnimatedTypeTabbarRight:
        case LFSlideAnimatedTypeNavigationPush:
        case LFSlideAnimatedTypeModalPresent: {
            toV.frame = CGRectOffset(containerV.frame, containerV.frame.size.width, 0);
            [UIView animateWithDuration:duration animations:^{
                toV.frame = containerV.frame;
                fromV.frame = CGRectOffset(containerV.frame, -containerV.frame.size.width, 0);
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
        }
            break;
    }
}

@end
