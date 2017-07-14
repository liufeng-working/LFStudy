//
//  LFView.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFView.h"

@implementation LFView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint currentP = [touch locationInView:self.superview];
    CGPoint previousP = [touch previousLocationInView:self.superview];
    
    self.transform = CGAffineTransformTranslate(self.transform, currentP.x - previousP.x, currentP.y - previousP.y);
}

@end
