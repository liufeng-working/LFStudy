//
//  ViewController.m
//  表单
//
//  Created by 刘丰 on 2017/9/4.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFGeneric.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LFGeneric<NSNumber *> *gene = [[LFGeneric alloc] init];
    gene.callBack = ^(ObjectType item) {
        <#code#>
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
