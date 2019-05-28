//
//  ConfigInfo.m
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import "ConfigInfo.h"

#define Config_FileName                     @"app.config.plist"

#define Config_AppDefaultPlanSummaryCity    @"AppDefaultPlanSummaryCity"
#define Config_AppIntroduction              @"AppIntroduction"
#define Config_AppUserName                  @"AppUserName"
#define Config_AppUserPassword              @"AppUserPassword"
#define Config_AppUserId                    @"AppUserId"
#define Config_AppAccountHeadImage          @"AppAccountHeadImage"
#define Config_AppSelectScene               @"AppSelectScene"
#define Config_AppParameterPassword         @"AppParameterPassword"
#define Config_AppMessageVocie              @"AppMessageVocie"
#define Config_AppMessageShake              @"AppMessageShake"
#define Config_AppMessagesystem             @"AppMessagesystem"
#define Config_AppMessageNight              @"AppMessageNight"

#define Config_ClientUDID                   @"ClientUDID"

#define Config_Domain                       @"com.tokee.tfzq"
#define Config_DomainKey                    @"WHTOKEE"

@implementation ConfigInfo

+ (void)initialize
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:Config_FileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        
        //设置应用信息
        [dictionary setObject:@""
                       forKey:Config_AppDefaultPlanSummaryCity];
        [dictionary setObject:@"0"
                       forKey:Config_AppIntroduction];
        [dictionary setObject:@""
                       forKey:Config_AppUserName];
        [dictionary setObject:@""
                       forKey:Config_AppUserPassword];
        [dictionary setObject:@""
                       forKey:Config_AppUserId];
        [dictionary setObject:@""
                       forKey:Config_AppAccountHeadImage];
        [dictionary setObject:@"0" forKey:Config_AppSelectScene];
        [dictionary setObject:@""
                       forKey:Config_AppParameterPassword];
        [dictionary setObject:@""
                       forKey:Config_AppMessageVocie];
        [dictionary setObject:@""
                       forKey:Config_AppMessageShake];
        [dictionary setObject:@""
                       forKey:Config_AppMessagesystem];
        [dictionary setObject:@""
                       forKey:Config_AppMessageNight];
        
        //设置客户端信息
//        [dictionary setObject:[SecureUDID UDIDForDomain:Config_Domain usingKey:Config_DomainKey]
//                       forKey:Config_ClientUDID];
        //写入配置文件
        [dictionary writeToFile:plistPath atomically:YES];
    }
    else {
        
    }
}

#pragma mark - 配置操作

+ (NSString *)appDefaultPlanSummaryCity {
    NSString *value = [self getConfigValue:Config_AppDefaultPlanSummaryCity];
    if (value) {
        return value;
    }
    else {
        return @"湖北省-武汉市";
    }
}

+ (NSString *)appIntroduction {
    NSString *value = [self getConfigValue:Config_AppIntroduction];
    if (value) {
        return value;
    }
    else {
        return @"0";
    }
}

+ (void)appIntroduction:(NSString *)appIntroduction {
    [self setConfigValue:appIntroduction key:Config_AppIntroduction];
}

+ (NSString *)appUserName
{
    NSString *value = [self getConfigValue:Config_AppUserName];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

+ (void)appUserName:(NSString *)appUserName
{
    [self setConfigValue:appUserName key:Config_AppUserName];
}

+ (NSString *)appParameterPassword
{
    NSString *value = [self getConfigValue:Config_AppParameterPassword];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
    
}

+ (void)appParameterPassword:(NSString *)appParameterPassword
{
    [self setConfigValue:appParameterPassword key:Config_AppParameterPassword];
}

+ (NSString *)appUserPassword
{
    NSString *value = [self getConfigValue:Config_AppUserPassword];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

+ (void)appUserPassword:(NSString *)appUserPassword
{
    [self setConfigValue:appUserPassword key:Config_AppUserPassword];
}

+ (NSString *)appUserId
{
    NSString *value = [self getConfigValue:Config_AppUserId];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

+ (void)appUserId:(NSString *)appUserId
{
    [self setConfigValue:appUserId key:Config_AppUserId];
}

+ (NSString *)appAccountHeadImage
{
    NSString *value = [self getConfigValue:Config_AppAccountHeadImage];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

+ (void)appAccountHeadImage:(NSString *)appAccountHeadImage
{
    [self setConfigValue:appAccountHeadImage key:Config_AppAccountHeadImage];
}

+ (NSString *)appSelectScene
{
    NSString *value = [self getConfigValue:Config_AppSelectScene];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

+ (void)appSelectScene:(NSString *)appSelectScene
{
    [self setConfigValue:appSelectScene key:Config_AppSelectScene];
}


+ (NSString *)appMessageVocie
{
    NSString *value = [self getConfigValue:Config_AppMessageVocie];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}


+ (void)appMessageVocie:(NSString *)appMessageVocie
{
    [self setConfigValue:appMessageVocie key:Config_AppMessageVocie];
}


+ (NSString *)appMessageShake
{
    NSString *value = [self getConfigValue:Config_AppMessageShake];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}


+ (void)appMessageShake:(NSString *)appMessageShake
{
    [self setConfigValue:appMessageShake key:Config_AppMessageShake];
}


+ (NSString *)appMessagesystem
{
    NSString *value = [self getConfigValue:Config_AppMessagesystem];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}


+ (void)appMessagesystem:(NSString *)appMessagesystem
{
    [self setConfigValue:appMessagesystem key:Config_AppMessagesystem];
}


+ (NSString *)appMessageNight
{
    NSString *value = [self getConfigValue:Config_AppMessageNight];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}


+ (void)appMessageNight:(NSString *)appMessageNight
{
    [self setConfigValue:appMessageNight key:Config_AppMessageNight];
}

+ (NSString *)clientUDID
{
    NSString *value = [self getConfigValue:Config_ClientUDID];
    if (value) {
        return value;
    }
    else {
        return @"";
    }
}

+ (void)clientUDID:(NSString *)clientUDID
{
    [self setConfigValue:clientUDID key:Config_ClientUDID];
}

+ (NSString *)clientVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)clientAppName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

#pragma mark - 配置文件操作

+ (NSString *)getConfigValue:(NSString *)key
{
    NSString *rtn = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:Config_FileName];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    rtn = [dictionary objectForKey:key];
    if ((rtn == nil) || [rtn isEqualToString:@""]) {
        return nil;
    }
    return rtn;
}

+ (BOOL)setConfigValue:(NSString *)value key:(NSString *)key
{
    BOOL rtn = NO;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:Config_FileName];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSMutableDictionary *dictionaryNew = [dictionary mutableCopy];
    [dictionaryNew setObject:value forKey:key];
    rtn = [dictionaryNew writeToFile:plistPath atomically:YES];
    return rtn;
}

@end
