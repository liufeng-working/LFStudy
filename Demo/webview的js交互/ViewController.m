//
//  ViewController.m
//  webview的js交互
//
//  Created by 刘丰 on 2017/7/17.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, test) {
    test1,
    test2,
    test3,
    test4,
    test5,
};

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property(nonatomic,assign) test t;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
}

- (IBAction)changeFontSize:(id)sender
{
    CGFloat size = 10;
    NSString *js = [NSString stringWithFormat:@"setArticleFontSize(%f)",size];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
