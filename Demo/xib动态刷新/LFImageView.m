//
//  LFImageView.m
//  LFStudy
//
//  Created by 刘丰 on 2017/8/11.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFImageView.h"

@implementation LFImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.layer.cornerRadius = 150;
//    self.layer.masksToBounds = YES;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
