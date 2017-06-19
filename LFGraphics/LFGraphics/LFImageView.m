//
//  LFImageView.m
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFImageView.h"

@implementation LFImageView

- (__kindof LFImageView *)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _image = image;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self.image drawInRect:rect];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    NSLog(@"%s", __func__);
    [self setNeedsDisplay];
}

@end
