//
//  LFRedView.m
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFRedView.h"

@implementation LFRedView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.progress = 0.25;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (UIColor *)randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//rect,bounds
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"%s", __func__);
    NSLog(@"%@", NSStringFromCGRect(rect));
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClipToRect(ctx, rect);
    
//    UIRectClip(<#CGRect rect#>)
//    UIRectFill(<#CGRect rect#>)
    
    [self CTM];
}

- (void)CTM
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(ctx, 100, 50);
    CGContextScaleCTM(ctx, 0.5, 0.5);
    CGContextRotateCTM(ctx, M_PI/4);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 50, 300, 300));
    
    CGContextFillPath(ctx);
}

- (void)context
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextSaveGState(ctx);
    
    CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor.CGColor);
    CGContextSetLineWidth(ctx, 5);
    
    CGPathMoveToPoint(path, NULL, 10, 150);
    CGPathAddLineToPoint(path, NULL, 290, 150);
    
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
    CGPathMoveToPoint(path, NULL, 150, 10);
    CGPathAddLineToPoint(path, NULL, 150, 290);
    CGContextRestoreGState(ctx);
    
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
    CGPathRelease(path);
}

- (void)drawImage
{
    UIImage *logo = [UIImage imageNamed:@"logo"];
    [logo drawAsPatternInRect:self.bounds];
}

- (void)drawWords
{
    NSString *str = @"刘丰喜欢陈小贝";
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, 50);
    shadow.shadowColor = [UIColor blueColor];
    shadow.shadowBlurRadius = 1;
    NSDictionary *att = @{
                          NSFontAttributeName: [UIFont systemFontOfSize:50],
                          NSForegroundColorAttributeName: [UIColor greenColor],
                          NSStrokeWidthAttributeName: @2,
                          NSShadowAttributeName: shadow
                          };
    [str drawAtPoint:CGPointZero withAttributes:att];
}

- (void)drawPie
{
    NSArray *arr = @[@10, @20, @15, @30, @5];
    CGFloat sum = 0;
    for (NSNumber *num in arr) {
        sum += num.floatValue;
    }
    
    CGFloat start = 0;
    CGFloat end = 0;
    CGFloat angle = 0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (NSNumber *num in arr) {
        start = end;
        angle = num.floatValue/sum*(2*M_PI);
        end = start + angle;
        CGMutablePathRef path = CGPathCreateMutable();
        CGContextSetFillColorWithColor(ctx, self.randomColor.CGColor);
        CGPathAddArc(path, NULL, 125, 125, 100, start, end, NO);
        CGPathAddLineToPoint(path, NULL, 125, 125);
        CGContextAddPath(ctx, path);
        CGContextFillPath(ctx);
    }
}

- (void)drawArc
{
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 100) byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(50, 50)];
    
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 230, 200)];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(125, 125) radius:100 startAngle:0 endAngle:2*M_PI*self.progress clockwise:YES];
    [UIColor.whiteColor set];
    [path addLineToPoint:CGPointMake(125, 125)];
    [path fill];
}

- (void)drawRect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 5);
    CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor.CGColor);
    CGContextSetFillColorWithColor(ctx, UIColor.whiteColor.CGColor);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 100)];
    CGContextAddPath(ctx, path.CGPath);
    CGContextFillPath(ctx);
    CGContextStrokePath(ctx);
}

- (void)drawCurve
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 5);
    CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor.CGColor);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 200)];
    [path addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(100, 10)];
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

- (void)drawLine
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 10, 10);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextStrokePath(ctx);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 100)];
    [path addLineToPoint:CGPointMake(200, 20)];
    
    //    [path moveToPoint:CGPointMake(10, 150)];
    //    [path addLineToPoint:CGPointMake(200, 100)];
    
    [path addLineToPoint:CGPointMake(150, 200)];
    //    [path closePath];
    
    CGContextSetLineWidth(ctx, 10.f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
    
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathMoveToPoint(path1, NULL, 0, 0);
    CGPathAddLineToPoint(path1, NULL, 150, 100);
    CGContextAddPath(ctx, path1);
    CGContextStrokePath(ctx);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"%s", __func__);
}

@end
