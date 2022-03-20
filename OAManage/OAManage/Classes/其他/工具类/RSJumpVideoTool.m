//
//  RSJumpVideoTool.m
//  OAManage
//
//  Created by mac on 2020/4/3.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSJumpVideoTool.h"
#import "RSOnlineVideoPlayViewController.h"

@implementation RSJumpVideoTool


+ (void)canYouSkipThePlaybackVideoInterfaceMoment:(RSOnlineModel *)onlinemodel andViewController:(UIViewController *)viewController{
//    if ([friendmodel.viewType isEqualToString:@"video"]) {
        //这边判断是不是wifi的环境下
       
        __weak AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            // 当网络状态改变时调用
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    //NSLog(@"未知网络");
                    [SVProgressHUD showErrorWithStatus:@"手机没有连接网络"];
                     [manager stopMonitoring];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    [SVProgressHUD showErrorWithStatus:@"手机没有连接网络"];
                    [manager stopMonitoring];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    //NSLog(@"手机自带网络");
                    [self alertUserOnVideoPlayViewControlerNetwork:onlinemodel andViewController:viewController];
                     [manager stopMonitoring];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [self jumpVideoPlayViewController:onlinemodel andViewController:viewController];
                     [manager stopMonitoring];
                    break;
            }
        }];
        //开始监控
        [manager startMonitoring];
//    }
//else{
//        [SVProgressHUD showErrorWithStatus:@"不是视频不能播"];
//    }
}



+ (void)alertUserOnVideoPlayViewControlerNetwork:(RSOnlineModel *)onlinemodel andViewController:(UIViewController *)viewController{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * viedoPlayStatus = [user objectForKey:@"viedoPlayStatus"];
    if ([viedoPlayStatus isEqualToString:@"1"]) {
        [user setObject:@"1" forKey:@"viedoPlayStatus"];
        [self jumpVideoPlayViewController:onlinemodel andViewController:viewController];
    }else{
        [JHSysAlertUtil presentAlertViewWithTitle:@"你的网络不处于wifi状态播放该视频,将消耗你的手机流量，是否继续播放" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            [user setObject:@"0" forKey:@"viedoPlayStatus"];
        } confirm:^{
            [user setObject:@"0" forKey:@"viedoPlayStatus"];
            [self jumpVideoPlayViewController:onlinemodel andViewController:viewController];
        }];
    }
}


+ (void)jumpVideoPlayViewController:(RSOnlineModel *)onlinemodel andViewController:(UIViewController *)viewController{
    RSOnlineVideoPlayViewController * videoScreenVc = [[RSOnlineVideoPlayViewController alloc]init];
    videoScreenVc.onlinemodel = onlinemodel;
    [viewController.navigationController pushViewController:videoScreenVc animated:YES];
}



@end
