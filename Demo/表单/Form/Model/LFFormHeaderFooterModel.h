//
//  LFFormHeaderFooterModel.h
//  表单
//
//  Created by 刘丰 on 2017/10/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//  区头、区尾 模型

#import <UIKit/UIKit.h>

@interface LFFormHeaderFooterModel : NSObject

/**
 标题
 */
@property(nonatomic,copy) NSString *text;

/**
 标题对其方式
 */
@property(nonatomic,assign) NSTextAlignment textAlignment;

/**
 标题字体
 */
@property(nonatomic,strong) UIFont *font;

/**
 标题颜色
 */
@property(nonatomic,strong) UIColor *textColor;

/**
 背景色
 */
@property(nonatomic,strong) UIColor *backgroundColor;

/**
 区头、区尾 高度
 */
@property(nonatomic,assign) CGFloat height;

@end
