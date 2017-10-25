//
//  LFDepartment+CoreDataProperties.m
//  CoreData1
//
//  Created by 刘丰 on 2017/10/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//
//

#import "LFDepartment+CoreDataProperties.h"

@implementation LFDepartment (CoreDataProperties)

+ (NSFetchRequest<LFDepartment *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LFDepartment"];
}

@dynamic name;
@dynamic createDate;
@dynamic iD;
@dynamic emp;

@end
