//
//  LFFormHeaderFooterView.h
//  表单
//
//  Created by 刘丰 on 2017/10/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFFormHeaderFooterModel;
@interface LFFormHeaderFooterView : UITableViewHeaderFooterView

/**
 获取一个section头或尾
 */
+ (instancetype)formHeaderFooterViewWithTableView:(UITableView *)tableView;

/**
 设置section头或尾样式
 */
@property(nonatomic,strong) LFFormHeaderFooterModel *headerFooterM;

@end
