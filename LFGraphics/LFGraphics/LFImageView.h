//
//  LFImageView.h
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFImageView : UIView

- (__kindof LFImageView *)initWithImage:(UIImage *)image;

@property(nonatomic,strong) UIImage *image;

@end
