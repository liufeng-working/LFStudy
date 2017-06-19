//
//  LFCaculatorMaker.h
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/6/12.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFCaculatorMaker : NSObject

@property(nonatomic,assign) NSInteger result;

- (LFCaculatorMaker *(^)(NSInteger value))add;

@end
