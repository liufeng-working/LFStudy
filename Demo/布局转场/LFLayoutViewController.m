//
//  LFLayoutViewController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFLayoutViewController.h"

@interface LFLayoutViewController ()

@end

@implementation LFLayoutViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        LFLayoutViewController *vc = [[LFLayoutViewController alloc] initWithCollectionViewLayout:layout];
        vc.title = @"季度";
        vc.useLayoutToLayoutNavigationTransitions = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (indexPath.item == 1) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(150, 150);
        LFLayoutViewController *vc = [[LFLayoutViewController alloc] initWithCollectionViewLayout:layout];
        vc.title = @"月度";
        vc.useLayoutToLayoutNavigationTransitions = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (indexPath.item == 2) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(200, 200);
        LFLayoutViewController *vc = [[LFLayoutViewController alloc] initWithCollectionViewLayout:layout];
        vc.title = @"周度";
        vc.useLayoutToLayoutNavigationTransitions = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.item == 3) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(250, 250);
        LFLayoutViewController *vc = [[LFLayoutViewController alloc] initWithCollectionViewLayout:layout];
        vc.title = @"天度";
        vc.useLayoutToLayoutNavigationTransitions = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
