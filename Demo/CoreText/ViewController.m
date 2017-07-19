//
//  ViewController.m
//  CoreText
//
//  Created by 刘丰 on 2017/7/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(testWindow) userInfo:nil repeats:YES];
}

- (void)testWindow
{
    
    NSLog(@"%@", self.view.window);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
