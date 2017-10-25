//
//  ViewController.m
//  表单
//
//  Created by 刘丰 on 2017/9/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    LFFormTextFiledModel *tfM1 = [LFFormTextFiledModel new];
    tfM1.leftTitle = @"详细地址";
    tfM1.placeholder = @"请输入详细地址";
    
    LFFormSwitchModel *sM1 = [LFFormSwitchModel new];
    sM1.leftTitle = @"居住地城市";
    sM1.isOn = YES;
    
    LFFormSwitchModel *sM2 = [LFFormSwitchModel new];
    sM2.leftTitle = @"居住地区";
    sM2.isOn = YES;
    
    LFFormSwitchModel *sM3 = [LFFormSwitchModel new];
    sM3.leftTitle = @"居住地县";
    sM3.isOn = YES;
    
    LFFormSwitchModel *sM4 = [LFFormSwitchModel new];
    sM4.leftTitle = @"居住地镇";
    sM4.isOn = YES;
    
    LFFormSwitchModel *sM5 = [LFFormSwitchModel new];
    sM5.leftTitle = @"居住地村";
    sM5.isOn = YES;
    
    LFFormCustomModel *cM1 = [LFFormCustomModel new];
    cM1.height = 100;
    LFFormCustomModel *cM2 = [LFFormCustomModel new];
    cM2.height = 200;
    
    LFFormSelectModel *seM1 = [LFFormSelectModel new];
    seM1.leftTitle = @"居住地省份";
    seM1.placeholder = @"请选择居住地省份";
    seM1.selectCallback = ^(NSString *rightText, void(^rightShow)(NSString *showText)) {
        if (rightShow) {
            rightShow(@"点击了");
        }
    };
    
    LFFormSelectModel *seM2 = [LFFormSelectModel new];
    seM2.leftTitle = @"居住地省份";
    seM2.selectCallback = ^(NSString *rightText, void(^rightShow)(NSString *showText)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (rightShow) {
                rightShow(@"点击了");
            }
        });
    };

    LFFormHeaderFooterModel *headerM1 = [LFFormHeaderFooterModel new];
    headerM1.text = @"设置";
    headerM1.height = 15;
    headerM1.backgroundColor = [UIColor blueColor];
    LFFormHeaderFooterModel *footerM1 = [LFFormHeaderFooterModel new];
    LFFormGroupModel *g1 = [LFFormGroupModel new];
    g1.headerM = headerM1;
    g1.footerM = footerM1;
    g1.rowMs = @[tfM1, sM1, sM2, sM3, sM4, sM5, seM1, seM2, cM1, cM2];
    
    LFFormHeaderFooterModel *headerM2 = [LFFormHeaderFooterModel new];
    headerM2.height = 15;
    headerM2.backgroundColor = [UIColor orangeColor];
    LFFormHeaderFooterModel *footerM2 = [LFFormHeaderFooterModel new];
    LFFormGroupModel *g2 = [LFFormGroupModel new];
    g2.headerM = headerM2;
    g2.footerM = footerM2;
    g2.rowMs = @[tfM1, sM1, sM2, sM3, sM4, sM5, seM1, seM2, cM1, cM2];
    
    LFFormHeaderFooterModel *headerM4 = [LFFormHeaderFooterModel new];
    headerM4.height = 15;
    headerM4.backgroundColor = [UIColor greenColor];
    LFFormHeaderFooterModel *footerM4 = [LFFormHeaderFooterModel new];
    LFFormGroupModel *g4 = [LFFormGroupModel new];
    g4.headerM = headerM4;
    g4.footerM = footerM4;
    g4.rowMs = @[tfM1, sM1, sM2, sM3, sM4, sM5, seM1, seM2, cM1, cM2];
    
    LFFormHeaderFooterModel *headerM5 = [LFFormHeaderFooterModel new];
    headerM5.height = 15;
    headerM5.backgroundColor = [UIColor blueColor];
    LFFormHeaderFooterModel *footerM5 = [LFFormHeaderFooterModel new];
    LFFormGroupModel *g5 = [LFFormGroupModel new];
    g5.headerM = headerM5;
    g5.footerM = footerM5;
    g5.rowMs = @[tfM1, sM1, sM2, sM3, sM4, sM5, seM1, seM2, cM1, cM2];
    
    self.groupMs = @[g1, g2, g4, g5];
}

@end
