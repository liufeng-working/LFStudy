//
//  LFFormGroupModel.h
//  表单
//
//  Created by 刘丰 on 2017/10/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//  组 模型

#import <UIKit/UIKit.h>
#import "LFFormHeaderFooterModel.h"
#import "LFFormTextFiledModel.h"
#import "LFFormSwitchModel.h"
#import "LFFormCustomModel.h"
#import "LFFormSelectModel.h"
#import "LFFormPhotoModel.h"

@interface LFFormGroupModel : NSObject

/**
 区头
 */
@property(nonatomic,strong) LFFormHeaderFooterModel *headerM;

/**
 区尾
 */
@property(nonatomic,strong) LFFormHeaderFooterModel *footerM;

/**
 每个cell显示的内容，可选(LFFormTextFiledModel、LFFormSwitchModel、LFFormCustomModel、LFFormSelectModel、LFFormPhotoModel、)
 */
@property(nonatomic,strong) NSArray<NSObject *> *rowMs;

@end
