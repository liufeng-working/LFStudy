//
//  LFCityItem.h
//  LFStudy
//
//  Created by 刘丰 on 2017/8/18.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface LFCityItem : NSObject

/** 地区的ID */
@property (nonatomic,strong)NSString *area_id;

/** 地区的pid */
@property (nonatomic,strong)NSString *area_pid;

/** 地区的名字 */
@property (nonatomic,strong)NSString *area_district;

/** area_level */
@property (nonatomic,strong)NSString *area_level;

/** 地区的子地区 */
@property (nonatomic,strong)NSArray<LFCityItem *> *son;

@end
