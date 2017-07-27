//
//  LFTansitionNavigationController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTansitionNavigationController.h"
#import "LFSlipeAnimationController.h"

@interface LFTansitionNavigationController ()<UINavigationControllerDelegate>

@property(nonatomic,assign) BOOL interactive;

@property(nonatomic,strong) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation LFTansitionNavigationController

- (UIPercentDrivenInteractiveTransition *)interactionController
{
    if (!_interactionController) {
        _interactionController = [UIPercentDrivenInteractiveTransition new];
    }
    return _interactionController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.delegate = self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0) {
    return LFSlipeAnimationController.new;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0){
    return self.interactive ? self.interactionController : nil;
}

@end
