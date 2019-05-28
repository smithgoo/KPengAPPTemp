//
//  ConfigInfo.h
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigInfo : NSObject

/**
 *  获取是否需要展示引导页
 *
 *  @return 用户名
 */
+ (NSString *)appIntroduction;

/**
 *  设置是否需要展示引导页
 *
 *  @param appIntroduction 是否需要展示引导页
 */
+ (void)appIntroduction:(NSString *)appIntroduction;

/**
 *  获取最后登录用户名
 *
 *  @return 用户名
 */
+ (NSString *)appUserName;

/**
 *  设置最后登录用户名
 *
 *  @param appUserName 用户名
 */
+ (void)appUserName:(NSString *)appUserName;


/**
 *  获取请求参数password
 *
 *  @return 请求参数password
 */
+ (NSString *)appParameterPassword;

/**
 *  设置请求参数password
 *
 *  @param appParameterPassword 请求参数password
 */
+ (void)appParameterPassword:(NSString *)appParameterPassword;


/**
 *  获取最后登录密码
 *
 *  @return 登录密码
 */
+ (NSString *)appUserPassword;

/**
 *  设置最后登录密码
 *
 *  @param appUserPassword 登录密码
 */
+ (void)appUserPassword:(NSString *)appUserPassword;

/**
 *  获取账号id
 *
 *  @return 账号id
 */
+ (NSString *)appUserId;

/**
 *  设置账号id
 *
 *  @param appUserId 账号id
 */
+ (void)appUserId:(NSString *)appUserId;

/**
 *  获取账号头像
 *
 *  @return 账号appAccountHeadImage
 */
+ (NSString *)appAccountHeadImage;

/**
 *  设置账号头像
 *
 *  @param appAccountHeadImage 账号头像
 */
+ (void)appAccountHeadImage:(NSString *)appAccountHeadImage;

/**
 *  获取选择使用场景
 *
 *  @return 选择使用场景appSelectScene
 */
+ (NSString *)appSelectScene;

/**
 *  设置选择使用场景
 *
 *  @param appSelectScene 选择使用场景
 */
+ (void)appSelectScene:(NSString *)appSelectScene;

/**
 *  获取消息声音设置
 *
 */
+ (NSString *)appMessageVocie;

/**
 *  设置消息声音
 *
 *  @param appMessageVocie 设置消息声音
 */
+ (void)appMessageVocie:(NSString *)appMessageVocie;

/**
 *  获取设置消息震动
 *
 */
+ (NSString *)appMessageShake;

/**
 *  设置消息震动
 *
 *  @param appMessageShake 消息震动
 */
+ (void)appMessageShake:(NSString *)appMessageShake;

/**
 *  获取设置系统消息
 *
 */
+ (NSString *)appMessagesystem;

/**
 *  设置系统消息
 *
 *  @param appMessagesystem 系统消息
 */
+ (void)appMessagesystem:(NSString *)appMessagesystem;

/**
 *  获取设置消息晚间
 *
 */
+ (NSString *)appMessageNight;

/**
 *  设置消息消息晚间
 *
 *  @param appMessageNight 消息晚间
 */
+ (void)appMessageNight:(NSString *)appMessageNight;

/**
 *  获取应用唯一标示
 *
 *  @return 唯一标示
 */
+ (NSString *)clientUDID;

/**
 *  设置应用唯一标示
 *
 *
 */
+ (void)clientUDID:(NSString *)clientUDID;
/**
 *  获取应用系统版本号
 *
 *  @return 系统版本号
 */
+ (NSString *)clientVersion;

/**
 *  获取应用名称
 *
 *  @return 应用名称
 */
+ (NSString *)clientAppName;

@end
