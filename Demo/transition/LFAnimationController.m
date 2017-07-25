//
//  LFAnimationController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFAnimationController.h"

@implementation LFAnimationController

#pragma mark -
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    CGFloat duration = [self transitionDuration:transitionContext];
    
    //不像容器VC转场里需要额外的变量来标记操作类型，UIViewController 自身就有方法跟踪 Modal 状态。
    //处理 Presentation 转场：
    if ([toVC isBeingPresented]) {
        //1
        //在 presentedView 后面添加暗背景视图 dimmingView，注意两者在 containerView 中的位置。
        UIView *dimmingView = UIView.new;
        [containerView addSubview:dimmingView];
        
        [containerView addSubview:toView];
        
        CGFloat contentW = containerView.frame.size.width;
        CGFloat contentH = containerView.frame.size.height;
        
        dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        dimmingView.frame = containerView.bounds;
        
        //设置 presentedView 和 暗背景视图 dimmingView 的初始位置和尺寸。
        CGFloat toViewWidth = contentW*2/3;
        CGFloat toViewHeight = contentH*2/3;
        toView.center = containerView.center;
        toView.bounds = CGRectMake(0, 0, 0, toViewHeight);
        toView.transform = CGAffineTransformMakeRotation(M_PI);
        
        //实现出现时的尺寸变化的动画：
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //2
            BOOL isCancelled = transitionContext.transitionWasCancelled;
            [transitionContext completeTransition:!isCancelled];
        }];
    }
    //处理 Dismissal 转场，按照上一小节的结论，Custom 模式下不要将 toView 添加到 containerView，省去了上面标记1处的操作；
    if (fromVC.isBeingDismissed){
        CGFloat fromViewHeight = fromView.frame.size.height;
        fromView.transform = CGAffineTransformMakeRotation(M_PI);
        [UIView animateWithDuration:duration animations:^{
            fromView.transform = CGAffineTransformIdentity;
            fromView.bounds = CGRectMake(0, 0, 0, fromViewHeight);
        } completion:^(BOOL finished) {
            BOOL isCancelled = transitionContext.transitionWasCancelled;
            [transitionContext completeTransition:!isCancelled];
        }];
    }
}

@end
