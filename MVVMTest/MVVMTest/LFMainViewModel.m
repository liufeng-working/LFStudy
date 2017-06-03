//
//  LFMainViewModel.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFMainViewModel.h"
#import "AFNetworking.h"
#import "LFNotification.h"
#import "LFDetailViewModel.h"

@implementation LFMainViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [LFNotification manuallyHideIndicatorWithText:@"正在加载电影"];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:@"https://api.douban.com/v2/movie/in_theaters" parameters:@{@"city": @"南京"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
                [LFNotification hideNotification];
//                [responseObject writeToFile:@"/Users/liufeng/Desktop/movie.plist" atomically:YES];
                LFMovies *movies = [LFMovies mj_objectWithKeyValues:responseObject];
                [subscriber sendNext:movies];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [LFNotification hideNotification];
                NSLog(@"error:%@", error);
            }];
            return nil;
        }];
    }];
}

- (LFDetailViewModel *)creatDetailViewModelWith:(LFMovieModel *)movieM
{
    LFDetailViewModel *detailVM = [LFDetailViewModel new];
    detailVM.movieM = movieM;
    return detailVM;
}

@end
