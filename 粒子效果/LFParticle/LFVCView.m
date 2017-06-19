//
//  LFVCView.m
//  LFParticle
//
//  Created by 刘丰 on 2017/6/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFVCView.h"

@interface LFVCView ()

@property(nonatomic,strong) UIBezierPath *path;

@property(nonatomic,weak) CALayer *dotLayer;

@end

@implementation LFVCView

- (UIBezierPath *)path
{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CALayer *dot = [CALayer layer];
    dot.frame = CGRectMake(-10, -10, 10, 10);
    dot.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:dot];
    _dotLayer = dot;
    
    CAReplicatorLayer *rLayer = (CAReplicatorLayer *)self.layer;
    rLayer.instanceCount = 30;
    rLayer.instanceDelay = 0.5;
}

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (void)drawRect:(CGRect)rect {
    [self.path stroke];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:sender.view];
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.path moveToPoint:point];
    }
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        [self.path addLineToPoint:point];
        [self setNeedsDisplay];
    }
}

- (void)start
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = self.path.CGPath;
    animation.repeatCount = MAXFLOAT;
    animation.duration = 5;
    [self.dotLayer addAnimation:animation forKey:nil];
}

- (void)redraw
{
    [self.dotLayer removeAllAnimations];
    self.path = nil;
    [self setNeedsDisplay];
}

@end
