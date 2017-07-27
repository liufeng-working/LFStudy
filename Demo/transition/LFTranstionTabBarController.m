//
//  LFTranstionTabBarController.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTranstionTabBarController.h"

@interface LFTranstionTabBarController ()<UITabBarControllerDelegate>



@end

@implementation LFTranstionTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
}

@end
