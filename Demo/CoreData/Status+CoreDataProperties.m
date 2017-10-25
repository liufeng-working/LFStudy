//
//  Status+CoreDataProperties.m
//  CoreData
//
//  Created by 刘丰 on 2017/10/19.
//  Copyright © 2017年 liufeng. All rights reserved.
//
//

#import "Status+CoreDataProperties.h"

@implementation Status (CoreDataProperties)

+ (NSFetchRequest<Status *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Status"];
}

@dynamic text;
@dynamic createDate;
@dynamic author;

@end
