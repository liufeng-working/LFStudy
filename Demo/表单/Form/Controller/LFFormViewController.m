//
//  LFFormViewController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/9/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFFormViewController.h"
#import "LFFormHeaderFooterView.h"
#import "LFFormTextFieldCell.h"
#import "LFFormSwitchCell.h"
#import "LFFormCustomCell.h"
#import "LFFormSelectCell.h"

@interface LFFormViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,weak,readwrite) UITableView *tableView;

@end

@implementation LFFormViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.tableFooterView = UIView.new;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.allowsSelection = NO;
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

}

#pragma mark -
#pragma mark - 给模型赋值，刷新表格
- (void)setGroupMs:(NSArray<LFFormGroupModel *> *)groupMs
{
    _groupMs = groupMs;
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark - 初始化UI
- (void)setupUI
{
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"tableView": self.tableView};
    NSArray *hCon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:NSLayoutFormatAlignAllLeft | NSLayoutAttributeRight metrics:nil views:views];
    [self.view addConstraints:hCon];
    
    NSArray *vCon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[tableView]-0-|" options:NSLayoutFormatAlignAllTop | NSLayoutAttributeBottom metrics:nil views:views];
    [self.view addConstraints:vCon];
}

#pragma mark -
#pragma mark - 表代理 UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupMs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupMs[section].rowMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSObject *rowM = self.groupMs[indexPath.section].rowMs[indexPath.row];
    if ([rowM isKindOfClass:[LFFormTextFiledModel class]]) {
        LFFormTextFieldCell *cell = [LFFormTextFieldCell textFieldCellWithTableView:tableView];
        cell.tfM = (LFFormTextFiledModel *)rowM;
        return cell;
    }else if ([rowM isKindOfClass:[LFFormSelectModel class]]) {
        LFFormSelectCell *cell = [LFFormSelectCell selectCellWithTableView:tableView];
        cell.sM = (LFFormSelectModel *)rowM;
        return cell;
    }else if ([rowM isKindOfClass:[LFFormSwitchModel class]]) {
        LFFormSwitchCell *cell = [LFFormSwitchCell switchCellWithTableView:tableView];
        cell.sM = (LFFormSwitchModel *)rowM;
        return cell;
    }else if ([rowM isKindOfClass:[LFFormCustomModel class]]) {
        LFFormCustomCell *cell = [LFFormCustomCell customCellWithTableView:tableView];
        cell.cM = (LFFormCustomModel *)rowM;
        return cell;
    }else {
        static NSString *lfTableViewCell_id = @"UITableViewCell_default";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lfTableViewCell_id];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lfTableViewCell_id];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@", indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LFFormHeaderFooterView *headerView = [LFFormHeaderFooterView formHeaderFooterViewWithTableView:tableView];
    headerView.headerFooterM = self.groupMs[section].headerM;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LFFormHeaderFooterView *footerView = [LFFormHeaderFooterView formHeaderFooterViewWithTableView:tableView];
    footerView.headerFooterM = self.groupMs[section].footerM;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.groupMs[section].headerM.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.groupMs[section].footerM.height;
}

@end
