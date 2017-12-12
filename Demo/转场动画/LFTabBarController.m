//
//  LFTabBarController.m
//  转场动画
//
//  Created by 刘丰 on 2017/11/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTabBarController.h"
#import "LFSlideAnimatedTransitioning.h"
#import "LFSlideInteractiveTransition.h"

@interface LFTabBarController ()<UITabBarControllerDelegate>

@property(nonatomic,strong) LFSlideAnimatedTransitioning *slideAnimatedTransitioning;

@property(nonatomic,strong) LFSlideInteractiveTransition *slideInteractiveTransition;

@property(nonatomic,assign) BOOL interactive;

@end

@implementation LFTabBarController

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
    
    UIScreenEdgePanGestureRecognizer *screenEdgePanLeft = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenEdgePan:)];
    screenEdgePanLeft.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePanLeft];
    
    UIScreenEdgePanGestureRecognizer *screenEdgePanRight = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenEdgePan:)];
    screenEdgePanRight.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:screenEdgePanRight];
}

- (void)handleScreenEdgePan:(UIScreenEdgePanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    
    CGFloat percent = fabs(point.x/pan.view.frame.size.width);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactive = YES;
            
            if (point.x < 0 ) {
                [self setSelectedIndex:self.selectedIndex + 1];
            }else {
                [self setSelectedIndex:self.selectedIndex - 1];
            }
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
#pragma mark - UITabBarControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSInteger fromIndex = [tabBarController.viewControllers indexOfObject:fromVC];
        NSInteger toIndex = [tabBarController.viewControllers indexOfObject:toVC];
    self.slideAnimatedTransitioning.type = fromIndex < toIndex ? LFSlideAnimatedTypeTabbarRight : LFSlideAnimatedTypeTabbarLeft;
    return self.slideAnimatedTransitioning;
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactive ? self.slideInteractiveTransition : nil;
}

@end
