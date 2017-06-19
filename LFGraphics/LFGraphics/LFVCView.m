//
//  LFVCView.m
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFVCView.h"

@implementation LFVCView

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(update) userInfo:nil repeats:YES];
//    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
//    link.preferredFramesPerSecond = 2;
//    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

static NSInteger _y = 0;
- (void)update
{
    NSLog(@"%@", @"update");
    _y += 300;
    if (_y > self.bounds.size.height) {
        _y = 0;
    }
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIImage *image = [UIImage imageNamed:@"star"];
    [image drawAtPoint:CGPointMake(0, _y)];
}

@end
