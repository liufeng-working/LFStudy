//
//  LFArcProgressView.h
//  Alert
//
//  Created by 刘丰 on 2017/11/21.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 圆弧形进度
@interface LFArcProgressView : UIView

/**
 进度 （0-1）
 */
@property(nonatomic,assign) CGFloat progress;

/**
 外圈线颜色
 */
@property(nonatomic,strong) UIColor *lineColor;

/**
 圆弧颜色
 */
@property(nonatomic,strong) UIColor *arcColor;

@end

NS_ASSUME_NONNULL_END
