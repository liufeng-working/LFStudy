//
//  LFFormViewController.h
//  LFStudy
//
//  Created by 刘丰 on 2017/9/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//  表单

#import <UIKit/UIKit.h>
#import "LFFormGroupModel.h"

@interface LFFormViewController : UITableViewController

@property(nonatomic,strong) NSArray<LFFormGroupModel *> *groupMs;

@end
