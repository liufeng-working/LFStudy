//
//  LFFormCustomCell.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFFormCustomModel;
/// left:nil right:nil
@interface LFFormCustomCell : UITableViewCell

/**
 获取实例对象
 */
+ (instancetype)customCellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) LFFormCustomModel *cM;

@end
