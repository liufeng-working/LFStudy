//
//  LFClockView.m
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/15.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFClockView.h"

@interface LFClockView ()

@property(nonatomic,strong) NSMutableArray<UIButton *> *selectBtn;

@property(nonatomic,assign) CGPoint curP;

@end

@implementation LFClockView

- (NSMutableArray<UIButton *> *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [NSMutableArray array];
    }
    return _selectBtn;
}

- (void)drawRect:(CGRect)rect {
    
    if (!self.selectBtn.count) { return; }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 10;
    [[UIColor redColor] setStroke];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    [self.selectBtn enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [path moveToPoint:obj.center];
        }else {
            [path addLineToPoint:obj.center];
        }
    }];
    
    [path addLineToPoint:self.curP];
    
    [path stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    
    CGPoint point = [self getCurrentPoint:touches];
    UIButton *btn = [self btnRectContainPoint:point];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectBtn addObject:btn];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    
    CGPoint point = [self getCurrentPoint:touches];
    self.curP = point;
    UIButton *btn = [self btnRectContainPoint:point];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectBtn addObject:btn];
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    
    NSMutableString *password = [NSMutableString string];
    [self.selectBtn enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
        [password appendFormat:@"%lu", (unsigned long)obj.tag];
    }];
    
    NSLog(@"%@", password);
    [self.selectBtn removeAllObjects];
    [self setNeedsDisplay];
}

- (CGPoint)getCurrentPoint:(NSSet<UITouch *> *)touches
{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

static NSInteger WH = 40;
- (UIButton *)btnRectContainPoint:(CGPoint)point
{
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(CGRectMake(btn.center.x - WH*0.5, btn.center.y - WH*0.5, WH, WH), point)) {
            return btn;
        }
    }
    return nil;
}

@end
