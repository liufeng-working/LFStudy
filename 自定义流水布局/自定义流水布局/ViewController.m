//
//  ViewController.m
//  自定义流水布局
//
//  Created by 刘丰 on 2017/6/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFPhotoCell.h"

static NSString *const identifier = @"LFPhotoCell";
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong) NSArray *photos;

@end

@implementation ViewController

- (NSArray *)photos
{
    if (!_photos) {
        _photos = [NSArray arrayWithObjects:
                                       [NSURL URLWithString:
                                             @"http://go.10086.cn/surfnews/images/beautyPic/20161023111735926.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111635470.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111425913.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111336031.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111253175.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111105360.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023111020939.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023110923696.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023110844367.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023110732906.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023110717073.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023110648053.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023110621486.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023110601846.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161023110530326.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161022120221229.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161022120200588.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161022120134609.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161022120044359.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161022120023767.jpg"],
                                       [NSURL URLWithString:@"http://go.10086.cn/surfnews/images/beautyPic/20161022115915555.jpg"], nil];
    }
                   return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 函数式编程思想
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LFPhotoCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

#pragma mark -
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LFPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.url = self.photos[indexPath.item];
    return cell;
}

#pragma mark -
#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(160, 160);
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat left = (CGRectGetWidth(collectionView.frame) - ((UICollectionViewFlowLayout *)collectionView.collectionViewLayout).itemSize.width)*0.5;
    return UIEdgeInsetsMake(0, left, 0, left);
}

@end
