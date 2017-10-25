//
//  LFFormCustomCell.m
//  表单
//
//  Created by 刘丰 on 2017/10/25.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormCustomCell.h"
#import "LFFormCustomModel.h"

@interface LFFormCustomCell ()

@property(nonatomic,weak) UIView *placeholderView;

@property(nonatomic,strong) NSArray<NSLayoutConstraint *> *vConstraints;

@end

@implementation LFFormCustomCell

+ (instancetype)customCellWithTableView:(UITableView *)tableView
{
    static NSString *lfCustomCell_id = @"LFFormCustomCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:lfCustomCell_id];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lfCustomCell_id];
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

- (UIView *)placeholderView
{
    if (!_placeholderView) {
        UIView *pV = [[UIView alloc] init];
        pV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:pV];
        _placeholderView = pV;
    }
    return _placeholderView;
}

- (void)setCM:(LFFormCustomModel *)cM
{
    _cM = cM;
    
    [self setNeedsUpdateConstraints];
}

- (void)setupSubviews
{
    self.placeholderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 先只添加水平方向约束
    NSDictionary *views = @{@"pView": self.placeholderView};
    NSDictionary *metrics = @{@"height": @(self.cM.height)};
    NSArray *hCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pView]-0-|" options:0 metrics:metrics views:views];
    [self.contentView addConstraints:hCon];
}

- (void)updateConstraints {
    
    // 先移除竖直方向上约束
    [NSLayoutConstraint deactivateConstraints:self.vConstraints];
    
    // 添加竖直方向上约束
    NSDictionary *views = @{@"pView": self.placeholderView};
    NSDictionary *metrics = @{@"height": @(self.cM.height)};
    NSArray *vCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[pView(height@750)]-5-|" options:0 metrics:metrics views:views];
    [self.contentView addConstraints:vCon];
    self.vConstraints = vCon;
    
    [super updateConstraints];
}

@end
