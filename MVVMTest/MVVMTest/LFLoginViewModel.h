//
//  LFLoginViewModel.h
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

@interface LFLoginViewModel : NSObject

@property(nonatomic,copy) NSString *user;
@property(nonatomic,copy) NSString *pwd;

@property(nonatomic,strong,readonly) RACSignal *loginButtonEnableSignal;

@property(nonatomic,strong,readonly) RACCommand *loginCommand;

@property(nonatomic,copy,readonly) NSString *loginData;

@end
