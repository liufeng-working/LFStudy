//
//  ViewController.m
//  Copy概念
//
//  Created by 刘丰 on 2017/7/9.
//  Copyright © 2017年 liufeng. All rights reserved.
//  copy => 不可变
//  mutableCopy => 不可变

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"liufeng"];
    NSLog(@"%@---%p---%p", str, str, &str);
    
    NSString *cStr = str.copy;
    NSLog(@"%@---%p---%p", cStr, cStr, &cStr);
    
    NSMutableString *mStr = str.mutableCopy;
    NSLog(@"%@---%p---%p", mStr, mStr, &mStr);
    
    [str appendString:@" xihuan chenbei"];
    NSLog(@"%@---%@---%@", str, cStr, mStr);
}
- (IBAction)save:(id)sender {
}

- (void)test
{
    NSString *str = @"liufeng";
    NSLog(@"%@---%p---%p", str, str, &str);
    
    NSString *cStr = str.copy;
    NSLog(@"%@---%p---%p", cStr, cStr, &cStr);
    
    NSMutableString *mStr = str.mutableCopy;
    NSLog(@"%@---%p---%p", mStr, mStr, &mStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
