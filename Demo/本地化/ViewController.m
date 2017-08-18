//
//  ViewController.m
//  本地化
//
//  Created by 刘丰 on 2017/8/16.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Cancel" value:@"Placeholder" table:@"test"];
    [self.button setTitle:title forState:UIControlStateNormal];
//    NSLocalizedString(<#key#>, <#comment#>)
    
}

@end
