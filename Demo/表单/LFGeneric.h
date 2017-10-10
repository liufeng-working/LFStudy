//
//  LFGeneric.h
//  表单
//
//  Created by 刘丰 on 2017/10/9.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFGeneric<__covariant ObjectType> : NSObject

@property(nonatomic,strong) NSArray<ObjectType> *items;

@property(nonatomic,copy) void(^callBack)(ObjectType item);

@end
