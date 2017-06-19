//
//  LFViewController.m
//  图片折叠
//
//  Created by 刘丰 on 2017/6/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFViewController.h"

@interface LFViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAReplicatorLayer *rLayer = (CAReplicatorLayer *)self.view.layer;
    rLayer.instanceCount = 2;
    rLayer.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    rLayer.instanceRedOffset -= 0.2;
    rLayer.instanceGreenOffset -= 0.2;
    rLayer.instanceBlueOffset -= 0.3;
    rLayer.instanceAlphaOffset -= 0.4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
