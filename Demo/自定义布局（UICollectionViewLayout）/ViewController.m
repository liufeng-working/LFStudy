//
//  ViewController.m
//  自定义布局（UICollectionViewLayout）
//
//  Created by 刘丰 on 2017/8/2.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFCollectionViewFlowTrandformLayout.h"

static NSString *identifier = @"cell";
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    LFCollectionViewFlowTrandformLayout *layout = [[LFCollectionViewFlowTrandformLayout alloc] init];
    layout.itemSize = CGSizeMake(180, 180);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, width, 200) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor brownColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.contentInset = UIEdgeInsetsMake(0, width*0.5 - 90, 0, width*0.5 - 90);
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

@end
