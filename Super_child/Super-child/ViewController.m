//
//  ViewController.m
//  Super-child
//
//  Created by 刘丰 on 2017/6/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFTopViewController.h"
#import "LFHotViewController.h"
#import "LFVideoViewController.h"
#import "LFSocialViewController.h"
#import "LFReadViewController.h"
#import "LFScienceViewController.h"

#define kScale 1.3
#define kNormalColor [UIColor blueColor]
#define kSelectColor [UIColor redColor]
@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property(nonatomic,weak) UILabel *lastL;

@property(nonatomic,strong) NSMutableArray *labelArr;

@end

@implementation ViewController

- (NSMutableArray *)labelArr
{
    if (!_labelArr) {
        _labelArr = [NSMutableArray array];
    }
    return _labelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addChildViewController];
    
    [self topScrollViewTitle];
}

- (void)addChildViewController
{
    LFTopViewController *topVC = [[LFTopViewController alloc] init];
    [self addChildViewController:topVC];
    
    LFHotViewController *hotVC = [[LFHotViewController alloc] init];
    [self addChildViewController:hotVC];
    
    LFVideoViewController *videoVC = [[LFVideoViewController alloc] init];
    [self addChildViewController:videoVC];
    
    LFSocialViewController *socialVC = [[LFSocialViewController alloc] init];
    [self addChildViewController:socialVC];
    
    LFReadViewController *readVC = [[LFReadViewController alloc] init];
    [self addChildViewController:readVC];
    
    LFScienceViewController *scienceVC = [[LFScienceViewController alloc] init];
    [self addChildViewController:scienceVC];
    
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count*CGRectGetWidth(self.contentScrollView.bounds), CGRectGetHeight(self.contentScrollView.bounds));
}

- (void)topScrollViewTitle
{
    CGFloat lW = 100;
    CGFloat lH = 44;
    NSArray *titles = @[@"头条", @"热点", @"视频", @"社会", @"订阅", @"科学"];
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(idx*lW, 0, lW, lH)];
        label.tag = idx;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = obj;
        label.textColor = kNormalColor;
        label.highlightedTextColor = kSelectColor;
        [self.topScrollView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitle:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
        
        if (idx == 0) {
            [self tapTitle:tap];
        }
        
        [self.labelArr addObject:label];
    }];
    self.topScrollView.contentSize = CGSizeMake(lW*titles.count, lH);
}

- (void)tapTitle:(UITapGestureRecognizer *)tap
{
    UILabel *selL = (UILabel *)tap.view;
    [self selectLabel:selL];
    
    NSInteger index = selL.tag;
    CGFloat offsetX = CGRectGetWidth(self.contentScrollView.bounds)*index;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    [self addChildView:index];
    
    [self titleCenter:selL];
}

- (void)selectLabel:(UILabel *)label
{
    self.lastL.highlighted = NO;
    self.lastL.transform = CGAffineTransformIdentity;
    self.lastL.textColor = kNormalColor;
    label.highlighted = YES;
    label.transform = CGAffineTransformMakeScale(kScale, kScale);
    self.lastL = label;
}

- (void)addChildView:(NSInteger)index
{
    UIViewController *childVC = self.childViewControllers[index];
    if (childVC.isViewLoaded) { return; }
    childVC.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:childVC.view];
}

- (void)titleCenter:(UILabel *)label
{
    CGFloat offsetX = label.center.x - CGRectGetWidth(self.topScrollView.bounds)*0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    CGFloat maxOffset = self.topScrollView.contentSize.width - CGRectGetWidth(self.topScrollView.bounds);
    if (offsetX > maxOffset) {
        offsetX = maxOffset;
    }
    
    [self.topScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x/CGRectGetWidth(scrollView.bounds);
    
    UILabel *label = self.labelArr[index];
    [self selectLabel:label];
    
    [self addChildView:index];
    
    [self titleCenter:label];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat curPage = scrollView.contentOffset.x/CGRectGetWidth(scrollView.bounds);
    NSInteger leftIndex = curPage;
    NSInteger rightIndex = curPage + 1;
    UILabel *leftL = self.labelArr[leftIndex];
    
    UILabel *rightL;
    if (rightIndex < self.labelArr.count - 1) {
        rightL = self.labelArr[rightIndex];
    }
    
    CGFloat rightScale = curPage - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    
    CGFloat leftS = leftScale*(kScale - 1) + 1;
    CGFloat rightS = rightScale*(kScale - 1) + 1;
    leftL.transform = CGAffineTransformMakeScale(leftS, leftS);
    rightL.transform = CGAffineTransformMakeScale(rightS, rightS);

    CGFloat leftRed, leftGreen, leftBlue;
    CGFloat rightRed, rightGreen, rightBlue;
    [kNormalColor getRed:&leftRed green:&leftGreen blue:&leftBlue alpha:nil];
    [kSelectColor getRed:&rightRed green:&rightGreen blue:&rightBlue alpha:nil];
    
    leftL.textColor = [UIColor colorWithRed:leftRed + (rightRed - leftRed)*leftScale green:leftGreen + (rightGreen - leftGreen)*leftScale blue:leftBlue + (rightBlue - leftBlue)*leftScale alpha:1];
    rightL.textColor = [UIColor colorWithRed:leftRed + (rightRed - leftRed)*rightScale green:leftGreen + (rightGreen - leftGreen)*rightScale blue:leftBlue + (rightBlue - leftBlue)*rightScale alpha:1];
}

@end
