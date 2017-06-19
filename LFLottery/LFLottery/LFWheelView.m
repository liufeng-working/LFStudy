//
//  LFWheelView.m
//  LFLottery
//
//  Created by 刘丰 on 2017/6/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFWheelView.h"
#import "LFButton.h"

@interface LFWheelView ()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property(nonatomic,weak) UIButton *lastBtn;

@property(nonatomic,strong) CADisplayLink *link;

@end

@implementation LFWheelView

- (CADisplayLink *)link
{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
//        _link.preferredFramesPerSecond = 2;
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _link;
}

+ (instancetype)wheelView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) { return nil; } else {
        return [[NSBundle mainBundle] loadNibNamed:@"LFWheelView" owner:nil options:nil].firstObject;;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat btnW = 40;
    CGFloat btnH = 143;
    for (NSInteger i = 0; i < 12; i ++) {
        UIButton *btn = [LFButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:[NSString stringWithFormat:@"%ld", (long)i] forState:UIControlStateNormal];
        btn.layer.bounds = CGRectMake(0, 0, btnW, btnH);
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = self.bgView.center;
        btn.transform = CGAffineTransformMakeRotation(M_PI*2/12*i);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
    }
}

- (void)rotation
{
    self.link.paused = NO;
}

- (void)stop
{
    self.link.paused = YES;
}

- (void)btnClick:(UIButton *)sender
{
    if (self.lastBtn == sender) { return; }
    sender.backgroundColor = [UIColor blueColor];
    self.lastBtn.backgroundColor = [UIColor redColor];
    self.lastBtn = sender;
    NSLog(@"%@", sender.currentTitle);
}

- (void)update
{
    self.bgView.transform = CGAffineTransformRotate(self.bgView.transform, M_PI/180);
}

- (IBAction)startSelect:(UIButton *)sender {
    
    CABasicAnimation *rotation = [CABasicAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.toValue = @(M_PI*2*6);
    rotation.duration = 1;
    rotation.delegate = self;
    [self.bgView.layer addAnimation:rotation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CGAffineTransform transform = self.lastBtn.transform;
    CGFloat angle = atan2(transform.b, transform.a);
    self.bgView.transform = CGAffineTransformMakeRotation(-angle);
}

@end
