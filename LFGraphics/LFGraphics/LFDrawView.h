//
//  LFDrawView.h
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/16.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFDrawView : UIView

@property(nonatomic,strong) UIImage *image;

- (void)clear;

- (void)revoke;

- (void)eraser;

- (void)setColor:(UIColor *)color;

- (void)setLineWidth:(CGFloat)lineWidth;

@end
