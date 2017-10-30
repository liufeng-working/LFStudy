//
//  LFFormTool.h
//  表单
//
//  Created by 刘丰 on 2017/10/26.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFFormTool : NSObject

/**
 获取资源路径(LFFormResource.bundle下)
 */
+ (NSString *)resourcePathWithNamed:(NSString *)name;

/**
 获取图片(LFFormResource.bundle下)
 */
+ (UIImage *)imageWithNamed:(NSString *)name;

/**
 获取删除按钮的图片(LFFormResource.bundle下)
 */
+ (UIImage *)deleteImage;

/**
 添加图片按钮
 */
+ (UIImage *)addImage;

/**
 跳转到设置
 */
+ (void)jumpToSetting:(void(^)(void))failure;

@end
