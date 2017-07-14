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
    
    return [super hitTest:point withEvent:event];
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
