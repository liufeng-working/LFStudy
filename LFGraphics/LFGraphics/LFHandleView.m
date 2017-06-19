//
//  LFHandleView.m
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/17.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFHandleView.h"

@interface LFHandleView ()

@property(nonatomic,weak) UIImageView *imageView;

@end

@implementation LFHandleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.bounds];
        imgV.userInteractionEnabled = YES;
        [self addSubview:imgV];
        _imageView = imgV;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [imgV addGestureRecognizer:pan];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [imgV addGestureRecognizer:pinch];
        
        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
        [imgV addGestureRecognizer:rotation];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [imgV addGestureRecognizer:longPress];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}


- (void)pan:(UIPanGestureRecognizer *)sender
{
    CGPoint trandP = [sender translationInView:sender.view];
    sender.view.transform = CGAffineTransformTranslate(sender.view.transform, trandP.x, trandP.y);
    [sender setTranslation:CGPointZero inView:sender.view];
}

- (void)pinch:(UIPinchGestureRecognizer *)sender
{
    sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
    [sender setScale:1];
}

- (void)rotation:(UIRotationGestureRecognizer *)sender
{
    sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
    [sender setRotation:0];
}

- (void)longPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.5 animations:^{
            sender.view.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                sender.view.alpha = 1;
            } completion:^(BOOL finished) {
                UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
                [self.layer renderInContext:UIGraphicsGetCurrentContext()];
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                if ([self.delegate respondsToSelector:@selector(handleView:newImage:)]) {
                    [self.delegate handleView:self newImage:image];
                }
                
                [self removeFromSuperview];
            }];
        }];
    }
}

@end
