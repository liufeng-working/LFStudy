//
//  LFMainViewModel.h
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/1.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
#import "LFMovies.h"

@class LFDetailViewModel;
@interface LFMainViewModel : NSObject

@property(nonatomic,strong,readonly) RACCommand *requestCommand;

- (LFDetailViewModel *)creatDetailViewModelWith:(LFMovieModel *)movieM;

@end
