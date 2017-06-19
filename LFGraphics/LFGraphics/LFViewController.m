//
//  LFViewController.m
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/15.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFViewController.h"

@interface LFViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:sender.view];
    CGFloat WH = 30;
    CGFloat x = point.x - WH*0.5;
    CGFloat y = point.y - WH*0.5;
    CGRect rect = CGRectMake(x, y, WH, WH);
    
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.imageView.layer renderInContext:ctx];
    CGContextClearRect(ctx, rect);
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
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
