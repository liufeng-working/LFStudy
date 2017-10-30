//
//  LFPhotoViewController.m
//  表单
//
//  Created by 刘丰 on 2017/10/27.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFPhotoViewController.h"

@interface LFPhotoViewController ()

@end

@implementation LFPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i ++) {
        LFFormPhotoModel *pM = [LFFormPhotoModel new];
        pM.title = [NSString stringWithFormat:@"证书-%zd", i];
        pM.desc = @"请上传证书图片";
        pM.maxCount = i + 1;
        pM.addImage = i%2 ? [UIImage imageNamed:@"camrea"] : nil;
        pM.deleteImage = i%2 ? nil : [UIImage imageNamed:@"delete"];
        pM.clickImage = ^(NSUInteger index) {
            NSLog(@"选中了%zd", index);
        };
        [arr addObject:pM];
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
