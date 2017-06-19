//
//  LFWatchViewController.m
//  LFAnimation
//
//  Created by 刘丰 on 2017/6/17.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFWatchViewController.h"

#define kAndleToRadian(angel) ((angel)/180*M_PI)

static CGFloat anglePerSecond  = 6;
static CGFloat anglePerMinute  = 6;
static CGFloat anglePerHour    = 30;
static CGFloat anglePerSecHour = 0.5;
@interface LFWatchViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *clockView;

@property(nonatomic,weak) CALayer *secLayer;
@property(nonatomic,weak) CALayer *minLayer;
@property(nonatomic,weak) CALayer *hourLayer;

@property(nonatomic,strong) CADisplayLink *link;

@end

@implementation LFWatchViewController

- (CADisplayLink *)link
{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotation)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _link;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addHour];
    [self addMinute];
    [self addSecond];
    
    self.link.preferredFramesPerSecond = 1;
}

- (void)addSecond
{
    CALayer *secLayer = [CALayer layer];
    secLayer.backgroundColor = [UIColor redColor].CGColor;
    secLayer.bounds = CGRectMake(0, 0, 1, 60);
    secLayer.anchorPoint = CGPointMake(0.5, 1);
    secLayer.position = CGPointMake(CGRectGetWidth(self.clockView.frame)*0.5, CGRectGetHeight(self.clockView.frame)*0.5);
    [self.clockView.layer addSublayer:secLayer];
    _secLayer = secLayer;
}

- (void)addMinute
{
    CALayer *minLayer = [CALayer layer];
    minLayer.backgroundColor = [UIColor blackColor].CGColor;
    minLayer.bounds = CGRectMake(0, 0, 3, 55);
    minLayer.anchorPoint = CGPointMake(0.5, 1);
    minLayer.position = CGPointMake(CGRectGetWidth(self.clockView.frame)*0.5, CGRectGetHeight(self.clockView.frame)*0.5);
    [self.clockView.layer addSublayer:minLayer];
    _minLayer = minLayer;
}

- (void)addHour
{
    CALayer *hourLayer = [CALayer layer];
    hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    hourLayer.bounds = CGRectMake(0, 0, 3, 50);
    hourLayer.anchorPoint = CGPointMake(0.5, 1);
    hourLayer.position = CGPointMake(CGRectGetWidth(self.clockView.frame)*0.5, CGRectGetHeight(self.clockView.frame)*0.5);
    [self.clockView.layer addSublayer:hourLayer];
    _hourLayer = hourLayer;
}

- (void)rotation
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *com = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    NSUInteger second = com.second + 1;
    [self.secLayer setValue:@(kAndleToRadian(second*anglePerSecond)) forKeyPath:@"transform.rotation"];
    
    NSUInteger minute = com.minute;
    [self.minLayer setValue:@(kAndleToRadian(minute*anglePerMinute)) forKeyPath:@"transform.rotation"];
    
    NSUInteger hour = com.hour;
    [self.hourLayer setValue:@(kAndleToRadian(hour*anglePerHour + minute*anglePerSecHour)) forKeyPath:@"transform.rotation"];
}

@end
