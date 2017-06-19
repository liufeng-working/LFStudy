//
//  ViewController.m
//  LFAnimation
//
//  Created by 刘丰 on 2017/6/17.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,weak) CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = self.view.center;
//    layer.anchorPoint = CGPointMake(0, 0);
    layer.contents = (__bridge id)[UIImage imageNamed:@"5"].CGImage;
    [self.view.layer addSublayer:layer];
    _layer = layer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // Dispose of any resources that can be recreated.
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:1];
    self.layer.position = CGPointMake(100, 400);
    [CATransaction commit];
    
    [UIView animateWithDuration:1 animations:^{
        
//        self.imageView.layer.transform = CATransform3DMakeRotation(M_PI/4, 0, 0, 1);
        [self.imageView.layer setValue:@(M_PI/4) forKeyPath:@"transform.rotation"];
        [self.imageView.layer setValue:@1.5 forKeyPath:@"transform.scale"];
    }];
}

- (void)imageViewLayer
{
    self.imageView.layer.shadowOpacity = 1;
    self.imageView.layer.shadowColor = [UIColor blueColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(30, 30);
    self.imageView.layer.shadowRadius = 5;
    
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imageView.layer.borderWidth = 2;
    
    self.imageView.layer.cornerRadius = 30;
    self.imageView.layer.masksToBounds = YES;
    
    NSLog(@"%@", self.imageView.layer.contents);
}

- (void)viewLayer
{
    self.redView.layer.shadowOpacity = 1;
    self.redView.layer.shadowColor = [UIColor blueColor].CGColor;
    self.redView.layer.shadowOffset = CGSizeMake(30, 30);
    self.redView.layer.shadowRadius = 5;
    
    self.redView.layer.borderColor = [UIColor blackColor].CGColor;
    self.redView.layer.borderWidth = 2;
    
    self.redView.layer.cornerRadius = 30;
}

@end
