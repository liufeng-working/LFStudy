//
//  LFFormSelectCell.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFFormSelectModel;
/// left:UILabel right: UITextField -> enable = NO / accessoryType = DisclosureIndicator
@interface LFFormSelectCell : UITableViewCell

/**
 获取实例对象
 */
+ (instancetype)selectCellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) LFFormSelectModel *sM;

@end
