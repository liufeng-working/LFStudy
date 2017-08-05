//
//  LFRedView.h
//  LFStudy
//
//  Created by 刘丰 on 2017/8/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

@interface LFRedView : UIView

@property(nonatomic,strong) RACSubject *btnClickSignal;

@end
