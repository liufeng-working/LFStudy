//
//  LFApplication.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFApplication.h"

@implementation LFApplication

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@->touchesBegan, %@", self.class, self.nextResponder.class);
    [super touchesBegan:touches withEvent:event];
}

@end
