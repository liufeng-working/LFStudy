//
//  LFEmployee+CoreDataProperties.m
//  CoreData1
//
//  Created by 刘丰 on 2017/10/20.
//  Copyright © 2017年 liufeng. All rights reserved.
//
//

#import "LFEmployee+CoreDataProperties.h"

@implementation LFEmployee (CoreDataProperties)

+ (NSFetchRequest<LFEmployee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LFEmployee"];
}

@dynamic age;
@dynamic height;
@dynamic name;
@dynamic sectionName;
@dynamic version;
@dynamic depart;

@end
