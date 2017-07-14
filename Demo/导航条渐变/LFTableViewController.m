//
//  LFTableViewController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTableViewController.h"

#define kHead 200
#define KBar 44
#define kStatus 20
#define kTop (kHead + KBar)
@interface LFTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,weak) UILabel *titleL;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightC;


@end

@implementation LFTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(kTop, 0, 0, 0);
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"刘丰";
    [title sizeToFit];
    title.textColor = [UIColor colorWithWhite:0 alpha:0];
    self.navigationItem.titleView = title;
    self.titleL = title;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = offsetY + kTop;
    CGFloat currentH = kHead - offsetH;
    CGFloat minH = kStatus + KBar;
    if (currentH <= minH) {
        currentH = minH;
    }
    self.heightC.constant = currentH;
    
    CGFloat maxH = (kHead - kStatus - KBar)*1.0;
    CGFloat alpha = offsetH/maxH >= 1 ? 0.99 : offsetH/maxH;
    
    UIColor *color = [UIColor colorWithWhite:1 alpha:alpha];
    UIImage *image = [self imageFromColor:color];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
}

- (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
