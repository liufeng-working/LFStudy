//
//  LFPhotoBrowserCell.m
//  LFJXStreet
//
//  Created by 刘丰 on 2017/1/11.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFPhotoBrowserCell.h"
#import "LFPhotoBrowserModel.h"
#import "UIImageView+WebCache.h"
#import "LFArcProgressView.h"

#define lfPhotoBrowser_minimumZoomScale 1
#define lfPhotoBrowser_maximumZoomScale 3
@interface LFPhotoBrowserCell ()<UIScrollViewDelegate>

@property(nonatomic,weak) UIImageView *imageV;

@property(nonatomic,weak) UIScrollView *scrollV;

@property(nonatomic,weak) LFArcProgressView *progressV;

@end

@implementation LFPhotoBrowserCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.contentSize = CGSizeMake(width, height);
        scrollView.delegate = self;
        scrollView.minimumZoomScale = lfPhotoBrowser_minimumZoomScale;
        scrollView.maximumZoomScale = lfPhotoBrowser_maximumZoomScale;
        scrollView.bounces = NO;
        [self.contentView addSubview:scrollView];
        _scrollV = scrollView;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollV.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        _imageV = imageView;
        
        CGFloat pWH = MIN(MIN(width, height)*0.2, 60);
        LFArcProgressView *pV = [[LFArcProgressView alloc] initWithFrame:CGRectMake(0, 0, pWH, pWH)];
        pV.center = CGPointMake(width*0.5, height*0.5);
        [self addSubview:pV];
        _progressV = pV;
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapGesture.numberOfTapsRequired = 2; //双击
        [_imageV addGestureRecognizer:doubleTapGesture];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    [self setPhotoModel:[LFPhotoBrowserModel photoModelWithImage:image]];
}

- (void)setUrl:(NSURL *)url
{
    _url = url;
    
    [self setPhotoModel:[LFPhotoBrowserModel photoModelWithUrl:url]];
}

#pragma mark -
#pragma mark - 设置模型
- (void)setPhotoModel:(LFPhotoBrowserModel *)photoModel
{
    _photoModel = photoModel;

    // 修改进度
    self.progressV.progress = 0;
    
    // 修改缩放比例
    self.scrollV.zoomScale = lfPhotoBrowser_minimumZoomScale;
    self.scrollV.contentOffset = CGPointZero;
    if (photoModel.image) {
        self.progressV.hidden = YES;
        self.imageV.image = photoModel.image;
        [self adjustFrame];
    }else {
        self.progressV.hidden = NO;
        [self.imageV sd_setImageWithPreviousCachedImageWithURL:photoModel.imgUrl placeholderImage:photoModel.placeholderImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressV.progress = receivedSize*1.0/expectedSize;
            });
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if ([imageURL.absoluteString isEqualToString:self.photoModel.imgUrl.absoluteString]) {
                self.progressV.hidden = YES;
                
                [self adjustFrame];
            }
        }];
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageV;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat w = CGRectGetWidth(scrollView.bounds);
    CGFloat h = CGRectGetHeight(scrollView.bounds);
    CGFloat contentW = scrollView.contentSize.width;
    CGFloat contentH = scrollView.contentSize.height;
    self.imageV.center = CGPointMake(MAX(w, contentW)*0.5, MAX(h, contentH)*0.5);
}

#pragma mark -
#pragma mark - 双击
- (void)doubleTap:(UITapGestureRecognizer *)tap
{
    if (self.scrollV.zoomScale == lfPhotoBrowser_maximumZoomScale) {
        [self.scrollV setZoomScale:lfPhotoBrowser_minimumZoomScale animated:YES];
    }else {
        CGPoint touchPoint = [tap locationInView:self.scrollV];
        [self.scrollV zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}

#pragma mark -
#pragma mark - 单击
- (void)handleTap
{
    if ([self.delegate respondsToSelector:@selector(didSelectPhotoBrowserCell:)]) {
        [self.delegate didSelectPhotoBrowserCell:self];
    }
}

#pragma mark -
#pragma mark - 调整坐标
- (void)adjustFrame
{
    CGSize fitSize = [self fitSize:self.imageV.image.size maxSize:CGSizeMake(CGRectGetWidth(self.scrollV.bounds), MAXFLOAT)];
    self.scrollV.contentSize = fitSize;
    CGFloat fitW = fitSize.width;
    CGFloat fitH = fitSize.height;
    CGFloat fitX = [self fitOrigin:fitW max:CGRectGetWidth(self.scrollV.bounds)];
    CGFloat fitY = [self fitOrigin:fitH max:CGRectGetHeight(self.scrollV.bounds)];
    self.imageV.frame = CGRectMake(fitX, fitY, fitW, fitH);
}

- (CGSize)fitSize:(CGSize)originalSize maxSize:(CGSize)maxSize
{
    CGFloat maxW = maxSize.width;
    CGFloat maxH = maxSize.height;
    CGFloat maxScale = maxW*1.0/maxH;
    CGFloat originalW = originalSize.width;
    CGFloat originalH = originalSize.height;
    CGFloat scale = originalW*1.0/originalH;
    
    if (scale > maxScale && originalW > maxW) {
        return CGSizeMake(maxW, maxW / scale);
    }else if (scale < maxScale && originalH > maxH) {
        return CGSizeMake(scale * maxH, maxH);
    }else if (scale == maxScale && originalH > maxH) {
        return CGSizeMake(maxW, maxH);
    }else {
        return originalSize;
    }
}

- (CGFloat)fitOrigin:(CGFloat)original max:(CGFloat)max
{
    return original > max ? 0 : (max - original)*0.5;
}

@end
