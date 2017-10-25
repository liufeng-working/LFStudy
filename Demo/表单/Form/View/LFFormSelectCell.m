//
//  LFFormSelectCell.m
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormSelectCell.h"
#import "LFFormSelectModel.h"

@interface LFFormSelectCell ()

@property(nonatomic,weak) UILabel *leftL;

@property(nonatomic,weak) UITextField *textField;

@property(nonatomic,strong) UITapGestureRecognizer *selectTap;

@end

@implementation LFFormSelectCell

+ (instancetype)selectCellWithTableView:(UITableView *)tableView
{
    static NSString *lfSelectCell_id = @"LFFormSelectCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:lfSelectCell_id];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lfSelectCell_id];
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
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addGestureRecognizer:self.selectTap];
        [self setupSubviews];
    }
    return self;
}

- (UILabel *)leftL
{
    if (!_leftL) {
        UILabel *l = [[UILabel alloc] init];
        l.backgroundColor = [UIColor clearColor];
        l.textColor = [UIColor blackColor];
        [self.contentView addSubview:l];
        _leftL = l;
    }
    return _leftL;
}

- (UITextField *)textField
{
    if (!_textField) {
        UITextField *tf = [[UITextField alloc] init];
        tf.backgroundColor = [UIColor clearColor];
        tf.clipsToBounds = YES;
        tf.textAlignment = NSTextAlignmentRight;
        tf.textColor = [UIColor orangeColor];
        tf.font = [UIFont systemFontOfSize:15];
        tf.borderStyle = UITextBorderStyleNone;
        tf.enabled = NO;
        [self.contentView addSubview:tf];
        _textField = tf;
    }
    return _textField;
}

- (UITapGestureRecognizer *)selectTap
{
    if (!_selectTap) {
        _selectTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    }
    return _selectTap;
}

- (void)setSM:(LFFormSelectModel *)sM
{
    _sM = sM;
    
    self.leftL.text = sM.leftTitle;
    self.textField.placeholder = sM.placeholder;
    self.textField.text = sM.rightText;
}

- (void)setupSubviews
{
    self.leftL.translatesAutoresizingMaskIntoConstraints = NO;
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.leftL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    NSDictionary *views = @{@"leftL": self.leftL, @"tf": self.textField};
    NSArray *hCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[leftL]-10-[tf]-0-|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:hCon];
    
    NSArray *lvCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[leftL]-10-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
    [self.contentView addConstraints:lvCon];
    
    NSArray *tfvCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[tf]-5-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
    [self.contentView addConstraints:tfvCon];
}

#pragma mark -
#pragma mark - 选中
- (void)tapClick
{
    if (self.sM.selectCallback) {
        self.sM.selectCallback(self.textField.text, ^(NSString *text) {
            self.textField.text = text;
            self.sM.rightText = text;
        });
    }
}

@end
