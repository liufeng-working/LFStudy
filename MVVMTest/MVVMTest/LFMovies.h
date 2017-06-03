//
//  LFMovies.h
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFMovieModel.h"
#import "MJExtension.h"

@interface LFMovies : NSObject<MJKeyValue>

/**
 标题
 */
@property(nonatomic,copy) NSString *title;

/**
 电影
 */
@property(nonatomic,strong) NSArray<LFMovieModel *> *subjects;

/**
 每页都个数
 */
@property(nonatomic,assign) NSInteger count;

/**
 当前页
 */
@property(nonatomic,assign) NSInteger start;

/**
 总数
 */
@property(nonatomic,assign) NSInteger total;

@end
