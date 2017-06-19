//
//  LFButton.m
//  LFLottery
//
//  Created by 刘丰 on 2017/6/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFButton.h"

@implementation LFButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat x = 0, y = 0, w = CGRectGetWidth(contentRect), h = 30;
    return CGRectMake(x, y, w, h);
}

@end
