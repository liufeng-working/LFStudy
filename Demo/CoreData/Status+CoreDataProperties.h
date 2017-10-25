//
//  Status+CoreDataProperties.h
//  CoreData
//
//  Created by 刘丰 on 2017/10/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//
//

#import "Status+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Status (CoreDataProperties)

+ (NSFetchRequest<Status *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nullable, nonatomic, copy) NSString *author;

@end

NS_ASSUME_NONNULL_END
