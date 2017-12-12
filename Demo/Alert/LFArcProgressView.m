//
//  LFArcProgressView.m
//  Alert
//
//  Created by 刘丰 on 2017/11/21.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFArcProgressView.h"

#define lfArcProgressView_halfW CGRectGetWidth(self.frame)*0.5
#define lfArcProgressView_halfH CGRectGetHeight(self.frame)*0.5
@implementation LFArcProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefault];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupDefault];
}

- (void)setupDefault
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
    _lineColor = [UIColor colorWithWhite:1 alpha:1];
    _arcColor = [UIColor colorWithWhite:1 alpha:0.8];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 切割多余部分
    CGFloat minHalfWH = MIN(lfArcProgressView_halfW, lfArcProgressView_halfH);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(lfArcProgressView_halfW, lfArcProgressView_halfH) radius:minHalfWH startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = path.CGPath;
    self.layer.mask = mask;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat minHalfWH = MIN(lfArcProgressView_halfW, lfArcProgressView_halfH) - 1;
    
    // 外圆
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetFillColorWithColor(context, self.arcColor.CGColor);
    CGContextAddArc(context, lfArcProgressView_halfH, lfArcProgressView_halfH, minHalfWH, 0, M_PI*2, 0);
    CGContextStrokePath(context);
    
    // 进度弧形
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = M_PI*2*self.progress + startAngle;
    CGContextMoveToPoint(context, lfArcProgressView_halfW, lfArcProgressView_halfH);
    CGContextAddArc(context, lfArcProgressView_halfW, lfArcProgressView_halfH, minHalfWH, startAngle, endAngle, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
}

- (void)setProgress:(CGFloat)progress
{
    if (progress <= 0) {
        _progress = 0;
    }else if (progress >= 1) {
        _progress = 1;
    }else {
        _progress = progress;
    }
    
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    [self setNeedsDisplay];
}

- (void)setArcColor:(UIColor *)arcColor
{
    _arcColor = arcColor;
    
    [self setNeedsDisplay];
}

@end
