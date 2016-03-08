//
//  NSObject+Description.m
//  RunTimeTest
//
//  Created by ymq on 16/3/8.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "NSObject+Description.h"
#import <objc/runtime.h>

@implementation NSObject(Description)

- (NSString *)description
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (NSInteger i = 0; i < count; i ++)
    {
        objc_property_t property = properties[i];
        NSString *keyName = [NSString stringWithUTF8String:property_getName(property)];
        id value = [self valueForKey:keyName];
        [dic setObject:value forKey:keyName];
    }
    return [dic description];
}

@end
