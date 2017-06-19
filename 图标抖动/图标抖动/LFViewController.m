//
//  LFViewController.m
//  图标抖动
//
//  Created by 刘丰 on 2017/6/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFViewController.h"

@interface LFViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

static int i = 2;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    i ++;
    if (i == 5) {
        i = 2;
    }
    NSString *name = [NSString stringWithFormat:@"%d", i];
    self.imageView.image = [UIImage imageNamed:name];
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    animation.startProgress = 0.5;
    animation.endProgress = 0.8;
    [self.imageView.layer addAnimation:animation forKey:nil];
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
