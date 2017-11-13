//
//  LFTextViewController.m
//  TextView
//
//  Created by 刘丰 on 2017/11/10.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFTextViewController.h"
#import "IQUIView+Hierarchy.h"

@interface LFTextViewController ()

@end

@implementation LFTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", [self.view topMostController]);
    
}

@end
