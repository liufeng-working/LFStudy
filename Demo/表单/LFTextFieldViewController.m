//
//  LFTextFieldViewController.m
//  表单
//
//  Created by 刘丰 on 2017/10/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTextFieldViewController.h"

@interface LFTextFieldViewController ()

@end

@implementation LFTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i ++) {
        LFFormTextFiledModel *tfM = [LFFormTextFiledModel new];
        tfM.leftTitle = [NSString stringWithFormat:@"详细地址-%zd", i];
        tfM.placeholder = [NSString stringWithFormat:@"请输入详细地址-%zd", i];
        tfM.keyboardType = i%4;
        
        __weak typeof(self) weakSelf = self;
        tfM.returnClick = ^BOOL{
            NSLog(@"%@", weakSelf);
            return YES;
        };
        [arr addObject:tfM];
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
