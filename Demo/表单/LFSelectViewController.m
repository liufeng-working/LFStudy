//
//  LFSelectViewController.m
//  表单
//
//  Created by 刘丰 on 2017/10/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFSelectViewController.h"

@interface LFSelectViewController ()

@end

@implementation LFSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i ++) {
        LFFormSelectModel *sM = [LFFormSelectModel new];
        sM.leftTitle = [NSString stringWithFormat:@"详细地址-%zd", i];
        sM.placeholder = [NSString stringWithFormat:@"请输入详细地址-%zd", i];
        sM.click = ^(NSString *rightText, void (^rightShow)(NSString *showText)) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (rightShow) {
                    rightShow([NSString stringWithFormat:@"%@+%zd", rightText, i]);
                }
            });
        };
        [arr addObject:sM];
    }
    
    LFFormHeaderFooterModel *headerM = [LFFormHeaderFooterModel new];
    headerM.text = @"区头";
    headerM.height = 15;
    headerM.backgroundColor = [UIColor blueColor];
    
    LFFormHeaderFooterModel *footerM = [LFFormHeaderFooterModel new];
    footerM.text = @"区尾";
    footerM.height = 0;
    footerM.backgroundColor = [UIColor redColor];
    
    LFFormGroupModel *g = [LFFormGroupModel new];
    g.headerM = headerM;
    g.footerM = footerM;
    g.rowMs = arr;
    
    self.groupMs = @[g];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
