//
//  NSObject+Parser.h
//  Parser
//
//  Created by pg on 16/4/20.
//  Copyright © 2016年 person. All rights reserved.
//

#warning 使用 所以对象的属性是 指定数组（指定数组对象类型，需设置className属性）或对象（自定义对象）必须先初始化

#import <Foundation/Foundation.h>

@interface NSObject (Parser)

/**
 *  获取对象属性 或者类属性列表
 *
 *  @return <#return value description#>
 */
-(NSArray *)objectPropertyList;

/**
 *  将对象转化成字典
 *
 *  @return <#return value description#>
 */
-(NSDictionary *)toDictionary;

/**
 *  用字典初始化
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithDictionary:(NSDictionary *)dict;

/**
 *  将字典转化成对象
 *
 *  @param clss 对象类型
 *
 *  @return 对象或对象数组
 */
-(id)parserWithClass:(Class)clss;

@end

@interface NSArray (ObjectType)

//指定数组对象类型
@property (nonatomic, copy) NSString *className;

@end
