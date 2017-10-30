//
//  LFFormPhotoCell.m
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormPhotoCell.h"
#import "LFFormPhotoModel.h"
#import "LFFormTool.h"

#define lfFormAddPhotoCell_spacing 10 // 间距
#define lfFormAddPhotoCell_lr 15 // 左右边距
#define lfFormAddPhotoCell_wh (([UIScreen mainScreen].bounds.size.width - lfFormAddPhotoCell_spacing*2 - lfFormAddPhotoCell_lr*2)*1.0/3) // item宽高

@protocol LFFormAddPhotoCellDelegate <NSObject>

@optional
/**
 点击删除
 */
- (void)photoCellDidDelete:(UIImage *)image;

@end

@interface LFFormAddPhotoCell : UICollectionViewCell

@property (weak, nonatomic) UIImageView *imageView;

@property (weak, nonatomic) UIButton *deleteBtn;

@property(nonatomic,weak) id<LFFormAddPhotoCellDelegate> delegate;

@end

@implementation LFFormAddPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView = imageView;
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.backgroundColor = [UIColor clearColor];
        [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:deleteBtn];
        deleteBtn.translatesAutoresizingMaskIntoConstraints = NO;
        _deleteBtn = deleteBtn;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(imageView, deleteBtn);
        NSArray *ihCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:views];
        NSArray *ivCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:0 metrics:nil views:views];
        [self.contentView addConstraints:ihCon];
        [self.contentView addConstraints:ivCon];
        
        NSArray *bhCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[deleteBtn]-0-|" options:0 metrics:nil views:views];
        NSArray *bvCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[deleteBtn]" options:0 metrics:nil views:views];
        [self.contentView addConstraints:bhCon];
        [self.contentView addConstraints:bvCon];
    }
    return self;
}

#pragma mark -
#pragma mark - 点击删除按钮
- (void)deleteClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(photoCellDidDelete:)]) {
        [self.delegate photoCellDidDelete:self.imageView.image];
    }
}

@end

static NSString *lfFormAddPhotoCell_id = @"LFFormAddPhotoCell";
@interface LFFormPhotoCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LFFormAddPhotoCellDelegate>

@property(nonatomic,weak) UILabel *titleL;

@property(nonatomic,weak) UILabel *descL;

@property(nonatomic,weak) UILabel *numL;

@property(nonatomic,weak) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray<UIImage *> *images;

@end

@implementation LFFormPhotoCell

+ (instancetype)photoCellWithTableView:(UITableView *)tableView
{
    static NSString *lfPhotoCell_id = @"LFFormPhotoCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:lfPhotoCell_id];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lfPhotoCell_id];
//        NSLog(@"%@-新建的", lfRowCell_id);
    }else {
//        NSLog(@"%@-重用的", lfRowCell_id);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setupSubviews];
    }
    return self;
}

- (UILabel *)titleL
{
    if (!_titleL) {
        UILabel *l = [[UILabel alloc] init];
        l.backgroundColor = [UIColor clearColor];
        l.textColor = [UIColor blackColor];
        l.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:l];
        _titleL = l;
    }
    return _titleL;
}

- (UILabel *)descL
{
    if (!_descL) {
        UILabel *l = [[UILabel alloc] init];
        l.backgroundColor = [UIColor clearColor];
        l.textColor = [UIColor grayColor];
        l.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:l];
        _descL = l;
    }
    return _descL;
}

- (UILabel *)numL
{
    if (!_numL) {
        UILabel *l = [[UILabel alloc] init];
        l.backgroundColor = [UIColor clearColor];
        l.textColor = [UIColor darkTextColor];
        l.textAlignment = NSTextAlignmentRight;
        l.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:l];
        _numL = l;
    }
    return _numL;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collection.backgroundColor = [UIColor clearColor];
        collection.delegate = self;
        collection.dataSource = self;
        collection.bounces = NO;
        collection.showsVerticalScrollIndicator = NO;
        collection.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:collection];
        _collectionView = collection;
        [collection registerClass:[LFFormAddPhotoCell class] forCellWithReuseIdentifier:lfFormAddPhotoCell_id];
    }
    return _collectionView;
}

