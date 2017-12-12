//
//  TodayViewController.m
//  无人机管理
//
//  Created by 刘丰 on 2017/12/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "LFTool.h"

#define lf_contentHeight 44
@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property(nonatomic,strong) NSMutableArray<NSString *> *todays;

@end

@implementation TodayViewController

- (NSMutableArray<NSString *> *)todays
{
    if (!_todays) {
        _todays = [NSMutableArray array];
    }
    return _todays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 10.0, *)) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    
    [self setupUI];
    [self loadData];
}

#pragma mark -
#pragma mark - UI相关
- (void)setupUI
{
    self.addBtn.layer.cornerRadius = 5;
    self.tableView.rowHeight = lf_contentHeight;
}

#pragma mark -
#pragma mark - 取数据
- (void)loadData
{
    self.todays = LFTool.get;
    if (self.todays.count) {
        self.addBtn.hidden = YES;
        self.tableView.hidden = NO;
        self.preferredContentSize = CGSizeMake(self.preferredContentSize.width, lf_contentHeight*self.todays.count);
    }else {
        self.addBtn.hidden = NO;
        self.tableView.hidden = YES;
        self.preferredContentSize = CGSizeMake(self.preferredContentSize.width, lf_contentHeight);
    }
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark - 添加按钮
- (IBAction)add:(id)sender {
    [self.extensionContext openURL:[NSURL URLWithString:@"uavmanager://"] completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"跳转成功");
        }
    }];
}

#pragma mark -
#pragma mark - NCWidgetProviding
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    
    [self loadData];
    completionHandler(NCUpdateResultNewData);
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize NS_AVAILABLE_IOS(10_0) {
//    self.preferredContentSize = maxSize;
    NSLog(@"%d", activeDisplayMode);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"my_setting"];
    cell.textLabel.text = @"Date";
    cell.detailTextLabel.text = self.todays[indexPath.row];
    
    return cell;
}

@end
