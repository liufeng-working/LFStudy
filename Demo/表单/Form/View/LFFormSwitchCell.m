//
//  LFFormSwitchCell.m
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormSwitchCell.h"
#import "LFFormSwitchModel.h"

@interface LFFormSwitchCell ()

@property(nonatomic,weak) UILabel *leftL;

@property(nonatomic,weak) UISwitch *switchV;

@end

@implementation LFFormSwitchCell

+ (instancetype)switchCellWithTableView:(UITableView *)tableView
{
    static NSString *lfSwitchCell_id = @"LFFormSwitchCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:lfSwitchCell_id];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lfSwitchCell_id];
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

- (UISwitch *)switchV
{
    if (!_switchV) {
        UISwitch *switchV = [[UISwitch alloc] init];
        [self.contentView addSubview:switchV];
        [switchV addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
        _switchV = switchV;
    }
    return _switchV;
}

- (void)setSM:(LFFormSwitchModel *)sM
{
    _sM = sM;
    
    self.leftL.text = sM.leftTitle;
    self.switchV.on = sM.isOn;
}

- (void)setupSubviews
{
    self.leftL.translatesAutoresizingMaskIntoConstraints = NO;
    self.switchV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.switchV setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    NSDictionary *metrics = @{@"lAndR": @15, @"tAndB": @10, @"spacing": @10};
    NSDictionary *views = @{@"leftL": self.leftL, @"switchV": self.switchV};
    NSArray *hCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-lAndR-[leftL]-spacing-[switchV]-lAndR-|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views];
    [self.contentView addConstraints:hCon];
    
    NSArray *lvCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-tAndB-[leftL]-tAndB-|" options:0 metrics:metrics views:views];
    [self.contentView addConstraints:lvCon];
}

#pragma mark -
#pragma mark - switch值改变
- (void)valueChanged
{
    BOOL isOn = self.switchV.isOn;
    self.sM.isOn = isOn;
    if (self.sM.click) {
        self.sM.click(isOn);
    }
}

@end
