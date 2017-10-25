//
//  LFFormSwitchCell.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFFormSwitchModel;
/// left:UIlabel right:UISwitch
@interface LFFormSwitchCell : UITableViewCell

/**
 获取实例对象
 */
+ (instancetype)switchCellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) LFFormSwitchModel *sM;

@end
