//
//  Employee+CoreDataProperties.h
//  CoreData
//
//  Created by 刘丰 on 2017/10/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//
//

#import "Employee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nonatomic) double height;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Department *depart;

@end

NS_ASSUME_NONNULL_END
