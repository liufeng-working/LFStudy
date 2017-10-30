//
//  LFFormPhotoModel.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 添加图片，需要在info.plise中添加两个key(NSCameraUsageDescription、 NSPhotoLibraryUsageDescription)
@interface LFFormPhotoModel : NSObject

/**
 标题
 */
@property(nonatomic,copy) NSString *title;

/**
 描述信息
 */
@property(nonatomic,copy) NSString *desc;

/**
 最大图片数量(默认值3，设置为<=0不生效)
 */
@property(nonatomic,assign) NSUInteger maxCount;

/**
 添加按钮的图片(有默认)
 */
@property(nonatomic,strong) UIImage *addImage;

/**
 删除按钮的图片(有默认)
 */
@property(nonatomic,strong) UIImage *deleteImage;

/**
 选中了某一个图片
 */
@property(nonatomic,copy) void(^clickImage)(NSUInteger index);

/**
 当前展示的照片
 */
@property(nonatomic,strong) NSMutableArray<UIImage *> *images;

/**
 偏移量（外部不要赋值）
 */
@property(nonatomic,assign) CGPoint offset;

@end
