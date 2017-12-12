//
//  LFPhotoBrowserModel.h
//  LFJXStreet
//
//  Created by 刘丰 on 2017/1/11.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFPhotoBrowserModel : NSObject

/**
 网络图片
 */
@property(nonatomic,strong,nullable) NSURL *imgUrl;

/**
 本地图片
 */
@property(nonatomic,strong,nullable) UIImage *image;

/**
 占位图片（可选）
 */
@property(nonatomic,strong,nullable) UIImage *placeholderImage;

+ (instancetype)photoModelWithUrl:(NSURL *)imgUrl;
+ (instancetype)photoModelWithUrl:(NSURL *)imgUrl
                      placeholder:(UIImage * _Nullable)phImg;
+ (instancetype)photoModelWithImage:(UIImage *)image;
+ (instancetype)photoModelWithImage:(UIImage *)image
                        placeholder:(UIImage * _Nullable)phImg;

@end

NS_ASSUME_NONNULL_END
