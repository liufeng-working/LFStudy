//
//  LFViewController.m
//  extension
//
//  Created by 刘丰 on 2017/12/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFViewController.h"
#import "LFTool.h"

@interface LFViewController ()

@property(nonatomic,strong) NSMutableArray<NSString *> *todays;

@end

@implementation LFViewController

- (NSMutableArray<NSString *> *)todays
{
    if (!_todays) {
        _todays = LFTool.get;
    }
    return _todays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)add:(id)sender {
    [LFTool add];
    self.todays = LFTool.get;
    [self.tableView reloadData];
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
