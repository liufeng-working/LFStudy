//
//  LFWheelView.h
//  LFLottery
//
//  Created by 刘丰 on 2017/6/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFWheelView : UIView

+ (instancetype)wheelView;

- (void)rotation;
- (void)stop;

@end
