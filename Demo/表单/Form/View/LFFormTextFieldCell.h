//
//  LFFormTextFieldCell.h
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFFormTextFiledModel;
@protocol LFFormTextFieldCellDelegate;
/// left:UILabel right:UITextField
@interface LFFormTextFieldCell : UITableViewCell

/**
 获取实例对象
 */
+ (instancetype)textFieldCellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) LFFormTextFiledModel *tfM;

@property(nonatomic,weak) id<LFFormTextFieldCellDelegate> delegate;

@end

@protocol LFFormTextFieldCellDelegate <NSObject>

@optional
- (void)textFieldCellDidClickReturn:(LFFormTextFieldCell *)cell;

@end
