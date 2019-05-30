//
//  KPengRequestMethod.m
//  ReqAPI
//
//  Created by 王朋 on 2019/5/28.
//  Copyright © 2019 王朋. All rights reserved.
//

#import "KPengRequestMethod.h"
#import <AFNetworking/AFNetworking.h>
#import <KPengUtils/Classes/KPengNormal/ConfigInfo.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>

#define TIMEOUT  45
@interface KPengRequestMethod ()
{
        AFHTTPSessionManager *sessionManager;
}
@end

@implementation KPengRequestMethod

-(instancetype)init{
    self = [super init];
    if (self) {
        sessionManager = [AFHTTPSessionManager manager];
        [sessionManager.requestSerializer setTimeoutInterval:45];
    }
    return self;
}

-(AFHTTPSessionManager *)sessionManager{
    return sessionManager;
}


+(instancetype)manager{
    static KPengRequestMethod *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KPengRequestMethod alloc]init];
    });
    return manager;
}
    
    //过滤上报的api 不弹toast
+(BOOL)isShowLoadingViewWithURL:(NSString *)url{
    NSArray *filts = @[@""];
    for (NSString *str in filts) {
        if ([url rangeOfString:str].length != 0) {
            return YES;
        }
    }
    return NO;
}
    
+ (void)get:(NSString *)url
 parameters:(NSMutableDictionary *)parameters
    success:(void (^)(int code, NSString *msg, id data))success
      error:(void (^)(int code, NSString *msg))error
    failure:(void (^)(NSError *failure))failure
    {
        if (![self isShowLoadingViewWithURL:url]) {
            [SVProgressHUD showWithStatus:@"正在拉取数据"];
        }
        [self request:url parameters:parameters datas:nil method:RequestMethodGet success:success error:error failure:failure];
    }
    
    
    
+ (void)post:(NSString *)url
  parameters:(NSMutableDictionary *)parameters
     success:(void (^)(int code, NSString *msg, id data))success
       error:(void (^)(int code, NSString *msg))error
     failure:(void (^)(NSError *failure))failure
    {
        if (![self isShowLoadingViewWithURL:url]) {
            [SVProgressHUD showWithStatus:@"正在拉取数据"];
        }
        [self request:url parameters:parameters datas:nil method:RequestMethodPost success:success error:error failure:failure];
    }

+ (void)deleteData:(NSString *)url
        parameters:(NSMutableDictionary *)parameters
           success:(void (^)(int code, NSString *msg, id data))success
             error:(void (^)(int code, NSString *msg))error
           failure:(void (^)(NSError *failure))failure {
    if (![self isShowLoadingViewWithURL:url]) {
        [SVProgressHUD showWithStatus:@"正在拉取数据"];
    }
    [self request:url parameters:parameters datas:nil method:RequestMethodDelete success:success error:error failure:failure];
}

+ (void)putData:(NSString *)url
     parameters:(NSMutableDictionary *)parameters
        success:(void (^)(int code, NSString *msg, id data))success
          error:(void (^)(int code, NSString *msg))error
        failure:(void (^)(NSError *failure))failure {
    if (![self isShowLoadingViewWithURL:url]) {
        [SVProgressHUD showWithStatus:@"正在拉取数据"];
    }
    [self request:url parameters:parameters datas:nil method:RequestMethodPut success:success error:error failure:failure];
}

+ (void)head:(NSString *)url
  parameters:(NSMutableDictionary *)parameters
     success:(void (^)(int code, NSString *msg, id data))success
       error:(void (^)(int code, NSString *msg))error
     failure:(void (^)(NSError *failure))failure {
    if (![self isShowLoadingViewWithURL:url]) {
        [SVProgressHUD showWithStatus:@"正在拉取数据"];
    }
    [self request:url parameters:parameters datas:nil method:RequestMethodHead success:success error:error failure:failure];
}
    
+ (void)post:(NSString *)url
  parameters:(NSMutableDictionary *)parameters
       datas:(NSMutableDictionary *)datas
     success:(void (^)(int code, NSString *msg, id data))success
       error:(void (^)(int code, NSString *msg))error
     failure:(void (^)(NSError *failure))failure
    {
        [SVProgressHUD showWithStatus:@"正在拉取数据"];
        [self request:url parameters:parameters datas:datas method:RequestMethodPost success:success error:error failure:failure];
    }
    