- (NSMutableArray<UIImage *> *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)setPM:(LFFormPhotoModel *)pM
{
    _pM = pM;
    
    self.titleL.text = pM.title;
    self.descL.text = pM.desc.length ? [NSString stringWithFormat:@"(%@)", pM.desc] : nil;
    self.collectionView.contentOffset = pM.offset;
    
    [self.images removeAllObjects];
    [self.images addObjectsFromArray:pM.images];
    [self.images addObject: pM.addImage ?: [LFFormTool addImage]];
    [self.collectionView reloadData];
    
    [self setNumTitle];
}

- (void)setupSubviews
{
    self.titleL.translatesAutoresizingMaskIntoConstraints = NO;
    self.descL.translatesAutoresizingMaskIntoConstraints = NO;
    self.numL.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.titleL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.descL setContentHuggingPriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];

    NSDictionary *metrics = @{@"lAndR": @(lfFormAddPhotoCell_lr), @"tAndB": @10, @"spacing": @(lfFormAddPhotoCell_spacing), @"height": @(lfFormAddPhotoCell_wh)};
    NSDictionary *views = @{@"titleL": self.titleL, @"descL": self.descL, @"numL": self.numL, @"cView": self.collectionView};
    NSArray *hCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-lAndR-[titleL]-0-[descL]->=10-[numL]-lAndR-|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views];
    [self.contentView addConstraints:hCon];
    
    NSArray *chCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-lAndR-[cView]-lAndR-|" options:0 metrics:metrics views:views];
    [self.contentView addConstraints:chCon];

    NSArray *tvCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-tAndB-[titleL]-spacing-[cView(height)]-tAndB-|" options:0 metrics:metrics views:views];
    [self.contentView addConstraints:tvCon];
}

- (void)setNumTitle
{
    self.numL.text = [NSString stringWithFormat:@"%zd/%zd", self.images.count - 1, self.pM.maxCount];
}

#pragma mark -
#pragma mark - 添加一张图
- (void)addImage:(UIImage *)image
{
    [self.images insertObject:image atIndex:self.images.count - 1];
    [self.pM.images addObject:image];
    [self.collectionView reloadData];
    
    if (self.pM.maxCount > 3) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.images.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
 
    [self setNumTitle];
}

#pragma mark -
#pragma mark - LFFormAddPhotoCellDelegate
- (void)photoCellDidDelete:(UIImage *)image
{
    [self.images removeObject:image];
    [self.pM.images removeObject:image];
    [self.collectionView reloadData];
    
    if (self.pM.maxCount > 3) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.images.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
    
    [self setNumTitle];
    
    if ([self.delegate respondsToSelector:@selector(photoCell:didDeleteImage:)]) {
        [self.delegate photoCell:self didDeleteImage:image];
    }
}

#pragma mark -
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count <= self.pM.maxCount ? self.images.count : self.pM.maxCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LFFormAddPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lfFormAddPhotoCell_id forIndexPath:indexPath];
    cell.delegate = self;
    cell.imageView.image = self.images[indexPath.row];
    cell.deleteBtn.hidden = indexPath.row == self.images.count - 1;
    [cell.deleteBtn setImage:self.pM.deleteImage ?: [LFFormTool deleteImage] forState:UIControlStateNormal];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.images.count - 1) {
        if ([self.delegate respondsToSelector:@selector(photoCellAddPhoto:)]) {
            [self.delegate photoCellAddPhoto:self];
        }
    }else {
        if (self.pM.clickImage) {
            self.pM.clickImage(indexPath.row);
        }else if ([self.delegate respondsToSelector:@selector(photoCell:didSelectAtIndex:)]) {
            [self.delegate photoCell:self didSelectAtIndex:indexPath.row];
        }
    }
}

#pragma mark -
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(lfFormAddPhotoCell_wh - 1, lfFormAddPhotoCell_wh);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return lfFormAddPhotoCell_spacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return lfFormAddPhotoCell_spacing;
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pM.offset = scrollView.contentOffset;
}

@end
