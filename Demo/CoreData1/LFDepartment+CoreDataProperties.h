//
//  LFDepartment+CoreDataProperties.h
//  CoreData1
//
//  Created by 刘丰 on 2017/10/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//
//

#import "LFDepartment+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LFDepartment (CoreDataProperties)

+ (NSFetchRequest<LFDepartment *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nullable, nonatomic, copy) NSString *iD;
@property (nullable, nonatomic, retain) NSSet<LFEmployee *> *emp;

@end

@interface LFDepartment (CoreDataGeneratedAccessors)

- (void)addEmpObject:(LFEmployee *)value;
- (void)removeEmpObject:(LFEmployee *)value;
- (void)addEmp:(NSSet<LFEmployee *> *)values;
- (void)removeEmp:(NSSet<LFEmployee *> *)values;

@end

NS_ASSUME_NONNULL_END
