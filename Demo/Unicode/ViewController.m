//
//  ViewController.m
//  Unicode
//
//  Created by 刘丰 on 2017/8/14.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,weak) IBOutlet UILabel *testL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *s = @"\U0001F30D"; // earth globe emoji 🌍
    NSLog(@"The length of %@ is %lu", s, [s length]);
    // => The length of 🌍 is 2
    
    NSUInteger realLength =
    [s lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4;
    NSLog(@"The real length of %@ is %lu", s, realLength);
    // => The real length of 🌍 is 1
    
    NSString *sss = @"The weather on \U0001F30D is \U0001F31E today.";
    // The weather on 🌍 is 🌞 today.
    NSRange fullRange = NSMakeRange(0, [sss length]);
    [sss enumerateSubstringsInRange:fullRange
                          options:NSStringEnumerationByComposedCharacterSequences
                       usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         NSLog(@"%@ %@", substring, NSStringFromRange(substringRange));
     }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.testL.text = @"문서수순 위키백과 목록";
}

@end
