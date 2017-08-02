//
//  LFTableViewController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/8/2.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTableViewController.h"
#import "LFEyeView.h"

@interface LFTableViewController ()

@property(nonatomic,strong) LFEyeView *eyeView;

@end

@implementation LFTableViewController

- (LFEyeView *)eyeView
{
    if (!_eyeView) {
        _eyeView = [[LFEyeView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
        _eyeView.backgroundColor = [UIColor redColor];
    }
    return _eyeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    [bgView addSubview:self.eyeView];
    self.tableView.tableHeaderView = bgView;
    [self.eyeView setupSublayer];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", indexPath];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.eyeView animationWith:scrollView.contentOffset.y - 100];
}

@end
