//
//  LFLoginViewModel.h
//  LFStudy
//
//  Created by 刘丰 on 2017/8/5.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>
#import "LFNotification.h"

@interface LFLoginViewModel : NSObject

@property(nonatomic,copy) NSString *user;

@property(nonatomic,copy) NSString *pwd;

@property(nonatomic,strong,readonly) RACSignal *loginSignal;

@property(nonatomic,strong,readonly) RACCommand *loginCommand;

@end
