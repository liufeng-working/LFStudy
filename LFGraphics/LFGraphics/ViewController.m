//
//  ViewController.m
//  LFGraphics
//
//  Created by 刘丰 on 2017/6/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import "LFRedView.h"
#import "LFImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet LFRedView *redView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,weak) UIImageView *imgV;

@property(nonatomic,weak) LFImageView *imgV1;

@property(nonatomic,assign) CGPoint startP;
@property(nonatomic,assign) CGPoint changeP;

@property(nonatomic,strong) UIView *coverV;

@end

@implementation ViewController

- (UIView *)coverV
{
    if (!_coverV) {
        _coverV = [[UIView alloc] init];
        _coverV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [self.view addSubview:_coverV];
    }
    return _coverV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //graphics context  CGContextRef类型
    
//    UIPageViewController
    
    NSLog(@"%s", __func__);
    
    UIImage *image = [UIImage imageNamed:@"icon"];
    NSLog(@"%@", image);
    
    CGSize size = CGSizeMake(image.size.width + 2*10, image.size.height + 2*10);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, size.width, size.height));
    CGContextSetFillColorWithColor(ctx, UIColor.redColor.CGColor);
    CGContextFillPath(ctx);
    CGRect rect = CGRectMake(10, 10, image.size.width, image.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [image drawInRect:rect];
    UIImage *mmm = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageView *imgV3 = [[UIImageView alloc] initWithImage:mmm];
    imgV3.frame = CGRectMake(0, 350, mmm.size.width, mmm.size.height);
    [self.view addSubview:imgV3];
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextAddEllipseInRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, 70, 70));
    CGContextClip(UIGraphicsGetCurrentContext());
    [image drawAtPoint:CGPointZero];
    UIImage *image2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgV2 = [[UIImageView alloc] initWithImage:image2];
    imgV2.frame = CGRectMake(0, 150, image2.size.width, image2.size.height);
    [self.view addSubview:imgV2];
    
    return;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    NSData *imgD = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext());
    [imgD writeToFile:@"/Users/liufeng/Desktop/test.png" atomically:YES];
    UIGraphicsEndImageContext();
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            self.startP = point;
            
        }
            break;
        case UIGestureRecognizerStateChanged: {
            self.changeP = point;
            
            self.coverV.frame = CGRectMake(self.startP.x, self.startP.y, self.changeP.x - self.startP.x, self.changeP.y - self.startP.y);
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
        
            UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
            CGContextAddRect(UIGraphicsGetCurrentContext(), self.coverV.frame);
            CGContextClip(UIGraphicsGetCurrentContext());
            [self.imageView.image drawAtPoint:CGPointZero];
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            self.imageView.image = newImage;
            UIGraphicsEndImageContext();
            
            [UIImagePNGRepresentation(newImage) writeToFile:@"/Users/liufeng/Desktop/LFLearn.png" atomically:YES];
            NSLog(@"new：%@", newImage);
            [self.coverV removeFromSuperview];
            self.coverV = nil;
        }
            break;
            
        default:
            break;
    }
}

- (void)timerHandle
{
    static CGFloat progress = 0;
    if (progress > 1) {
        return;
    }
    self.redView.progress = progress;
    progress += 0.01;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)test
{
    UIImage *image = [UIImage imageNamed:@"logo"];
    UIImage *image2 = [UIImage imageNamed:@"star"];
    
    UIImageView *imgV3 = [[UIImageView alloc] initWithImage:image];
    imgV3.frame = CGRectMake(0, 350, image.size.width, image.size.height);
    [self.view addSubview:imgV3];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, image.size.height), NO, image.scale);
    [image drawAtPoint:CGPointZero];
    [image drawAtPoint:CGPointZero];
    image2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgV2 = [[UIImageView alloc] initWithImage:image2];
    imgV2.frame = CGRectMake(0, 150, image2.size.width, image2.size.height);
    [self.view addSubview:imgV2];
    
    NSLog(@"%@", image2);
    return;
    
    //    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    //    imgV.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:imgV];
    _imgV = imgV;
    
    LFImageView *imgV1 = [[LFImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    imgV1.frame = CGRectMake(0, 150, 100, 100);
    [self.view addSubview:imgV1];
    //    imgV1.image = [UIImage imageNamed:@"logo"];
    _imgV1 = imgV1;
}

@end
