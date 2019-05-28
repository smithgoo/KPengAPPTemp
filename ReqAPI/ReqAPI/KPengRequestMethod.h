//
//  KPengRequestMethod.h
//  ReqAPI
//
//  Created by 王朋 on 2019/5/28.
//  Copyright © 2019 王朋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <KPengUtils/Classes/KPengNormal/ConfigInfo.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>

#pragma mark - block 样式

/**
 成功 block 样式
 
 @param data 返回数据
 */
typedef void(^ResponseSuc)(id data);

/**
 成功 block 样式
 
 @param data 返回数据
 */
typedef void(^ResponseResult)(int code,NSString *msg,id data);


/**
 成功 block 样式
 
 @param msg 返回数据
 */
typedef void(^ResponseResultErr)(int code,NSString *msg);

/**
 请求失败 block 样式
 
 @param errMsg 返回错误信息
 */
typedef void(^ResponseErr)(NSString *errMsg);


/**
 请求错误 block 样式
 
 @param errMsg 返回错误信息
 */
typedef void(^ResponseError)(NSError *errMsg);


typedef NS_ENUM(NSInteger,RequestMethod) {
    RequestMethodGet =0,
    RequestMethodPost,
    RequestMethodDelete,
    RequestMethodPut
};

NS_ASSUME_NONNULL_BEGIN

@interface KPengRequestMethod : NSObject

+ (void)get:(NSString *)url
parameters:(NSMutableDictionary *)parameters
success:(void (^)(int code, NSString *msg, id data))success
error:(void (^)(int code, NSString *msg))error
failure:(void (^)(NSError *failure))failure __deprecated_msg("Use `request:mehtod:responseObjcClass:params:datas:success:failure:`");

+ (void)post:(NSString *)url
parameters:(NSMutableDictionary *)parameters
success:(void (^)(int code, NSString *msg, id data))success
error:(void (^)(int code, NSString *msg))error
failure:(void (^)(NSError *failure))failure __deprecated_msg("Use `request:mehtod:responseObjcClass:params:datas:success:failure:`");

+ (void)post:(NSString *)url
parameters:(NSMutableDictionary *)parameters
datas:(NSMutableDictionary *)datas
success:(void (^)(int code, NSString *msg, id data))success
error:(void (^)(int code, NSString *msg))error
failure:(void (^)(NSError *failure))failure __deprecated_msg("Use `request:mehtod:responseObjcClass:params:datas:success:failure:`");

+ (void)post_file:(NSString *)url
parameters:(NSMutableDictionary *)parameters
datas:(NSMutableDictionary *)datas
success:(void (^)(int code, NSString *msg, id data))success
error:(void (^)(int code, NSString *msg))error
failure:(void (^)(NSError *failure))failure;


+ (void)deleteAction:(NSString *)url
parameters:(NSMutableDictionary *)parameters
success:(void (^)(int code, NSString *msg, id data))success
error:(void (^)(int code, NSString *msg))error
failure:(void (^)(NSError *failure))failure __deprecated_msg("Use `request:mehtod:responseObjcClass:params:datas:success:failure:`");


@end

NS_ASSUME_NONNULL_END
