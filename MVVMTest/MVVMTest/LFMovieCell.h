//
//  LFMovieCell.h
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFMovieModel;
@interface LFMovieCell : UITableViewCell

@property(nonatomic,strong) LFMovieModel *movieM;

+ (instancetype)movieCellWithTableView:(UITableView *)tableView;

@end