+ (void)request:(NSString *)url
     parameters:(NSMutableDictionary *)parameters
          datas:(NSMutableDictionary *)datas
         method:(RequestMethod)method
        success:(void (^)(int code, NSString *msg, id data))success
          error:(void (^)(int code, NSString *msg))error
        failure:(void (^)(NSError *failure))failure
    {
        
        //#ifdef DEBUG
        NSLog(@"request infomation=============");
        NSLog(@"url:%@", url);
        NSLog(@"parameters:%@", parameters);
        NSLog(@"============");
        //#endif
        
        //获取请求对象
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //        [manager.requestSerializer setValue:[ConfigInfo appUserId] forHTTPHeaderField:@"X-USER-ID"];
        //        [manager.requestSerializer setValue:[ConfigInfo appToken] forHTTPHeaderField:@"X-USER-TOKEN"];
        // 2.设置非校验证书模式
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager.securityPolicy setValidatesDomainName:NO];
        
        //设置请求以及响应的解析方式
        if ([url containsString:@""]) {
            if ([url containsString:@""]) {
                manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
            }
            
        }
        url = [NSString stringWithFormat:@"%@?pn=%@&vc=%@&pltm=%@", url,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"],@"ios"];
        if (datas != nil && datas.allKeys.count > 0) {
            [manager.requestSerializer setTimeoutInterval:45];
            [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                for (int i = 0; i < datas.allKeys.count; i++) {
                    NSString *key = [datas.allKeys objectAtIndex:i];
                    NSData *data = [datas objectForKey:key];
                    [formData appendPartWithFileData:data name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpeg"];
                }
            } success:^(NSURLSessionDataTask *operation, id responseObject) {
                [self doSuccess:operation responseObject:responseObject success:success error:error];
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                [self doFailure:operation error:error failure:failure];
            }];
        }
        else {
            NSURLSessionDataTask *task;
            switch (method) {
                case RequestMethodGet:
                {
                    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
                    request.timeoutInterval = TIMEOUT; //设置超时时间
                    task = [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [self doSuccess:task responseObject:responseObject success:success error:error];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [self doFailure:task error:error failure:failure];
                    }];
                  
                }
                    break;
                case RequestMethodPost:
                {
                    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
                    request.timeoutInterval = TIMEOUT; //设置超时时间
                    task = [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [self doSuccess:task responseObject:responseObject success:success error:error];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [self doFailure:task error:error failure:failure];
                    }];
                }
                    break;
                case RequestMethodDelete:
                {
                    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"DELETE" URLString:url parameters:parameters error:nil];
                    request.timeoutInterval = TIMEOUT; //设置超时时间
                    task = [manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [self doSuccess:task responseObject:responseObject success:success error:error];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [self doFailure:task error:error failure:failure];
                    }];
                }
                    break;
                case RequestMethodPut:
                {
                    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"PUT" URLString:url parameters:parameters error:nil];
                    request.timeoutInterval = TIMEOUT; //设置超时时间
                    task = [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [self doSuccess:task responseObject:responseObject success:success error:error];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [self doFailure:task error:error failure:failure];
                    }];
                }
                    break;
                case RequestMethodHead:
                {
                    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"HEAD" URLString:url parameters:parameters error:nil];
                    request.timeoutInterval = TIMEOUT; //设置超时时间
                    task = [manager HEAD:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task) {
                        [self doSuccess:task responseObject:nil success:success error:error];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [self doFailure:task error:error failure:failure];
                    }];
                }
                    break;
               
                    
                default:
                    break;
            }
              [task resume];
        }
}
    
    
+ (void)doSuccess:(NSURLSessionDataTask *)operation
   responseObject:(id)responseObject
          success:(void (^)(int code, NSString *msg, id data))success
            error:(void (^)(int code, NSString *msg))error
    {
        [SVProgressHUD dismiss];
#ifdef DEBUG
        NSLog(@"responseObject:%@", responseObject);
#endif
        NSDictionary *result = (NSDictionary *)responseObject;
        int code = [[result objectForKey:@"status"] intValue];
        NSString *msg = [result objectForKey:@"msg"];
        if (code == 0) {
            if ([result.allKeys containsObject:@"data"]) {
                id data = [result objectForKey:@"data"];
                success(code, msg, data);
                
            }
            else {
                success(code, msg, nil);
            }
        } //验证成功
        else {
            error(code, msg);
        } //验证失败
    }
    
