//
//  LFCaculator.h
//  ReactiveCocoaTest
//
//  Created by 刘丰 on 2017/6/12.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFCaculator : NSObject

@property(nonatomic,assign,getter=isEqual) BOOL equal;

@property(nonatomic,assign) NSInteger result;

- (LFCaculator *)caculator:(NSInteger(^)(NSInteger value))caculator;
- (LFCaculator *)equal:(BOOL(^)(NSInteger value))operation;

@end
