//
//  NSObject+LFOBJC.m
//  MVVMTest
//
//  Created by 刘丰 on 2017/6/3.
//  Copyright © 2017年 liufeng. All rights reserved.
//

#import "NSObject+LFOBJC.h"
#import <objc/message.h>

const char lf_name;

@implementation NSObject (LFOBJC)

- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, &lf_name, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, &lf_name);
}

+ (instancetype)modelWithDic:(NSDictionary *)dic;
{
    id obj = [[self alloc] init];
    //ivar:成员属性 _name
    unsigned int count;
//    Ivar *ivarList = class_copyIvarList(self.class, &count);
    objc_property_t *tList = class_copyPropertyList(self.class, &count);
    for (unsigned int i = 0; i < count; i ++) {

//        Ivar ivar = ivarList[i];
//        NSString *property = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
//        
        objc_property_t t = tList[i];
        NSString *property = [NSString stringWithUTF8String:property_getName(t)];
        [obj setValue:dic[property] forKey:property];
    }
    
    return obj;
}

@end
