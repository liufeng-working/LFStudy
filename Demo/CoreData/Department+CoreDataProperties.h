//
//  Department+CoreDataProperties.h
//  CoreData
//
//  Created by 刘丰 on 2017/10/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//
//

#import "Department+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nullable, nonatomic, copy) NSString *departNO;

@end

NS_ASSUME_NONNULL_END
