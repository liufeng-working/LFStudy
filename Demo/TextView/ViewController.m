//
//  ViewController.m
//  TextView
//
//  Created by 刘丰 on 2017/11/10.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextPosition *start = [self.textView positionFromPosition:self.textView.beginningOfDocument offset:0];
    UITextPosition *end = [self.textView positionFromPosition:self.textView.beginningOfDocument offset:3];
    
    [self.textView becomeFirstResponder];
//    self.textView.selectedRange = NSMakeRange(0, 11);
    
//    NSString *str = [self.textView textInRange:[self.textView textRangeFromPosition:self.textView.beginningOfDocument toPosition:self.textView.endOfDocument]];
//    NSLog(@"%@", str);
    
//    [self.textView replaceRange:[self.textView textRangeFromPosition:self.textView.beginningOfDocument toPosition:[self.textView positionFromPosition:self.textView.beginningOfDocument offset:4]] withText:@"😄哈"];
    
    UITextRange *rang = [self.textView textRangeFromPosition:start toPosition:end];
//    self.textView.selectedTextRange = rang;
    
//    [self.textView setMarkedText:@"你是我的" selectedRange:NSMakeRange(4, 0)];
//    self.textView.markedTextStyle = @{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:30], NSBackgroundColorAttributeName: [UIColor blueColor]};
//    [self.textView unmarkText];
//    NSLog(@"%@", self.textView.markedTextRange);
    
//    NSLog(@"beign->%@", self.textView.beginningOfDocument);
//    NSLog(@"end->%@", self.textView.endOfDocument);
    
//    UITextPosition *ppp = [self.textView positionWithinRange:rang farthestInDirection:UITextLayoutDirectionUp];
//    NSLog(@"%@", ppp);
    
//    rang = [self.textView characterRangeByExtendingPosition:[self.textView positionFromPosition:self.textView.beginningOfDocument offset:1] inDirection:UITextLayoutDirectionLeft];
//    NSLog(@"%@", rang);
    
//    [self.textView setBaseWritingDirection:UITextWritingDirectionRightToLeft forRange:rang];
//    UITextWritingDirection ddd = [self.textView baseWritingDirectionForPosition:start inDirection:UITextStorageDirectionForward];
//    NSLog(@"%d", ddd);
    
//    CGRect rect = [self.textView firstRectForRange:rang];
//    rect = [self.textView caretRectForPosition:[self.textView positionFromPosition:self.textView.beginningOfDocument offset:2]];
//    NSLog(@"%@", NSStringFromCGRect(rect));
//    {{4, 7}, {2, 22}}
    // {{5, 7}, {161.584, 21.787109}}
    
//    [[self.textView selectionRectsForRange:rang] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@", obj);
//    }];
//
    
//    UITextPosition *pppp = [self.textView closestPositionToPoint:CGPointMake(0, 7)];
//    NSLog(@"%@", pppp);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}

#pragma mark -
#pragma mark - UITextViewDelegate
/*
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    NSLog(@"%s", __func__);
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    NSLog(@"%s", __func__);
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"%s", __func__);
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"%s", __func__);
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    NSLog(@"%s", __func__);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    NSLog(@"%s", __func__);
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    NSLog(@"%s", __func__);
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead") {
    NSLog(@"%s", __func__);
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead") {
    NSLog(@"%s", __func__);
    return YES;
}
*/

@end
