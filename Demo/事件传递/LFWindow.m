//
//  LFWindow.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFWindow.h"

@implementation LFWindow

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@->touchesBegan, %@, %d", self.class, self.nextResponder.class, self.isFirstResponder);
    [super touchesBegan:touches withEvent:event];
}

@end
