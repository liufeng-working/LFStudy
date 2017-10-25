//
//  LFFormTextFieldCell.m
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormTextFieldCell.h"
#import "LFFormTextFiledModel.h"

@interface LFFormTextFieldCell ()<UITextFieldDelegate>

@property(nonatomic,weak) UILabel *leftL;

@property(nonatomic,weak) UITextField *textField;

@end

@implementation LFFormTextFieldCell

+ (instancetype)textFieldCellWithTableView:(UITableView *)tableView
{
    static NSString *lfTextFieldCell_id = @"LFFormTextFieldCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:lfTextFieldCell_id];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lfTextFieldCell_id];
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
        tf.delegate = self;
        tf.clipsToBounds = YES;
        tf.textAlignment = NSTextAlignmentRight;
        tf.textColor = [UIColor orangeColor];
        tf.font = [UIFont systemFontOfSize:15];
        tf.borderStyle = UITextBorderStyleNone;
        [self.contentView addSubview:tf];
        _textField = tf;
    }
    return _textField;
}

- (void)setTfM:(LFFormTextFiledModel *)tfM
{
    _tfM = tfM;
    
    self.leftL.text = tfM.leftTitle;
    self.textField.placeholder = tfM.placeholder;
    self.textField.text = tfM.rightText;
}

- (void)setupSubviews
{
    self.leftL.translatesAutoresizingMaskIntoConstraints = NO;
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.leftL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    NSDictionary *views = @{@"leftL": self.leftL, @"tf": self.textField};
    NSArray *hCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[leftL]-10-[tf]-15-|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:hCon];
    
    NSArray *lvCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[leftL]-10-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
    [self.contentView addConstraints:lvCon];
    
    NSArray *tfvCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[tf]-5-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
    [self.contentView addConstraints:tfvCon];
}

#pragma mark -
#pragma mark - LFTextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (range.length != 0) {
        self.tfM.rightText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }else {
        self.tfM.rightText = [textField.text stringByAppendingString:string];
    }

    return YES;
}

@end
