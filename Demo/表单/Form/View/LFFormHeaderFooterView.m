//
//  LFFormHeaderFooterView.m
//  表单
//
//  Created by 刘丰 on 2017/10/24.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormHeaderFooterView.h"
#import "LFFormHeaderFooterModel.h"

@interface LFFormHeaderFooterView ()

@property(nonatomic,weak) UILabel *titleL;

@end

@implementation LFFormHeaderFooterView

+ (instancetype)formHeaderFooterViewWithTableView:(UITableView *)tableView {
    static NSString *lfFormHeaderFooterView_id = @"LFFormHeaderFooterView";
    LFFormHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:lfFormHeaderFooterView_id];
    if (headerFooterView == nil) {
        headerFooterView = [[LFFormHeaderFooterView alloc] initWithReuseIdentifier:lfFormHeaderFooterView_id];
        headerFooterView.backgroundView = [UIView new];
    }
    return headerFooterView;
}

- (UILabel *)titleL
{
    if (!_titleL) {
        UILabel *titleL = [[UILabel alloc] init];
        [self.contentView addSubview:titleL];
        
        titleL.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = @{@"titleL": titleL};
        NSArray *hCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[titleL]-15-|" options:NSLayoutFormatAlignAllLeft | NSLayoutAttributeRight metrics:nil views:views];
        [self.contentView addConstraints:hCon];
        
        NSArray *vCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[titleL]-0-|" options:NSLayoutFormatAlignAllTop | NSLayoutAttributeBottom metrics:nil views:views];
        [self.contentView addConstraints:vCon];
        
        _titleL = titleL;
    }
    return _titleL;
}

- (void)setHeaderFooterM:(LFFormHeaderFooterModel *)headerFooterM
{
    _headerFooterM = headerFooterM;
    
    self.titleL.text = headerFooterM.text ?: @"";
    self.textLabel.textAlignment = headerFooterM.textAlignment;
    self.titleL.font = headerFooterM.font ?: [UIFont systemFontOfSize:15];
    self.titleL.textColor = headerFooterM.textColor ?: [UIColor orangeColor];
    self.titleL.backgroundColor = headerFooterM.backgroundColor ?: [UIColor clearColor];
    
}

@end
