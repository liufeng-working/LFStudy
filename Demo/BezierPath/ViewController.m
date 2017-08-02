//
//  ViewController.m
//  BezierPath
//
//  Created by 刘丰 on 2017/8/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self demo];
}

- (void)demo
{
    CGSize size = CGSizeMake(self.view.frame.size.width, 400);
    CGFloat layerHeight = size.height*0.2;
    CAShapeLayer *shape = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, size.height - layerHeight)];
    [path addLineToPoint:CGPointMake(0, size.height - 1)];
    [path addLineToPoint:CGPointMake(size.width, size.height - 1)];
    [path addLineToPoint:CGPointMake(size.width, size.height - layerHeight)];
    [path addQuadCurveToPoint:CGPointMake(0, size.height - layerHeight) controlPoint:CGPointMake(size.width/2, size.height - layerHeight - 50)];
    shape.path = path.CGPath;
    shape.fillColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:shape];
}

- (void)animation
{
    CGPoint startPoint = CGPointMake(50, 300);
    CGPoint endPoint = CGPointMake(300, 300);
    CGPoint controlPoint1 = CGPointMake(170, 200);
    CGPoint controlPoint2 = CGPointMake(180, 400);
    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    [path moveToPoint:startPoint];
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    layer.path = path.CGPath;
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.strokeColor = UIColor.blackColor.CGColor;
    layer.strokeStart = 0.5;
    layer.strokeEnd = 0.5;
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *start = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    start.toValue = @0;
    start.duration = 1;
    start.autoreverses = YES;
    start.repeatCount = MAXFLOAT;
    [layer addAnimation:start forKey:nil];
    
    CABasicAnimation *end = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    end.toValue = @1;
    end.duration = 1;
    end.autoreverses = YES;
    end.repeatCount = MAXFLOAT;
    [layer addAnimation:end forKey:nil];
}

- (void)curve
{
    CGPoint startPoint = CGPointMake(50, 300);
    CGPoint endPoint = CGPointMake(300, 300);
    CGPoint controlPoint = CGPointMake(170, 200);
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(startPoint.x, startPoint.y, 5, 5);
    layer1.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer1];
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(endPoint.x, endPoint.y, 5, 5);
    layer2.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer2];
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(controlPoint.x, controlPoint.y, 5, 5);
    layer3.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer3];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    layer.path = path.CGPath;
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.strokeColor = UIColor.blackColor.CGColor;
    
    [self.view.layer addSublayer:layer];
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
    [self.view.layer addSublayer:layer3];
}

- (void)circle
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:layer];
}

- (void)circleRect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 150, 100) cornerRadius:20];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:layer];
}

- (void)path
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(110, 100, 150, 100)];
    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame = CGRectMake(0, 0, 200, 200);
    layer.path = path.CGPath;
    layer.backgroundColor = [UIColor greenColor].CGColor;
//    layer.strokeColor = [UIColor redColor].CGColor;
//    layer.fillColor = [UIColor clearColor].CGColor;
    layer.masksToBounds = YES;
    [self.view.layer addSublayer:layer];
    NSLog(@"%@", NSStringFromCGRect(layer.frame));
}

- (void)normal
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(110, 100, 150, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
}

@end
