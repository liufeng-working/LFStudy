//
//  LFViscousButton.m
//  QQ黏性效果
//
//  Created by 刘丰 on 2017/6/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFViscousButton.h"

#define lf_maxDistance     200
#define lf_dismissDistance 150
@interface LFViscousButton ()

@property(nonatomic,weak) UIView *fixView;

@property(nonatomic,weak) CAShapeLayer *shapeL;

@end

@implementation LFViscousButton

- (UIView *)fixView
{
    if (!_fixView) {
        UIView *fixView = [[UIView alloc] initWithFrame:self.frame];
        fixView.layer.cornerRadius = CGRectGetWidth(fixView.frame)*0.5;
        fixView.backgroundColor = [UIColor redColor];
        [self.superview insertSubview:fixView belowSubview:self];
        _fixView = fixView;
    }
    return _fixView;
}

- (CAShapeLayer *)shapeL
{
    if (!_shapeL) {
        CAShapeLayer *shapeL = [CAShapeLayer layer];
        shapeL.fillColor = [UIColor redColor].CGColor;
        shapeL.strokeColor = [UIColor redColor].CGColor;
        [self.superview.layer insertSublayer:shapeL atIndex:0];
        _shapeL = shapeL;
    }
    return _shapeL;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp
{
    self.layer.cornerRadius = CGRectGetWidth(self.frame)*0.5;
    self.backgroundColor = [UIColor redColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:panG];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint transP = [pan translationInView:pan.view];
    CGPoint center = self.center;
    center.x += transP.x;
    center.y += transP.y;
    self.center = center;
    [pan setTranslation:CGPointZero inView:pan.view];
    
    CGFloat distance = [self distanceWithSmall:self.fixView big:self];
    CGFloat scale = 1 - distance/lf_maxDistance;
    self.fixView.transform = CGAffineTransformMakeScale(scale, scale);
    
    UIBezierPath *path = [self pathWithSmall:self.fixView big:self];
    if (self.fixView.hidden == NO) {
        self.shapeL.path = path.CGPath;
    }
    
    if (distance > lf_dismissDistance) {
        self.fixView.hidden = YES;
        [self.shapeL removeFromSuperlayer];
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (distance <= lf_dismissDistance) {
            [self.shapeL removeFromSuperlayer];
            [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
                self.center = self.fixView.center;
            } completion:^(BOOL finished) {
                self.fixView.hidden = NO;
            }];
        }else {
            [UIView animateWithDuration:0.25 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
    }
}

- (UIBezierPath *)pathWithSmall:(UIView *)smallV big:(UIView *)bigV
{
    CGFloat distance = [self distanceWithSmall:smallV big:bigV];
    if (distance <= 0) { return nil; }

    UIView *view1, *view2;
    if (CGRectGetWidth(smallV.frame) < CGRectGetWidth(bigV.frame)) {
        view1 = smallV;
        view2 = bigV;
    }else {
        view1 = bigV;
        view2 = smallV;
    }
    
    CGFloat x1 = view1.center.x;
    CGFloat y1 = view1.center.y;
    CGFloat x2 = view2.center.x;
    CGFloat y2 = view2.center.y;
    
    CGFloat cosx = (y2 - y1)/distance;
    CGFloat sinx = (x2 - x1)/distance;
    
    CGFloat r1 = CGRectGetWidth(view1.frame)*0.5;
    CGFloat r2 = CGRectGetWidth(view2.frame)*0.5;
    
    CGPoint A = CGPointMake(x1 - r1*cosx, y1 + r1*sinx);
    CGPoint B = CGPointMake(x1 + r1*cosx, y1 - r1*sinx);
    CGPoint C = CGPointMake(x2 + r2*cosx, y2 - r2*sinx);
    CGPoint D = CGPointMake(x2 - r2*cosx, y2 + r2*sinx);
    CGPoint O = CGPointMake(A.x + distance*0.5*sinx, A.y + distance*0.5*cosx);
    CGPoint P = CGPointMake(B.x + distance*0.5*sinx, B.y + distance*0.5*cosx);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:A];
    [path addLineToPoint:B];
    [path addQuadCurveToPoint:C controlPoint:P];
    [path addLineToPoint:D];
    [path addQuadCurveToPoint:A controlPoint:O];
    return path;
}

- (CGFloat)distanceWithSmall:(UIView *)smallV big:(UIView *)bigV
{
    CGFloat x = smallV.center.x - bigV.center.x;
    CGFloat y = smallV.center.y - bigV.center.y;
    return sqrt(pow(x, 2) + pow(y, 2));
}

- (void)setHighlighted:(BOOL)highlighted {}

@end
