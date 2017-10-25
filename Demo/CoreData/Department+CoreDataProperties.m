//
//  Department+CoreDataProperties.m
//  CoreData
//
//  Created by 刘丰 on 2017/10/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//
//

#import "Department+CoreDataProperties.h"

@implementation Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Department"];
}

@dynamic name;
@dynamic createDate;
@dynamic departNO;

@end
