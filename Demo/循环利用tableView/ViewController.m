//
//  ViewController.m
//  循环利用tableView
//
//  Created by 刘丰 on 2017/8/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFTopicListCell.h"

static NSString *const lf_LFTopicListCell = @"LFTopicListCell";
@interface ViewController ()<UICollectionViewDataSource>

@property(nonatomic,strong) NSArray *modules;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modules = @[@"政治", @"新闻", @"头条", @"焦点", @"社会", @"政治1", @"新闻1", @"头条1", @"焦点1", @"社会1", @"政治2", @"新闻2", @"头条2", @"焦点2", @"社会2"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.view.bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor redColor];
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    [self.view addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:@"LFTopicListCell" bundle:nil] forCellWithReuseIdentifier:lf_LFTopicListCell];
}

#pragma mark -
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modules.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LFTopicListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:lf_LFTopicListCell forIndexPath:indexPath];
    cell.module = self.modules[indexPath.row];
    return cell;
}

@end
