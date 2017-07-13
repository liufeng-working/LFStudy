//
//  LFPerson.m
//  LFStudy
//
//  Created by 刘丰 on 2017/7/13.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "LFPerson.h"

@implementation LFPerson

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@, age:%ld", self.name, (long)self.age];
}

@end
