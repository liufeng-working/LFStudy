//
//  LFWaterfallLayout.m
//  Waterfall
//
//  Created by 刘丰 on 2017/6/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFWaterfallLayout.h"

@interface NSArray (lf_number)

- (NSNumber *)minimum;

- (NSNumber *)maximum;

@end

//行间距
static CGFloat const lf_columnMargin = 10;
//列间距
static CGFloat const lf_rowMargin = 10;
//边缘间距
static UIEdgeInsets lf_edgeInset = {10, 10, 10, 10};
//列数
static NSInteger const lf_columnCount = 3;

@interface LFWaterfallLayout ()

/** 所有cell的布局属性 */
@property(nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributes;

/** 所有列最大y值 */
@property(nonatomic,strong) NSMutableArray<NSNumber *> *maxYs;

@end

@implementation LFWaterfallLayout

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attributes
{
    if (!_attributes) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}

- (NSMutableArray<NSNumber *> *)maxYs
{
    if (!_maxYs) {
        _maxYs = [NSMutableArray array];
    }
    return _maxYs;
}

- (NSInteger)column
{
    if ([self.waterfallDelegate respondsToSelector:@selector(lf_collectionView:columnInLayout:)]) {
        return [self.waterfallDelegate lf_collectionView:self.collectionView columnInLayout:self];
    }
    
    return lf_columnCount;
}

- (UIEdgeInsets)edgeInset
{
    if ([self.waterfallDelegate respondsToSelector:@selector(lf_collectionView:edgeInsetInLayout:)]) {
        return [self.waterfallDelegate lf_collectionView:self.collectionView edgeInsetInLayout:self];
    }
    return lf_edgeInset;
}

- (CGFloat)rowMargin
{
    if ([self.waterfallDelegate respondsToSelector:@selector(lf_collectionView:minimumRowSpacingInLayout:)]) {
        return [self.waterfallDelegate lf_collectionView:self.collectionView minimumRowSpacingInLayout:self];
    }
    return lf_rowMargin;
}

- (CGFloat)columnMargin
{
    if ([self.waterfallDelegate respondsToSelector:@selector(lf_collectionView:minimumColumnSpacingInLayout:)]) {
        return [self.waterfallDelegate lf_collectionView:self.collectionView minimumColumnSpacingInLayout:self];
    }
    return lf_columnMargin;
}

/**
 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    [self.attributes removeAllObjects];
    [self.maxYs removeAllObjects];
    for (NSInteger i = 0; i < self.column; i ++) {
        [self.maxYs addObject:@(self.edgeInset.top)];
    }
    
    //开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributes addObject:attribute];
    }
}

/**
 滚动区域
 */
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), self.maxYs.maximum.floatValue + self.edgeInset.bottom);
}

/**
 决定cell的排布
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributes;
}

/**
 返回indexPath位置cell对应的布局
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = CGRectGetWidth(self.collectionView.bounds);
    CGFloat w = (width - self.edgeInset.left - self.edgeInset.right - (self.column - 1)*self.columnMargin)/self.column;
    CGSize size = [self.waterfallDelegate lf_collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    CGFloat h = size.height/size.width*w;

    NSNumber *minY = self.maxYs.minimum;
    NSInteger column = [self.maxYs indexOfObject:minY];
    CGFloat x = self.edgeInset.left + column*(w + self.columnMargin);
    
    CGFloat y = minY.doubleValue + (minY.doubleValue == self.edgeInset.top ? 0 : self.rowMargin);
    attribute.frame = CGRectMake(x, y, w, h);
    
    //更新最短列
    self.maxYs[column] = @(CGRectGetMaxY(attribute.frame));
    return attribute;
}

@end

@implementation NSArray (lf_number)

- (NSNumber *)minimum
{
    return [self valueForKeyPath:@"@min.doubleValue"];
}

- (NSNumber *)maximum;
{
    return [self valueForKeyPath:@"@max.doubleValue"];
}

@end
