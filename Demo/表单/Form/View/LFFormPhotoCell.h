//
//  LFFormPhotoCell.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFFormPhotoModel;
/// 添加图片
@interface LFFormPhotoCell : UITableViewCell

/**
 获取实例对象
 */
+ (instancetype)photoCellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) LFFormPhotoModel *pM;

@end
