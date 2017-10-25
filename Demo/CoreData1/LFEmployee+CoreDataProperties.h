//
//  LFEmployee+CoreDataProperties.h
//  CoreData1
//
//  Created by 刘丰 on 2017/10/20.
//  Copyright © 2017年 liufeng. All rights reserved.
//
//

#import "LFEmployee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LFEmployee (CoreDataProperties)

+ (NSFetchRequest<LFEmployee *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nonatomic) double height;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sectionName;
@property (nullable, nonatomic, copy) NSString *version;
@property (nullable, nonatomic, retain) LFDepartment *depart;

@end

NS_ASSUME_NONNULL_END
