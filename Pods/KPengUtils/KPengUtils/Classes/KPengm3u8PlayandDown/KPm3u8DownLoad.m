//
//  KPm3u8DownLoad.m
//
//
//  Created by kpeng on 30/4/19.
//  Copyright © 2019 123. All rights reserved.
//

#import "KPm3u8DownLoad.h"
#import <AFNetworking.h>
//#import "BaseInfo.h"
#import "WHCFileManager.h"
@implementation KPm3u8DownLoad
static id sharedInstance = nil;
+ (KPm3u8DownLoad *)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)m3u8DownLoadAction:(NSString*)url {
    NSString *destinationPath = [self.documentPath stringByAppendingPathComponent:url.lastPathComponent];

    [self downloadURL:url
      destinationPath:destinationPath
             progress:nil
           completion:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
               if (!error) {
                   [self dealPlayList:url];
               } else {
                   NSLog(@"%@",error.debugDescription);
               }
           }];
}

// 处理m3u8文件
- (void)dealPlayList:(NSString*)url {
 
    // 读取m3u8文件内容
    NSString *filePath = [self.documentPath stringByAppendingPathComponent:url.lastPathComponent];
    NSString *content = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    NSArray *array = [content componentsSeparatedByString:@"\n"];
    
    // 筛选出 .ts 文件
    NSMutableArray *listArr = [NSMutableArray arrayWithCapacity:array.count];
    for (NSString *str in array) {
        if ([str containsString:@".ts"]) {
            [listArr addObject:str];
        }
    }
    
    NSString *firstStr = listArr.firstObject;
    NSString *videoName = [firstStr componentsSeparatedByString:@"."].firstObject;
//    self.tipLab.text = [NSString stringWithFormat:@"共有 %ld 个视频", listArr.count];
    // 下载 ts 文件
    [self downloadVideoWithArr:listArr andIndex:0 videoName:videoName url:url];
}

// 循环下载 ts 文件
- (void)downloadVideoWithArr:(NSArray *)listArr andIndex:(NSInteger)index videoName:(NSString *)videoName url:(NSString*)url{
    if (index >= listArr.count) {
//        self.tipLab.text = @"视频下载完成";
//        [self combVideos];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(downloadActionPresent:downloadFlag:fileTotal:)]) {
            [self.delegate downloadActionPresent:1.0 downloadFlag:YES fileTotal:listArr.count];
            [self copyFileToWhere:[[url componentsSeparatedByString:@"/"] lastObject]];
        }
        
        return;
    }
    
//    self.tipLab.text = [NSString stringWithFormat:@"共有 %ld 个ts文件, 下载中：%.2f%%", listArr.count, (float)index/listArr.count * 100];
//    self.progressView.progress = (float)index/listArr.count;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(downloadActionPresent:downloadFlag:fileTotal:)]) {
        [self.delegate downloadActionPresent:(float)index/listArr.count downloadFlag:NO fileTotal:listArr.count];
    }
    // 拼接ts全路径，有的文件直接包含，不需要拼接
    NSString *downloadURL = [url stringByReplacingOccurrencesOfString:url.lastPathComponent withString:listArr[index]];
    
    // 存储路径
    NSString *listName = listArr[index];
    NSArray *urlArr =[url componentsSeparatedByString:@"/"];
    NSArray *tsArr =[urlArr.lastObject componentsSeparatedByString:@"."];
    NSString *fileName = [NSString stringWithFormat:@"%@%ld.%@",tsArr[0],(long)index,listName.pathExtension];
    NSString *destinationPath = [self.videoPath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        [self downloadVideoWithArr:listArr andIndex:index+1 videoName:videoName url:url];
        return;
    }
    
    [self downloadURL:downloadURL
      destinationPath:destinationPath
             progress:nil
           completion:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
               if (!error) {
                   [self downloadVideoWithArr:listArr andIndex:index+1 videoName:videoName url:url];
               }
           }];
}


// 沙盒 document 路径
- (NSString *)documentPath  {
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return docDir;
}



// 视频列表路径
- (NSString *)videoPath {
    NSString *vedioPath = [self.documentPath stringByAppendingPathComponent:@"VideoList"];
    NSFileManager *mgr = [NSFileManager defaultManager];
    if (![mgr fileExistsAtPath:vedioPath]) {
        [mgr createDirectoryAtPath:vedioPath
       withIntermediateDirectories:YES
                        attributes:nil
                             error:nil];
    }
    return vedioPath;
}

- (void)copyFileToWhere:(NSString*)m3u8File {
    [WHCFileManager copyItemAtPath:[NSString stringWithFormat:@"%@/%@",[self documentPath],m3u8File] toPath:[NSString stringWithFormat:@"%@/%@",[self videoPath],m3u8File]];
}



// 下载方法
- (void)downloadURL:(NSString *)downloadURL
    destinationPath:(NSString *)destinationPath
           progress:(void (^)(NSProgress *downloadProgress))progress
         completion:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completion {
    AFHTTPSessionManager *manage  = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: downloadURL]];
    
    _downloadTask =
    [manage downloadTaskWithRequest:request
                           progress:^(NSProgress * _Nonnull downloadProgress) {
                               if (progress) {
                                   progress(downloadProgress);
                               }
                           }
                        destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                            
                            NSURL *filePathUrl = nil;
                            if (destinationPath) {
                                filePathUrl = [NSURL fileURLWithPath:destinationPath];
                            }
                            if (filePathUrl) {
                                return filePathUrl;
                            }
                            NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                            NSString *fullpath = [caches stringByAppendingPathComponent:response.suggestedFilename];
                            filePathUrl = [NSURL fileURLWithPath:fullpath];
                            return filePathUrl;
                        }
                  completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error) {
                      if (completion) {
                          completion(response, filePath, error);
                      }
                  }];
    
    [_downloadTask resume];
    _DownLoadStatus =1;
}

- (void)m3u8DownLoadsuspended {
    
    [_downloadTask suspend];
    _DownLoadStatus =0;
    if (_downLoadStatusCallBack) {
        _downLoadStatusCallBack(@"暂停中");
    }
}

- (void)m3u8DownLoadcontinue {
    [_downloadTask resume];
    _DownLoadStatus =1;
    if (_downLoadStatusCallBack) {
        _downLoadStatusCallBack(@"正在下载");
    }
}

- (void)m3u8DownLoadcancel {
    [_downloadTask cancel];
}
@end
