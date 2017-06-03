//
//  LFRedView.m
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/5/31.
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

- (IBAction)btnClick:(id)sender
{
    [self.btnClickSignal sendNext:sender];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
