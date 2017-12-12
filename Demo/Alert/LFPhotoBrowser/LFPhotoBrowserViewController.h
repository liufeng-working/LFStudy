//
//  LFPhotoBrowserViewController.h
//  LFJXStreet
//
//  Created by 刘丰 on 2017/1/11.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFPhotoBrowserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LFPhotoBrowserViewController : UICollectionViewController

/**
 图片数组（选择其中一个赋值）
 */
@property(nonatomic,strong) NSArray<UIImage *> *images;
@property(nonatomic,strong) NSArray<NSURL *> *urls;
@property(nonatomic,strong) NSArray <LFPhotoBrowserModel *> *photos;

/**
 图片数组（可以装自己定义的模型，然后实现下面的block，返回模型中可用的字段<UIImage/NSURL>）
 */
@property(nonatomic,strong) NSArray <id> *items;
@property(nonatomic,copy) id (^item_map)(id item);

/**
 当前显示的索引
 */
@property(nonatomic,assign) NSInteger currentIndex;

/**
 保存按钮是否显示（默认NO）
 */
@property(nonatomic,assign) BOOL saveShow;

/**
 item的类型和传入的类型相同
 */
@property(nonatomic,copy) void(^saveClick)(id item);

/**
 显示图片浏览器(从窗口根控制器弹出)
 */
- (void)show;

/**
 显示图片浏览器(从指定控制器弹出)
 */
- (void)showIn:(UIViewController *)targetVC;

@end

NS_ASSUME_NONNULL_END
