//
//  ViewController.m
//  手写约束
//
//  Created by 刘丰 on 2017/7/11.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *yellowV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *blueV = [[UIView alloc] init];
    blueV.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueV];
    blueV.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *redV = [[UIView alloc] init];
    redV.backgroundColor = [UIColor redColor];
    [self.view addSubview:redV];
    redV.translatesAutoresizingMaskIntoConstraints = NO;
    
    //添加约束
    NSDictionary *metrics = @{@"space": @20};
    NSDictionary *views = NSDictionaryOfVariableBindings(blueV, redV);
    
    NSString *hC = @"H:|-space-[blueV]-space-[redV(==blueV)]-space-|";
    NSArray<NSLayoutConstraint *> *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hC options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:metrics views:views];
    [self.view addConstraints:hConstraints];

    NSString *blueVC = @"V:[blueV(44)]-space-|";
    NSArray<NSLayoutConstraint *> *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:blueVC options:kNilOptions metrics:metrics views:views];
    [self.view addConstraints:vConstraints];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.yellowV removeFromSuperview];
}

//VFL
- (void)vfl
{
    //VFL语言 visual format language
    UIView *redV = [[UIView alloc] init];
    redV.backgroundColor = [UIColor redColor];
    [self.view addSubview:redV];
    redV.translatesAutoresizingMaskIntoConstraints = NO;
    
    //添加约束
    NSString *hC = @"H:|-space-[redV]-space-|";
    NSDictionary *metrics = @{@"space": @30};
    NSDictionary *views = NSDictionaryOfVariableBindings(redV);
    NSArray<NSLayoutConstraint *> *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hC options:kNilOptions metrics:metrics views:views];
    [self.view addConstraints:hConstraints];
    
    NSString *vC = @"V:[redV(40)]-space-|";
    NSArray<NSLayoutConstraint *> *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vC options:kNilOptions metrics:metrics views:views];
    [self.view addConstraints:vConstraints];
}

- (void)test1
{
    UIView *blueV = [[UIView alloc] init];
    blueV.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueV];
    blueV.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *redV = [[UIView alloc] init];
    redV.backgroundColor = [UIColor redColor];
    [self.view addSubview:redV];
    redV.translatesAutoresizingMaskIntoConstraints = NO;
    
    //添加约束
    NSLayoutConstraint *leftC = [NSLayoutConstraint constraintWithItem:blueV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
    [self.view addConstraint:leftC];
    
    NSLayoutConstraint *bottomC = [NSLayoutConstraint constraintWithItem:blueV attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    [self.view addConstraint:bottomC];
    
    NSLayoutConstraint *heightC = [NSLayoutConstraint constraintWithItem:blueV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:44];
    [blueV addConstraint:heightC];
    
    NSLayoutConstraint *rightC = [NSLayoutConstraint constraintWithItem:blueV attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:redV attribute:NSLayoutAttributeLeft multiplier:1 constant:-20];
    [self.view addConstraint:rightC];
    
    NSLayoutConstraint *rightC1 = [NSLayoutConstraint constraintWithItem:redV attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-20];
    [self.view addConstraint:rightC1];
    
    NSLayoutConstraint *bottomC1 = [NSLayoutConstraint constraintWithItem:redV attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    [self.view addConstraint:bottomC1];
    
    NSLayoutConstraint *heightC1 = [NSLayoutConstraint constraintWithItem:redV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:44];
    [redV addConstraint:heightC1];
    
    NSLayoutConstraint *widthC = [NSLayoutConstraint constraintWithItem:blueV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:redV attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [self.view addConstraint:widthC];
}

- (void)test
{
    UIView *redV = [[UIView alloc] init];
    redV.backgroundColor = [UIColor redColor];
    [self.view addSubview:redV];
    
    redV.translatesAutoresizingMaskIntoConstraints = NO;
    
    //添加约束
    NSLayoutConstraint *widthC = [NSLayoutConstraint constraintWithItem:redV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
    [redV addConstraint:widthC];
    
    NSLayoutConstraint *heightC = [NSLayoutConstraint constraintWithItem:redV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
    [redV addConstraint:heightC];
    
    NSLayoutConstraint *xC = [NSLayoutConstraint constraintWithItem:redV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
    [self.view addConstraint:xC];
    
    NSLayoutConstraint *yC = [NSLayoutConstraint constraintWithItem:redV attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    [self.view addConstraint:yC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
