//
//  LFPerson.h
//  LFStudy
//
//  Created by 刘丰 on 2017/7/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFPerson : NSObject<NSCoding>

@property(nonatomic,copy) NSString *name;

@property(nonatomic,assign) NSInteger age;

@end
