//
//  ViewController.m
//  LFLottery
//
//  Created by 刘丰 on 2017/6/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFWheelView.h"

@interface ViewController ()

@property(nonatomic,weak) LFWheelView *wheelView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LFWheelView *wheelView = [LFWheelView wheelView];
    wheelView.center = self.view.center;
    [self.view addSubview:wheelView];
    _wheelView = wheelView;
    
    NSLog(@"%@", [UIImage imageNamed:@"1"]);
    NSLog(@"%@", [UIImage imageNamed:@"2"]);
}

- (IBAction)rotation:(UIButton *)sender {
    [self.wheelView rotation];
}

- (IBAction)stop:(id)sender {
    [self.wheelView stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
