//
//  LFFormTextFiledModel.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

/// left:UILabel right:UITextField
@interface LFFormTextFiledModel : NSObject

/**
 左边标题
 */
@property(nonatomic,copy) NSString *leftTitle;

/**
 右边内容
 */
@property(nonatomic,copy) NSString *rightText;

/**
 占位文字
 */
@property(nonatomic,copy) NSString *placeholder;

/**
 return key 类型
 */
@property(nonatomic,assign) UIReturnKeyType returnKeyType;

/**
 * 点击return键的回调
 * 当returnKeyType == UIReturnTypeNext时，有默认实现
 * 当returnKeyType为其他值时没有默认实现
 * 如果没有实现block，默认实现一直有效
 * 如果实现了这个block，可通过返回值来决定默认实现是否有效
 * 注意循环引用问题
 */
@property(nonatomic,copy) BOOL (^returnClick)(void);

/**
 键盘样式
 */
@property(nonatomic,assign) UIKeyboardType keyboardType;

@end
