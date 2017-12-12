//
//  LFTempViewController.m
//  转场动画
//
//  Created by 刘丰 on 2017/11/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTempViewController.h"
#import "LFSlideAnimatedTransitioning.h"
#import "LFSlideInteractiveTransition.h"

@interface LFTempViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) LFSlideAnimatedTransitioning *slideAnimatedTransitioning;

@property(nonatomic,strong) LFSlideInteractiveTransition *slideInteractiveTransition;

@property(nonatomic,assign) BOOL interactive;

@end

@implementation LFTempViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.transitioningDelegate = self;
}

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
    
    if (!self.navigationController) {
        UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenEdgePan:)];
        screenEdgePan.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:screenEdgePan];
    }
}

- (void)handleScreenEdgePan:(UIScreenEdgePanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    CGFloat percent = point.x/pan.view.frame.size.width;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactive = YES;
            [self dismissViewControllerAnimated:YES completion:nil];
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

//- (UIModalPresentationStyle)modalPresentationStyle {
//    return UIModalPresentationCustom;
//}

- (IBAction)back:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.slideAnimatedTransitioning.type = LFSlideAnimatedTypeModalPresent;
    return self.slideAnimatedTransitioning;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.slideAnimatedTransitioning.type = LFSlideAnimatedTypeModalDismiss;
    return self.slideAnimatedTransitioning;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactive ? self.slideInteractiveTransition : nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactive ? self.slideInteractiveTransition : nil;
}

@end
