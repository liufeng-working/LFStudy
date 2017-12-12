//
//  LFPopNavigationController.m
//  全屏pop手势返回
//
//  Created by 刘丰 on 2017/11/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFPopNavigationController.h"
#import <objc/runtime.h>

@interface LFPopNavigationController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIPanGestureRecognizer *popGestureRecognizer;

@end

@implementation LFPopNavigationController

- (UIPanGestureRecognizer *)popGestureRecognizer
{
    if (!_popGestureRecognizer) {
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL intetnalAction = NSSelectorFromString(@"handleNavigationTransition:");
        _popGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:internalTarget action:intetnalAction];
        _popGestureRecognizer.maximumNumberOfTouches = 1;
        _popGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return _popGestureRecognizer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.popGestureRecognizer];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self.superclass.class, &count);
    for (NSInteger i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s-%s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
}

#pragma mark -
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.viewControllers.count > 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end


