//
//  LFHybridViewController.m
//  表单
//
//  Created by 刘丰 on 2017/10/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFHybridViewController.h"

@interface LFHybridViewController ()

@end

@implementation LFHybridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    LFFormTextFiledModel *tfM1 = [LFFormTextFiledModel new];
    tfM1.leftTitle = @"详细地址";
    tfM1.placeholder = @"请输入详细地址";
    tfM1.keyboardType = UIKeyboardTypeURL;
    tfM1.returnClick = ^BOOL{
        return YES;
    };
    
    LFFormTextFiledModel *tfM2 = [LFFormTextFiledModel new];
    tfM2.leftTitle = @"详细地址";
    tfM2.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM3 = [LFFormTextFiledModel new];
    tfM3.leftTitle = @"详细地址";
    tfM3.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM4 = [LFFormTextFiledModel new];
    tfM4.leftTitle = @"详细地址";
    tfM4.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM5 = [LFFormTextFiledModel new];
    tfM5.leftTitle = @"详细地址";
    tfM5.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM6 = [LFFormTextFiledModel new];
    tfM6.leftTitle = @"详细地址";
    tfM6.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM7 = [LFFormTextFiledModel new];
    tfM7.leftTitle = @"详细地址";
    tfM7.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM8 = [LFFormTextFiledModel new];
    tfM8.leftTitle = @"详细地址";
    tfM8.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM9 = [LFFormTextFiledModel new];
    tfM9.leftTitle = @"详细地址";
    tfM9.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM10 = [LFFormTextFiledModel new];
    tfM10.leftTitle = @"详细地址";
    tfM10.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM11 = [LFFormTextFiledModel new];
    tfM11.leftTitle = @"详细地址";
    tfM11.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM12 = [LFFormTextFiledModel new];
    tfM12.leftTitle = @"详细地址";
    tfM12.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM13 = [LFFormTextFiledModel new];
    tfM13.leftTitle = @"详细地址";
    tfM13.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM14 = [LFFormTextFiledModel new];
    tfM14.leftTitle = @"详细地址";
    tfM14.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM15 = [LFFormTextFiledModel new];
    tfM15.leftTitle = @"详细地址";
    tfM15.placeholder = @"请输入详细地址";
    
    LFFormTextFiledModel *tfM16 = [LFFormTextFiledModel new];
    tfM16.leftTitle = @"详细地址";
    tfM16.placeholder = @"请输入详细地址";
    
    LFFormSwitchModel *sM1 = [LFFormSwitchModel new];
    sM1.leftTitle = @"居住城市";
    sM1.isOn = YES;
    
    LFFormSwitchModel *sM2 = [LFFormSwitchModel new];
    sM2.leftTitle = @"居住区";
    sM2.isOn = YES;
    
    LFFormSwitchModel *sM3 = [LFFormSwitchModel new];
    sM3.leftTitle = @"居住县";
    sM3.isOn = YES;
    
    LFFormSwitchModel *sM4 = [LFFormSwitchModel new];
    sM4.leftTitle = @"居住镇";
    sM4.isOn = YES;
    
    LFFormSwitchModel *sM5 = [LFFormSwitchModel new];
    sM5.leftTitle = @"居住村";
    sM5.isOn = YES;
    
    LFFormCustomModel *cM1 = [LFFormCustomModel new];
    cM1.height = 100;
    cM1.customView = [UISwitch new];
    
    LFFormCustomModel *cM2 = [LFFormCustomModel new];
    cM2.height = 200;
    
    LFFormSelectModel *seM1 = [LFFormSelectModel new];
    seM1.leftTitle = @"居住省份";
    seM1.placeholder = @"请选择居住地省份";
    seM1.click = ^(NSString *rightText, void(^rightShow)(NSString *showText)) {
        if (rightShow) {
            rightShow(@"点击了");
        }
    };
    
    LFFormSelectModel *seM2 = [LFFormSelectModel new];
    seM2.leftTitle = @"居住国家";
    seM2.click = ^(NSString *rightText, void(^rightShow)(NSString *showText)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (rightShow) {
                rightShow(@"点击了");
            }
        });
    };
    
    LFFormPhotoModel *pm1 = [LFFormPhotoModel new];
    pm1.title = @"证书";
    pm1.desc = @"请上传证书图片";
    pm1.maxCount = 0;
    pm1.addImage = [UIImage imageNamed:@"camrea"];
    pm1.deleteImage = [UIImage imageNamed:@"delete"];
    pm1.clickImage = ^(NSUInteger index) {
        NSLog(@"%zd", index);
    };
    
    LFFormPhotoModel *pm2 = [LFFormPhotoModel new];
    pm2.title = @"执照";
    pm2.desc = @"请上传执照图片";
    pm2.maxCount = 1;
    
    LFFormPhotoModel *pm3 = [LFFormPhotoModel new];
    pm3.title = @"结婚证";
    pm3.desc = @"请上传结婚证图片";
    pm3.maxCount = 3;
    
    LFFormPhotoModel *pm4 = [LFFormPhotoModel new];
    pm4.title = @"毕业证";
    pm4.desc = @"请上传毕业证图片";
    pm4.maxCount = 5;
    
    LFFormHeaderFooterModel *headerM1 = [LFFormHeaderFooterModel new];
    headerM1.text = @"设置";
    headerM1.height = 15;
    headerM1.backgroundColor = [UIColor blueColor];
    LFFormHeaderFooterModel *footerM1 = [LFFormHeaderFooterModel new];
    LFFormGroupModel *g1 = [LFFormGroupModel new];
    g1.headerM = headerM1;
    g1.footerM = footerM1;
    g1.rowMs = @[tfM1, tfM2, sM1, seM1, sM2, cM1, tfM3, tfM4, sM3, cM2, sM4, pm1, sM5, seM2];
    
    LFFormHeaderFooterModel *headerM2 = [LFFormHeaderFooterModel new];
    headerM2.height = 15;
    headerM2.backgroundColor = [UIColor orangeColor];
    LFFormHeaderFooterModel *footerM2 = [LFFormHeaderFooterModel new];
    LFFormGroupModel *g2 = [LFFormGroupModel new];
    g2.headerM = headerM2;
    g2.footerM = footerM2;
    g2.rowMs = @[tfM5, tfM6, sM1, seM1, sM2, cM1, tfM7, tfM8, sM3, cM2, sM4, pm1, sM5, seM2];
    
    LFFormHeaderFooterModel *headerM4 = [LFFormHeaderFooterModel new];
    headerM4.height = 15;
    headerM4.backgroundColor = [UIColor greenColor];
    LFFormHeaderFooterModel *footerM4 = [LFFormHeaderFooterModel new];
    LFFormGroupModel *g4 = [LFFormGroupModel new];
    g4.headerM = headerM4;
    g4.footerM = footerM4;
    g4.rowMs = @[tfM9, tfM10, sM1, seM1, sM2, cM1, tfM11, tfM12, sM3, cM2, sM4, pm1, sM5, seM2];
    
    LFFormHeaderFooterModel *headerM5 = [LFFormHeaderFooterModel new];
    headerM5.height = 15;
    headerM5.backgroundColor = [UIColor blueColor];
    LFFormHeaderFooterModel *footerM5 = [LFFormHeaderFooterModel new];
    LFFormGroupModel *g5 = [LFFormGroupModel new];
    g5.headerM = headerM5;
    g5.footerM = footerM5;
    g5.rowMs = @[tfM13, tfM14, sM1, seM1, sM2, cM1, tfM15, tfM16, sM3, cM2, sM4, pm1, sM5, seM2];
    
    self.groupMs = @[g1, g2, g4, g5];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