+ (void)doFailure:(NSURLSessionDataTask *)operation error:(NSError *)error failure:(void (^)(NSError *failure))failure
    {
        [SVProgressHUD dismiss];
#ifdef DEBUG
        NSLog(@"operation.responseString:%@", operation.response);
        NSLog(@"failure:%@", error);
        NSData *data =error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"%@",dic);
        if ([dic[@"code"] integerValue] ==105&&![operation.response.URL.absoluteString containsString:@"/api/v1/user/logout"]) {
            //账号登陆和登出跳登陆狂的逻辑处理
        } else if (!dic){
            //            [BaseInfo showErrorMessage:@"请求失败，请检查网络"];
        }
#else
        
#endif
        
        if (failure) {
            //         NSHTTPURLResponse * responses = (NSHTTPURLResponse *)operation.response;
            //         NSLog(@"返回服务端接口码:%ld",    responses.statusCode );
            
            failure(error);
        }
    }
    
    
    
+ (void)post_file:(NSString *)url
       parameters:(NSMutableDictionary *)parameters
            datas:(NSMutableDictionary *)datas
          success:(void (^)(int code, NSString *msg, id data))success
            error:(void (^)(int code, NSString *msg))error
          failure:(void (^)(NSError *failure))failure
    {
        [self request_file:url parameters:parameters datas:datas method:@"post" success:success error:error failure:failure];
    }
    
    // 上传文件时，文件的名字要以下划线_类型结尾（_jpg, _mp3），以便更改流类型
+ (void)request_file:(NSString *)url
          parameters:(NSMutableDictionary *)parameters
               datas:(NSMutableDictionary *)datas
              method:(NSString *)method
             success:(void (^)(int code, NSString *msg, id data))success
               error:(void (^)(int code, NSString *msg))error
             failure:(void (^)(NSError *failure))failure
    {
        
#ifdef DEBUG
        NSLog(@"request infomation");
        NSLog(@"url:%@", url);
        NSLog(@"parameters:%@", parameters);
        NSLog(@" ");
#else
        
#endif
        //获取请求对象
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        if (datas != nil && datas.allKeys.count > 0) {
            [manager.requestSerializer setTimeoutInterval:45];
            [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                for (int i = 0; i < datas.allKeys.count; i++) {
                    NSString *key = [datas.allKeys objectAtIndex:i];
                    NSData *data = [datas objectForKey:key];
                    NSString *suffix = [[key componentsSeparatedByString:@"_"] lastObject];
                    NSString *prefix = [key substringToIndex:(key.length-suffix.length-1)];
                    [formData appendPartWithFileData:data name:key fileName:[NSString stringWithFormat:@"%@.%@", prefix, suffix] mimeType:suffix];
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self doSuccess:task responseObject:responseObject success:success error:error];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self doFailure:task error:error failure:failure];
            }];
        }
        else {
            if ([method isEqualToString:@"get"]) {
                NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
                request.timeoutInterval = 45; //设置超时时间
                NSURLSessionDataTask *task= [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self doSuccess:task responseObject:responseObject success:success error:error];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self doFailure:task error:error failure:failure];
                }];
                [task resume];
            }
            else {
                NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
                request.timeoutInterval = 45; //设置超时时间
                NSURLSessionDataTask *task = [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self doSuccess:task responseObject:responseObject success:success error:error];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self doFailure:task error:error failure:failure];
                }];
                [task resume];
            }
        }
    }

    


+(void)updateImage:(NSString *)url params:(NSMutableDictionary*)params datas:(NSMutableDictionary *)datas success:(void (^)(int code, NSString *msg, id data))success failure:(void (^)(int code, NSString *msg))error{
    //上传文件
    AFHTTPSessionManager *manager = [[KPengRequestMethod manager] sessionManager];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < datas.allKeys.count; i++) {
            NSString *key = [datas.allKeys objectAtIndex:i];
            NSData *data = [datas objectForKey:key];
            [formData appendPartWithFileData:data name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self doSuccess:task responseObject:responseObject success:success error:error];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self doFailure:task error:error failure:nil];
    }];
}
    
+ (void)cancelHTTPOperationsWithMethod:(NSMutableDictionary*)params url:(NSString *)url
    {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        //记录请求
        NSURLSessionDataTask *task = [manager GET:url parameters:params progress:^(NSProgress *_Nonnull downloadProgress) {
            
            //数据请求进度
            
        } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
            
            //请求成功
            
            
        } failure:^(NSURLSessionDataTask *_Nullable task,NSError *_Nonnull error) {
            
            //请求失败
            
        }];
        
        //取消单个网络请求
        [task cancel];
    
}
    
@end
