//
//  LFFormPhotoCell.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFFormPhotoModel;
@protocol LFFormPhotoCellDelegate;
/// 添加图片，需要在info.plise中添加两个key(NSCameraUsageDescription、 NSPhotoLibraryUsageDescription)
@interface LFFormPhotoCell : UITableViewCell

/**
 获取实例对象
 */
+ (instancetype)photoCellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) LFFormPhotoModel *pM;

@property(nonatomic,weak) id<LFFormPhotoCellDelegate> delegate;

/**
 添加一张图
 */
- (void)addImage:(UIImage *)image;

@end

@protocol LFFormPhotoCellDelegate <NSObject>

@optional

/**
 添加图片
 */
- (void)photoCellAddPhoto:(LFFormPhotoCell *)cell;

/**
 删除某一个
 */
- (void)photoCell:(LFFormPhotoCell *)cell didDeleteImage:(UIImage *)image;

/**
 选中某一个
 */
- (void)photoCell:(LFFormPhotoCell *)cell didSelectAtIndex:(NSUInteger)index;

@end
