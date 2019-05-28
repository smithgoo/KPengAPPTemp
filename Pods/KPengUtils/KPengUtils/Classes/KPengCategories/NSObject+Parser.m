//
//  NSObject+Parser.m
//  Parser
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 person. All rights reserved.
//

#import "NSObject+Parser.h"
#import <objc/runtime.h>

@implementation NSObject (Parser)

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

- (void)setNilValueForKey:(NSString *)key{
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

-(NSArray *)objectPropertyList{
    if (self.superclass == nil) {//当前类是NSObject 也就是基类
        return @[];
    }
    //获取属性列表
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    NSMutableArray *data = [[NSMutableArray alloc]init];
    for (const objc_property_t *p=properties; p < properties+outCount; p++) {
        objc_property_t property = *p;
        const char *name = property_getName(property);
        [data addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    
    //获取父类属性列表
    if (![self.superclass conformsToProtocol:@protocol(NSCoding)] && self.superclass) {
        id model = [[self.superclass alloc]init];
        [data addObjectsFromArray:[model objectPropertyList]];
    }
    return data;
}

+(NSDictionary *)attributedProperyOfClass:(Class )clss{
    if (clss.superclass == nil) {//当前类是NSObject 也就是基类
        return @{};
    }
    //获取属性列表
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(clss, &outCount);
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    for (const objc_property_t *p=properties; p < properties+outCount; p++) {
        objc_property_t property = *p;
        const char *name = property_getName(property);
        const char *attribute = property_getAttributes(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *propertyAttribute = [self attributeOfProperty:attribute];
        [data setObject:propertyAttribute forKey:propertyName];
    }
    free(properties);
    //获取父类属性列表
    if ([NSBundle bundleForClass:clss.superclass] == [NSBundle mainBundle]) {
        id model = [[clss alloc]init];
        [data addEntriesFromDictionary:[self attributedProperyOfClass:[model superclass]]];
    }
    return data;
}

-(NSString *)attributeOfProperty:(const char *)attribute{
    NSString * stringValue = [NSString stringWithUTF8String:attribute];
    NSArray *pars = [stringValue componentsSeparatedByString:@","];
    NSString *att = [pars firstObject];
    if ([att rangeOfString:@"\""].length == 0) {
        return @"NSNumber";
    }
    att = [att substringFromIndex:3];
    att = [att substringToIndex:att.length-1];
    return att;
}

-(NSDictionary *)toDictionary{
    NSDictionary *dict = [self.class attributedProperyOfClass:self.class];
    if (!dict) {
        return @{};
    }
    NSMutableDictionary *properties = [[NSMutableDictionary alloc]init];
    for (NSString *key in dict.allKeys) {
        NSString *className = [dict objectForKey:key];
        if ([NSBundle bundleForClass:NSClassFromString(className)] == [NSBundle mainBundle]) {//自定义类
            if ([self valueForKey:key] == nil) {
                Class clss = NSClassFromString(className);
                id model = [[clss alloc]init];
                [properties setObject:[model toDictionary] forKey:key];
            }else
                [properties setObject:[[self valueForKey:key] toDictionary] forKey:key];
        }else{
            if ([self valueForKey:key]) {
                [properties setObject:[self valueForKey:key] forKey:key];
            }else{
                [properties setObject:@"" forKey:key];
            }
        }
    }
    return properties;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [self init];
    if (self) {
        NSDictionary *properties = [self.class attributedProperyOfClass:self.class];
        for (NSString *key in dict) {
            if ([[dict objectForKey:key] isKindOfClass:[NSDictionary class]]) {//自定义类或者字典
                NSString *className = [properties objectForKey:key];
                Class clss = NSClassFromString(className);
                if ([NSBundle bundleForClass:clss] == [NSBundle mainBundle]) {//自定义类
                    id model = [[clss alloc]initWithDictionary:[dict objectForKey:key]];
                    [self setValue:model forKey:key];
                }else{
                    [self setValue:[dict objectForKey:key] forKey:key];
                }
            }else{
                [self setValue:[dict objectForKey:key] forKey:key];
            }
        }
    }
    return self;
}

-(id)parserWithClass:(Class)clss{
    
    id model = [[clss alloc]init];
    
    if ([self isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:[(NSArray *)self count]];
        for (id dic in (NSArray *)self) {
            [array addObject:[dic parserWithClass:clss]];
        }
        return array;
    }
    if ([self isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in [(NSDictionary *)self allKeys]) {
            id value = [model valueForKey:key];
            if (value && ![value isKindOfClass:[NSNumber class]]) {
                if ([value isKindOfClass:[NSArray class]]) {
                    NSString * className = [(NSArray *)value className];
                    if (className == nil) {
                        [model setValue:[(NSDictionary *)self objectForKey:key] forKey:key];
                    }else{
                        Class subClss = NSClassFromString(className);
                        [model setValue:[[(NSDictionary *)self objectForKey:key] parserWithClass:subClss] forKey:key];
                    }
                }else{
                    [model setValue:[[(NSDictionary *)self objectForKey:key] parserWithClass:[value class]] forKey:key];
                }
            }else{
                [model setValue:[(NSDictionary *)self objectForKey:key] forKey:key];
            }
        }
        return model;
    }
    return nil;
}
@end

@implementation NSArray (ObjectType)

-(NSString *)className{
    return objc_getAssociatedObject(self, "ObjectType");
}

- (void)setClassName:(NSString *)className{
    objc_setAssociatedObject(self, "ObjectType", className, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
