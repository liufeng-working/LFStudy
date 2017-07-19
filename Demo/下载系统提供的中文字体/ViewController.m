//
//  ViewController.m
//  下载系统提供的中文字体
//
//  Created by 刘丰 on 2017/7/17.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *fontName = @"DFWaWaSC-W5";
    if ([self isFontDownloaded:fontName]) {
        NSLog(@"%@", @"娃娃字体已经下载");
        self.label.font = [UIFont fontWithName:fontName size:17];
        return;
    }
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    
    NSMutableArray *descs = [NSMutableArray arrayWithObjects:(__bridge id)desc, nil];
    CFRelease(desc);
    
    __block BOOL errorDuringDownload = NO;
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler((__bridge CFArrayRef)descs, NULL, ^bool(CTFontDescriptorMatchingState state, CFDictionaryRef  _Nonnull progressParameter) {
        
        switch (state) {
            case kCTFontDescriptorMatchingDidBegin:
                NSLog(@"匹配成功");
                break;
            case kCTFontDescriptorMatchingDidFinish: {
                NSLog(@"字体%@下载成功", fontName);
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.label.font = [UIFont fontWithName:fontName size:17];
                });
            }
                break;
            case kCTFontDescriptorMatchingWillBeginDownloading:
                NSLog(@"字体开始下载");
                break;
            case kCTFontDescriptorMatchingDidFinishDownloading: {
                
                NSLog(@"字体下载完成");
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.label.font = [UIFont fontWithName:fontName size:17];
                });
            }
                break;
            case kCTFontDescriptorMatchingDownloading: {
                double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
                NSLog(@"下载中%f", progressValue);
            }
                break;
            default: {
                NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
                if (errorDuringDownload) {
                    NSLog(@"error%@", error.description);
                }
                
                errorDuringDownload = YES;
            }
                break;
        }
        
        return true;
    });
}

- (BOOL)isFontDownloaded:(NSString *)fontName
{
    UIFont *font = [UIFont fontWithName:fontName size:17];
    return (font && ([font.fontName compare:fontName] == NSOrderedSame || [font.familyName compare:fontName] == NSOrderedSame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
