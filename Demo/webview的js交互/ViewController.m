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
    
    [self.webView loadHTMLString:[self demoFormatWithName:@"liufeng" value:@"学习"] baseURL:nil];
    
}

- (IBAction)changeFontSize:(id)sender
{
    NSString *js = [NSString stringWithFormat:@"alert('done')"];
    NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:js];
    NSLog(@"result -> %@", result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)demoFormatWithName:(NSString *)name value:(NSString *)value
{
    NSString *html = @"<HTML><HEAD></HEAD><BODY><H1>%@</H1><P>%@</P></BODY></HTML>";
    return [NSString stringWithFormat:html, name, value];
}

@end
