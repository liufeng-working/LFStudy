//
//  LFSlideAnimatedTransitioning.h
//  转场动画
//
//  Created by 刘丰 on 2017/11/23.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LFSlideAnimatedType) {
    LFSlideAnimatedTypeNavigationPush = UINavigationControllerOperationPush,
    LFSlideAnimatedTypeNavigationPop = UINavigationControllerOperationPop,
    LFSlideAnimatedTypeTabbarLeft,
    LFSlideAnimatedTypeTabbarRight,
    LFSlideAnimatedTypeModalPresent,
    LFSlideAnimatedTypeModalDismiss,
};

@interface LFSlideAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign) LFSlideAnimatedType type;

@end
