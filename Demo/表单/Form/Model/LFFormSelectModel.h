//
//  LFFormSelectModel.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

/// left:UILabel right: UITextField -> enable = NO / accessoryType = DisclosureIndicator
@interface LFFormSelectModel : NSObject

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
 选中后的回调(rightShow是回调右侧将要显示的内容)
 */
@property(nonatomic,copy) void(^click)(NSString *rightText, void(^rightShow)(NSString *showText));

@end
