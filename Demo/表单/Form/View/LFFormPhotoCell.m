//
//  LFFormPhotoCell.m
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormPhotoCell.h"

@interface LFFormPhotoCell ()

@property(nonatomic,weak) UILabel *titleL;

@property(nonatomic,weak) UILabel *descL;

@end

@implementation LFFormPhotoCell

+ (instancetype)photoCellWithTableView:(UITableView *)tableView
{
    static NSString *lfPhotoCell_id = @"LFFormPhotoCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:lfPhotoCell_id];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lfPhotoCell_id];
        //        NSLog(@"%@-新建的", lfRowCell_id);
    }else {
        //        NSLog(@"%@-重用的", lfRowCell_id);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setupSubviews];
    }
    return self;
}

- (UILabel *)titleL
{
    if (!_titleL) {
        UILabel *l = [[UILabel alloc] init];
        l.backgroundColor = [UIColor clearColor];
        l.textColor = [UIColor blackColor];
        l.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:l];
        _titleL = l;
    }
    return _titleL;
}

- (UILabel *)descL
{
    if (!_descL) {
        UILabel *l = [[UILabel alloc] init];
        l.backgroundColor = [UIColor clearColor];
        l.textColor = [UIColor blackColor];
        l.font = [UIFont systemFontOfSize:15];
        _descL = l;
    }
    return _descL;
}

- (void)setPM:(LFFormPhotoModel *)pM
{
    _pM = pM;
}

- (void)setupSubviews
{
//    self.leftL.translatesAutoresizingMaskIntoConstraints = NO;
//    self.switchV.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.switchV setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//    NSDictionary *views = @{@"leftL": self.leftL, @"switchV": self.switchV};
//    NSArray *hCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[leftL]-10-[switchV]-15-|" options:0 metrics:nil views:views];
//    [self.contentView addConstraints:hCon];
//
//    NSArray *lvCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[leftL]-10-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
//    [self.contentView addConstraints:lvCon];
//
//    NSArray *tfvCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[switchV]-10-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
//    [self.contentView addConstraints:tfvCon];
}

@end
