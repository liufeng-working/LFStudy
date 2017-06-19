//
//  ViewController.m
//  图片折叠
//
//  Created by 刘丰 on 2017/6/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomView;
@property(nonatomic,weak) CAGradientLayer *gradientLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.topView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.topView.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.bottomView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bottomView.bounds;
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
//    gradientLayer.locations = @[@0.5];
    gradientLayer.opacity = 0;
    [self.bottomView.layer addSublayer:gradientLayer];
    _gradientLayer = gradientLayer;
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    CGPoint point = [sender translationInView:sender.view];
    CGFloat angle = point.y/140*M_PI;
    
    //近大远小
    CATransform3D transform = CATransform3DIdentity;
    //眼睛离屏幕的距离
    transform.m34 = -1/300.0;
    
    self.topView.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);
    self.gradientLayer.opacity = point.y/140;
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.topView.layer.transform = CATransform3DIdentity;
            self.gradientLayer.opacity = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
