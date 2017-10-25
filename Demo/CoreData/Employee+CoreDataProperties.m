//
//  Employee+CoreDataProperties.m
//  CoreData
//
//  Created by 刘丰 on 2017/10/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//
//

#import "Employee+CoreDataProperties.h"

@implementation Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
}

@dynamic age;
@dynamic height;
@dynamic name;
@dynamic depart;

@end
