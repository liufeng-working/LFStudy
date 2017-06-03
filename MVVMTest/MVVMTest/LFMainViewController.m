//
//  LFMainViewController.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFMainViewController.h"
#import "LFMainViewModel.h"
#import "LFMovieCell.h"
#import "LFDetailViewController.h"

@interface LFMainViewController ()

@property(nonatomic,strong) LFMainViewModel *mainVM;

@property(nonatomic,strong) NSArray<LFMovieModel *> *movies;

@end

@implementation LFMainViewController

- (LFMainViewModel *)mainVM
{
    if (!_mainVM) {
        _mainVM = [LFMainViewModel new];
    }
    return _mainVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    RACSignal *signal = [self.mainVM.requestCommand execute:nil];
    [signal subscribeNext:^(LFMovies * _Nullable x) {
        self.title = x.title;
        self.movies = x.subjects;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LFMovieModel *movieM = self.movies[indexPath.row];
    LFMovieCell *cell = [LFMovieCell movieCellWithTableView:tableView];
    cell.movieM = movieM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LFMovieModel *movieM = self.movies[indexPath.row];
    [self performSegueWithIdentifier:@"to_detail" sender:movieM];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LFDetailViewController *detialVC = segue.destinationViewController;
    detialVC.detailVM = [self.mainVM creatDetailViewModelWith:sender];
}

@end
