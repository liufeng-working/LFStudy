//
//  ViewController.m
//  Alert
//
//  Created by 刘丰 on 2017/11/21.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFNotification.h"
#import "MBProgressHUD.h"
#import "LFArcProgressView.h"
#import "LFPhotoBrowserViewController.h"
#import "LFPhotoBrowserAnimatedTransitioning.h"

@interface ViewController ()

@property(nonatomic,weak) NSTimer *timer;

@property(nonatomic,weak) LFArcProgressView *arcView;

@property(nonatomic,assign) NSTimeInterval time;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    LFArcProgressView *arcView = [[LFArcProgressView alloc] initWithFrame:CGRectMake(100, 100, 70, 70)];
    [self.view addSubview:arcView];
    _arcView = arcView;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(hangleTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (IBAction)show:(id)sender {
    _time = 0;
    
    LFPhotoBrowserViewController *pbVC = [[LFPhotoBrowserViewController alloc] init];
    pbVC.urls = @[[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511326300347&di=e8c6323ee27a4ab3a849385de6018d55&imgtype=0&src=http%3A%2F%2Fwww.xp71.com%2Fuploads%2Fallimg%2F150611%2F1-1506111102063Z.jpg"], [NSURL URLWithString:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=4286180935,1446563086&fm=27&gp=0.jpg"], [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111735926.jpg"], [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111635470.jpg"], [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111425913.jpg"], [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111336031.jpg"], [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111253175.jpg"], [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111105360.jpg"], [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111020939.jpg"], [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023110923696.jpg"], [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023110844367.jpg"]];
    pbVC.currentIndex = 0;
    [pbVC showIn:self];
}

- (IBAction)hide:(id)sender {
}

#pragma mark -
#pragma mark - 定时器
- (void)hangleTimer
{
    self.arcView.progress = _time;
    _time += 0.01;
    
    if (_time >= 0.5) {
        self.arcView.frame = CGRectMake(150, 150, 100, 100);
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
