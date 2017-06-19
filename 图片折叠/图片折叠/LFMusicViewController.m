//
//  LFMusicViewController.m
//  图片折叠
//
//  Created by 刘丰 on 2017/6/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFMusicViewController.h"

@interface LFMusicViewController ()

@property (weak, nonatomic) IBOutlet UIView *graYView;

@end

@implementation LFMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.frame = self.graYView.bounds;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.instanceCount = 5;
    layer.instanceDelay = 0.5;
    layer.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    [self.graYView.layer addSublayer:layer];
    
    CALayer *layer1 = [CALayer layer];
    layer1.backgroundColor = [UIColor greenColor].CGColor;
    layer1.bounds = CGRectMake(0, 0, 30, 200);
    layer1.anchorPoint = CGPointMake(0.5, 1);
    layer1.position = CGPointMake(20, CGRectGetHeight(self.graYView.frame));
    [layer addSublayer:layer1];
 
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale.y";
    scale.toValue = @0;
    scale.autoreverses = YES;
    scale.repeatCount = MAXFLOAT;
    scale.duration = 1;
    [layer1 addAnimation:scale forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 30, 200);
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(20, CGRectGetHeight(self.graYView.frame));
    [self.graYView.layer addSublayer:layer];
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale.y";
    scale.toValue = @0;
    scale.autoreverses = YES;
    scale.repeatCount = MAXFLOAT;
    scale.duration = 1;
    [layer addAnimation:scale forKey:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
