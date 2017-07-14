//
//  ViewController.m
//  strong字符串
//
//  Created by 刘丰 on 2017/7/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong) NSString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSString *name = @"liufeng";
    NSMutableString *name = [[NSMutableString alloc] initWithString:@"liufeng"];
    self.name = name;
    NSLog(@"%p---%p", name, self.name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
