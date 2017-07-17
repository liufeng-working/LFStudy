//
//  LFThread.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/16.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFThread.h"

@implementation LFThread

- (void)dealloc {
    NSLog(@"%s, %@", __func__, [NSThread currentThread]);
}

@end
