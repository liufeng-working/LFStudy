//
//  LFBeauty.h
//  LFStudy
//
//  Created by 刘丰 on 2017/8/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFBeauty : NSObject

@property(nonatomic,strong) NSURL *imgUrl;

@property(nonatomic,assign) CGFloat width;

@property(nonatomic,assign) CGFloat height;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)beautyWithDic:(NSDictionary *)dic;

@end
