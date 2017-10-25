//
//  LFFormSwitchModel.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

/// left:UIlabel right:UISwitch
@interface LFFormSwitchModel : NSObject

/**
 左边标题
 */
@property(nonatomic,copy) NSString *leftTitle;

/**
 switch开关（默认NO）
 */
@property(nonatomic,assign) BOOL isOn;

/**
 点击switch的回调
 */
@property(nonatomic,copy) void(^clickCallback)(BOOL isOn);

@end
