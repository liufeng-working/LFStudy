//
//  LFView.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFView.h"

@implementation LFView

//找到最适合接收事件的view
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //1.判断自己能否接收事件
    if (self.userInteractionEnabled == NO ||
        self.hidden == YES ||
        self.alpha <= 0.01) {
        return nil;
    }
    
    //2.判断当前点是否在自己身上
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    //3.从后往前遍历自己的子控件，让子控件重复前两步动作
    __block UIView *hitView = nil;
    [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint subPoint = [self convertPoint:point toView:obj];
        hitView = [obj hitTest:subPoint withEvent:event];
        if (hitView) {
            *stop = YES;
        }
    }];
    
    if (hitView) {
        return hitView;
    }else {
        return self;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return [self isKindOfClass:NSClassFromString(@"LFWhiteView")];
    return [super pointInside:point withEvent:event];
//    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@->touchesBegan, %@", self.class, self.nextResponder.class);
    [super touchesBegan:touches withEvent:event];
}

@end
