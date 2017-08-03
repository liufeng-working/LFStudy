//
//  ViewController.m
//  瀑布流
//
//  Created by 刘丰 on 2017/8/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFCollectionViewWaterfallLayout.h"
#import "LFBeauty.h"
#import "LFBeautyCell.h"

static NSString *identifier = @"cell";
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, LFCollectionViewDelegateWaterfallLayout>

@property(nonatomic,weak) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray *beautys;

@end

@implementation ViewController

- (NSMutableArray *)beautys
{
    if (!_beautys) {
        _beautys = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"beauty.plist" ofType:nil];
        NSArray *beautys = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dic in beautys) {
             LFBeauty *beauty = [LFBeauty beautyWithDic:dic];
            [_beautys addObject:beauty];
        }
    }
    return _beautys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    LFCollectionViewWaterfallLayout *layout = [[LFCollectionViewWaterfallLayout alloc] init];
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, width, 716) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor brownColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:@"LFBeautyCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.beautys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LFBeautyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.beauty = self.beautys[indexPath.item];
    return cell;
}

#pragma mark -
#pragma mark - LFCollectionViewDelegateWaterfallLayout
- (CGSize)waterfallLayout:(LFCollectionViewWaterfallLayout *)waterfallLayout sizeForItemAtIndex:(NSUInteger)index
{
    LFBeauty *beauty = self.beautys[index];
    return CGSizeMake(beauty.width, beauty.height);
}

- (NSUInteger)columnInLayout:(LFCollectionViewWaterfallLayout *)waterfallLayout
{
    return 2;
}

- (UIEdgeInsets)insetInLayout:(LFCollectionViewWaterfallLayout *)waterfallLayout
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)rowSpacingInLayout:(LFCollectionViewWaterfallLayout *)waterfallLayout
{
    return 5;
}

- (CGFloat)columnSpacingInLayout:(LFCollectionViewWaterfallLayout *)collectionViewLayout
{
    return 5;
}

@end
