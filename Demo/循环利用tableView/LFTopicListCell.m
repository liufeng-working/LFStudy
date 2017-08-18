//
//  LFTopicListCell.m
//  LFStudy
//
//  Created by 刘丰 on 2017/8/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTopicListCell.h"

@interface LFTopicListCell ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LFTopicListCell

- (void)setModule:(NSString *)module
{
    _module = module;
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const ID = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", self.module, indexPath.row];
    return cell;
}

@end
