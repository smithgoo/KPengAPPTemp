//
//  ViewController.h
//  KpengTemp
//
//  Created by 王朋 on 2019/5/28.
//  Copyright © 2019 王朋. All rights reserved.
//

#import "ViewController.h"
#import <KPIjkVideoView.h>
#define  url11 @"http://188.91thd.vip/20190424/082/TOG1556024926/TOG1556024926.m3u8"
#define  url22 @"http://www.flashls.org/playlists/test_001/stream_1000k_48k_640x360.m3u8"
#define  url33 @"https://56.com-t-56.com/20190426/15648_12fefab2/index.m3u8"

#import "AppDelegate.h"
@interface ViewController ()<KPIjkVideoViewDelegate>
@property (nonatomic,strong) KPIjkVideoView *videoPlayer;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.CanFullScreen = YES;

    NSString *str =[[NSBundle mainBundle] pathForResource:@"123" ofType:@"mp4"];

    [self initVideoPlayer:@"http://fastwebcache.yod.cn/hls-enc-test/jialebi/stream.m3u8"];

    UIButton *btn =[UIButton new];
    [self.view addSubview:btn];
    btn.frame =CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.width*9/16+50, 100, 100);
    btn.backgroundColor =[UIColor redColor];
    [btn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
//
    UIButton *btn1 =[UIButton new];
    [self.view addSubview:btn1];
    btn1.frame =CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.width*9/16+50+120, 100, 100);
    btn1.backgroundColor =[UIColor redColor];
    [btn1 addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];

}




- (void)playAction:(UIButton*)sender {
    //注意⭐️首字母改成了 ⭐️大写，prefs->Prefs
//    NSURL*right_url=[NSURL URLWithString:@"Prefs:root=General&path=ManagedConfigurationList"];
//    Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
//
//    [[LSApplicationWorkspace performSelector:@selector(defaultWorkspace)] performSelector:@selector(openSensitiveURL:withOptions:) withObject:right_url withObject:nil];
   [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"App-Prefs:root=General&path=ManagedConfigurationList"]];
}

- (void)initVideoPlayer:(NSString*)url {
    _videoPlayer =[[KPIjkVideoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*9/16) delegate:self  playUrl:url title:@"123"];
    [self.view addSubview:_videoPlayer];
}



- (void)RebuildVideoPlayerDistory {

    [self initVideoPlayer:url33];
}

- (void)playerBackAction {
    if (!_videoPlayer.isFullScreen) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [_videoPlayer videoPlayrotateAction:NO];
    }
   
}

- (void)exchangeAction:(UIButton*)sender {
    [_videoPlayer exChangePlayMthod];
}


#pragma mark -与全屏相关的代理方法等

- (void)videoScreenFullScreenOrNot:(BOOL)isFullScreen {
    [_videoPlayer videoPlayrotateAction:isFullScreen];
}



#pragma mark------ijk 播放的代理方法
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    if ([UIDevice currentDevice].orientation ==UIDeviceOrientationLandscapeLeft||[UIDevice currentDevice].orientation ==UIDeviceOrientationLandscapeRight){
        UIWindow*window= [UIApplication sharedApplication].keyWindow;
        _videoPlayer.frame=CGRectMake(0, 0, size.width,size.height);
        _videoPlayer.player.view.frame=CGRectMake(0, 0, size.width,size.height);
        _videoPlayer.isFullScreen=YES;
        _videoPlayer.toolsView.isFullScreen =YES;
        [window addSubview:_videoPlayer];
      
    }else{
//        if (KIsiPhoneX||KIsiPhoneXR||KIsiPhoneXS||KIsiPhoneXS_MAX) {
//            _playerView.frame=CGRectMake(0, 30, size.width, size.width/16*9);
//            _playerView.player.view.frame=CGRectMake(0, 30, size.width, size.width/16*9);
//        } else {
            _videoPlayer.frame=CGRectMake(0, 0, size.width, size.width/16*9);
            _videoPlayer.player.view.frame=CGRectMake(0, 0, size.width, size.width/16*9);
//        }
        _videoPlayer.isFullScreen=NO;
        _videoPlayer.toolsView.isFullScreen =NO;
         [self.view addSubview:_videoPlayer];
      
    }
    
}


@end
