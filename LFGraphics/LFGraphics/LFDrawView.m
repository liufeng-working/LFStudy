//
//  LFDrawView.m
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/16.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFDrawView.h"

@interface LFBezierPath : UIBezierPath

@property(nonatomic,strong) UIColor *color;

@end

@interface LFDrawView ()

@property(nonatomic,strong) NSMutableArray *lins;

@property(nonatomic,assign) CGFloat lineW;

@property(nonatomic,strong) UIColor *lineC;

@end

@implementation LFDrawView

- (NSMutableArray *)lins
{
    if (!_lins) {
        _lins = [NSMutableArray array];
    }
    return _lins;
}

- (CGFloat)lineW
{
    if (!_lineW) {
        _lineW = 5;
    }
    return _lineW;
}

- (UIColor *)lineC
{
    if (!_lineC) {
        _lineC = [UIColor blackColor];
    }
    return _lineC;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self.lins enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LFBezierPath class]]) {
            LFBezierPath *path = (LFBezierPath *)obj;
            [path.color setStroke];
            [path stroke];
        }
        
        if ([obj isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)obj;
            [image drawInRect:rect];
        }
    }];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:sender.view];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            LFBezierPath *path = [LFBezierPath bezierPath];
            path.lineWidth = self.lineW;
            path.color = self.lineC;
            [path moveToPoint:point];
            [self.lins addObject:path];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            [self.lins.lastObject addLineToPoint:point];
            [self setNeedsDisplay];
        }
            break;
        case UIGestureRecognizerStateEnded: {
        }
            break;
            
        default:
            break;
    }
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self.lins addObject:image];
    [self setNeedsDisplay];
}

- (void)clear
{
    [self.lins removeAllObjects];
    [self setNeedsDisplay];
}

- (void)revoke
{
    [self.lins removeLastObject];
    [self setNeedsDisplay];
}

- (void)eraser
{
    self.lineC = UIColor.whiteColor;
}

- (void)setColor:(UIColor *)color
{
    self.lineC = color;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    self.lineW = lineWidth;
}

@end

@implementation LFBezierPath

@end
