//
//  LFRedView.m
//  LFStudy
//
//  Created by 刘丰 on 2017/8/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFRedView.h"

@interface LFRedView ()

@end

@implementation LFRedView

- (RACSubject *)btnClickSignal
{
    if (!_btnClickSignal) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}

- (IBAction)redClick:(id)sender
{
    [self.btnClickSignal sendNext:sender];
}

@end
