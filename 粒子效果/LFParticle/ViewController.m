//
//  ViewController.m
//  LFParticle
//
//  Created by 刘丰 on 2017/6/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFVCView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet LFVCView *vcView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (IBAction)start:(UIButton *)sender {
    [self.vcView start];
}

- (IBAction)redraw:(UIButton *)sender {
    [self.vcView redraw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
