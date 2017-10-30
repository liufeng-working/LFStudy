//
//  LFSwitchViewController.m
//  表单
//
//  Created by 刘丰 on 2017/10/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFSwitchViewController.h"

@interface LFSwitchViewController ()

@end

@implementation LFSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i ++) {
        LFFormSwitchModel *sM = [LFFormSwitchModel new];
        sM.leftTitle = [NSString stringWithFormat:@"居住城市-%zd", i];
        sM.isOn = i%2;
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
