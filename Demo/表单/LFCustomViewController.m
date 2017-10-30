//
//  LFCustomViewController.m
//  表单
//
//  Created by 刘丰 on 2017/10/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFCustomViewController.h"

@interface LFCustomViewController ()

@end

@implementation LFCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i ++) {
        LFFormCustomModel *cM = [LFFormCustomModel new];
        cM.height = 20*(i + 1);
        cM.customView = [[UISwitch alloc] init];
        [arr addObject:cM];
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
