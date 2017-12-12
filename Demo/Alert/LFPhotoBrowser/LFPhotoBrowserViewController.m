//
//  LFPhotoBrowserViewController.m
//  LFJXStreet
//
//  Created by 刘丰 on 2017/1/11.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFPhotoBrowserViewController.h"
#import "LFPhotoBrowserCell.h"
#import "LFPhotoBrowserExtraView.h"
#import "LFPhotoBrowserAnimatedTransitioning.h"

#define lfPhotoBrowser_screenWidth ([UIScreen mainScreen].bounds.size.width)
#define lfPhotoBrowser_screenHeight ([UIScreen mainScreen].bounds.size.height)
#define lfPhotoBrowser_extraViewHeight 44
#define lfPhotoBrowser_keyWindow ([UIApplication sharedApplication].delegate.window)
@interface LFPhotoBrowserViewController ()<UIViewControllerTransitioningDelegate, LFPhotoBrowserCellDelegate, LFPhotoBrowserExtraViewDelegate>

@property(nonatomic,strong) LFPhotoBrowserExtraView *extraView;

@property(nonatomic,strong) LFPhotoBrowserAnimatedTransitioning *animatedTransitioning;

@property(nonatomic,assign) BOOL statusHidden;

@end

static NSString * const cellIdentifier = @"LFPhotoBrowserCell";
@implementation LFPhotoBrowserViewController

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(lfPhotoBrowser_screenWidth, lfPhotoBrowser_screenHeight);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.transitioningDelegate = self;
    }
    return self;
}

- (LFPhotoBrowserExtraView *)extraView
{
    if (!_extraView) {
        _extraView = [[LFPhotoBrowserExtraView alloc] init];
        _extraView.delegate = self;
    }
    return _extraView;
}

- (LFPhotoBrowserAnimatedTransitioning *)animatedTransitioning
{
    if (!_animatedTransitioning) {
        _animatedTransitioning = [[LFPhotoBrowserAnimatedTransitioning alloc] init];
    }
    return _animatedTransitioning;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.statusHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark -
#pragma mark - UI相关
- (void)setupUI
{
    [self.view addSubview:self.extraView];
    self.extraView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"extra": self.extraView};
    NSDictionary *metrics = @{@"lf_extraViewHeight": @(lfPhotoBrowser_extraViewHeight)};
    NSArray *hC = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[extra]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:hC];
    
    NSArray *vC = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[extra(lf_extraViewHeight)]" options:0 metrics:metrics views:views];
    [self.view addConstraints:vC];
    
    if (self.images.count) {
        self.extraView.totle = self.images.count;
    }else if (self.urls.count) {
        self.extraView.totle = self.urls.count;
    }else if (self.photos.count) {
        self.extraView.totle = self.photos.count;
    }else if (self.items.count) {
        self.extraView.totle = self.items.count;
    }else {
        self.extraView.totle = 0;
    }
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[LFPhotoBrowserCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    //移动到点击的图片
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    if (self.images.count > 1 || self.urls.count > 1 || self.photos.count > 1 || self.items.count > 1) {
        self.extraView.currentIndex = self.currentIndex + 1;
    }
}

- (void)setSaveShow:(BOOL)saveShow
{
    _saveShow = saveShow;
    
    self.extraView.saveShow = saveShow;
}

#pragma mark -
#pragma mark - 显示
- (void)show
{
    UIViewController *rootVC = lfPhotoBrowser_keyWindow.rootViewController;
    NSAssert(rootVC, @"窗口不存在根控制器，无法使用\"LFPhotoBrowserViewController\"");
    [self showIn:rootVC];
}

- (void)showIn:(UIViewController *)targetVC
{
    NSAssert(targetVC, @"使用\"-[LFPhotoBrowserViewController showIn:]\"，目标控制器不能为空");
    [targetVC presentViewController:self animated:YES completion:nil];
}

#pragma mark -
#pragma mark - 隐藏
- (void)hide
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationCustom;
}

- (BOOL)prefersStatusBarHidden {
    return self.statusHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.images.count) {
        return self.images.count;
    }else if (self.urls.count) {
        return self.urls.count;
    }else if (self.photos.count) {
        return self.photos.count;
    }else if (self.items.count) {
        return self.items.count;
    }else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LFPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    if (self.images.count) {
        cell.image = self.images[indexPath.row];
    }else if (self.urls.count) {
        cell.url = self.urls[indexPath.row];
    }else if (self.photos.count) {
        cell.photoModel = self.photos[indexPath.row];
    }else if (self.items.count) {
        if (self.item_map) {
            id item = self.item_map(self.items[indexPath.row]);
            if ([item isKindOfClass:[UIImage class]]) {
                cell.image = item;
            }else if ([item isKindOfClass:[NSURL class]]) {
                cell.url = item;
            }else {
                NSAssert(NO, @"block\"item_map\"的返回值应为UIImage或NSURL");
            }
        }else {
            NSAssert(NO, @"使用[LFPhotoBrowserViewController items]，必须实现\"item_map\"");
        }
    }else {
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndex = indexPath.item;
    self.extraView.currentIndex = indexPath.row + 1;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *currentIndexPath = collectionView.indexPathsForVisibleItems.firstObject;
    self.currentIndex = indexPath.item;
    self.extraView.currentIndex = currentIndexPath.row + 1;
}

#pragma mark -
#pragma mark - LFPhotoBrowserCellDelegate
- (void)didSelectPhotoBrowserCell:(LFPhotoBrowserCell *)cell
{
    [self hide];
}

#pragma mark -
#pragma mark - LFExtraViewDelegate
- (void)photoBrowserExtraViewDidClickSave:(LFPhotoBrowserExtraView *)view
{
    if (self.images.count) {
        if (self.saveClick) {
            self.saveClick(self.images[self.currentIndex]);
        }
    }else if (self.urls.count) {
        if (self.saveClick) {
            self.saveClick(self.urls[self.currentIndex]);
        }
    }else if (self.photos.count) {
        if (self.saveClick) {
            self.saveClick(self.photos[self.currentIndex]);
        }
    }else if (self.items.count) {
        if (self.item_map) {
            id item = self.item_map(self.items[self.currentIndex]);
            if ([item isKindOfClass:[UIImage class]] ||
                [item isKindOfClass:[NSURL class]]) {
                if (self.saveClick) {
                    self.saveClick(item);
                }
            }else {
                NSAssert(NO, @"block\"item_map\"的返回值应为UIImage或NSURL");
            }
        }else {
            NSAssert(NO, @"使用[LFPhotoBrowserViewController items]，必须实现\"item_map\"");
        }
    }
}

#pragma mark -
#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.animatedTransitioning;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.animatedTransitioning;
}

@end
