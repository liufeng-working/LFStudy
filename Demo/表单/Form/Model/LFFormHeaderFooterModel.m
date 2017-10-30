//
//  LFFormHeaderFooterModel.m
//  表单
//
//  Created by 刘丰 on 2017/10/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormHeaderFooterModel.h"

@implementation LFFormHeaderFooterModel

- (NSString *)text
{
    return _text ?: @"";
}

- (UIFont *)font
{
    return _font ?: [UIFont systemFontOfSize:15];
}

- (UIColor *)textColor
{
    return _textColor ?: [UIColor orangeColor];;
}

- (UIColor *)backgroundColor
{
    return _backgroundColor ?: [UIColor clearColor];
}

@end
