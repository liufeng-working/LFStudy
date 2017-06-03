//
//  LFDetailViewController.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/2.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFDetailViewController.h"
#import "LFNotification.h"

@interface LFDetailViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.detailVM.movieM.alt]];
}

#pragma mark -
#pragma mark - UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [LFNotification manuallyHideIndicatorWithText:@"正在加载网页" addTo:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [LFNotification hideNotification];
}

@end
