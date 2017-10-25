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

@interface LFFormGroupModel : NSObject

@property(nonatomic,strong) LFFormHeaderFooterModel *headerM;

@property(nonatomic,strong) LFFormHeaderFooterModel *footerM;

/**
 每个cell显示的内容，可选(LFFormTextFiledModel、LFFormSwitchModel、LFFormLabelModel、LFFormCustomModel、LFFormSelectModel、)
 */
@property(nonatomic,strong) NSArray<NSObject *> *rowMs;

@end
