//
//  LFMovies.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFMovies.h"

@implementation LFMovies

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"subjects" : [LFMovieModel class]};
}

@end
