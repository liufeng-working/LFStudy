//
//  LFMoveButton.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFMoveButton.h"

@implementation LFMoveButton

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.superview];
    self.center = point;
}

@end
