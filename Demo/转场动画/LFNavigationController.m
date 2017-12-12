//
//  LFNavigationController.m
//  转场动画
//
//  Created by 刘丰 on 2017/11/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFNavigationController.h"
#import "LFSlideAnimatedTransitioning.h"
#import "LFSlideInteractiveTransition.h"

@interface LFNavigationController ()<UINavigationControllerDelegate>

@property(nonatomic,strong) LFSlideAnimatedTransitioning *slideAnimatedTransitioning;

@property(nonatomic,strong) LFSlideInteractiveTransition *slideInteractiveTransition;

@property(nonatomic,assign) BOOL interactive;

@end

@implementation LFNavigationController

- (LFSlideAnimatedTransitioning *)slideAnimatedTransitioning
{
    if (!_slideAnimatedTransitioning) {
        _slideAnimatedTransitioning = [[LFSlideAnimatedTransitioning alloc] init];
    }
    return _slideAnimatedTransitioning;
}

- (LFSlideInteractiveTransition *)slideInteractiveTransition
{
    if (!_slideInteractiveTransition) {
        _slideInteractiveTransition = [[LFSlideInteractiveTransition alloc] init];
    }
    return _slideInteractiveTransition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenEdgePan:)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:screenEdgePan];
}

- (void)handleScreenEdgePan:(UIScreenEdgePanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    CGFloat percent = point.x/pan.view.frame.size.width;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactive = YES;
            [self popViewControllerAnimated:YES];
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            [self.slideInteractiveTransition updateInteractiveTransition:percent];
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            self.interactive = NO;
            if (percent > 0.4) {
                [self.slideInteractiveTransition finishInteractiveTransition];
            }else {
                [self.slideInteractiveTransition cancelInteractiveTransition];
            }
        }
            break;
            
        default: {
            self.interactive = NO;
            [self.slideInteractiveTransition cancelInteractiveTransition];
        }
            break;
    }
}

#pragma mark -
#pragma mark - 代理
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    self.slideAnimatedTransitioning.type = (LFSlideAnimatedType)operation;
    return self.slideAnimatedTransitioning;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactive ? self.slideInteractiveTransition : nil;
}

@end
