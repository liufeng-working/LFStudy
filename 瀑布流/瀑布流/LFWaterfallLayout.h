//
//  LFWaterfallLayout.h
//  Waterfall
//
//  Created by 刘丰 on 2017/6/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//  瀑布流

#import <UIKit/UIKit.h>

@protocol LFWaterfallLayoutDelegate;
@interface LFWaterfallLayout : UICollectionViewLayout

@property(nonatomic,weak) id<LFWaterfallLayoutDelegate> waterfallDelegate;

@end

@protocol LFWaterfallLayoutDelegate <NSObject>

@required
- (CGSize)lf_collectionView:(UICollectionView *)collectionView layout:(LFWaterfallLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (UIEdgeInsets)lf_collectionView:(UICollectionView *)collectionView edgeInsetInLayout:(LFWaterfallLayout *)layout;
- (CGFloat)lf_collectionView:(UICollectionView *)collectionView minimumRowSpacingInLayout:(LFWaterfallLayout *)layout;
- (CGFloat)lf_collectionView:(UICollectionView *)collectionView minimumColumnSpacingInLayout:(LFWaterfallLayout *)layout;
- (NSInteger)lf_collectionView:(UICollectionView *)collectionView columnInLayout:(LFWaterfallLayout *)layout;

@end
