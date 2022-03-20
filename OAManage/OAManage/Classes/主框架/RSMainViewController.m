//
//  RSMainViewController.m
//  OAManage
//
//  Created by mac on 2019/11/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSMainViewController.h"

//首页
#import "RSServiceViewController.h"

//审核
#import "RSShenHeViewController.h"

//发起
#import "RSLaunchViewController.h"


//我的
#import "RSMenuViewController.h"


@interface RSMainViewController ()

@end

@implementation RSMainViewController

+ (void)load{
    UITabBarItem *item = nil;
    if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
        item = [UITabBarItem appearanceWhenContainedIn:[self class], nil];
    }else{
        if (@available(iOS 9.0, *)) {
            item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
        } else {
            item = [UITabBarItem appearanceWhenContainedIn:[self class], nil];
        }// iOS9.0
    }
    //富文本：带属性的字符串
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    //设置字体颜色
    //[UIColor colorWithRed:41/255.0 green:51/255.0 blue:65/255.0 alpha:1];
    attrDict[NSForegroundColorAttributeName] = [UIColor colorWithHexColorStr:@"#27C79A"];
    //设置标题的富文本
    [item setTitleTextAttributes:attrDict forState:UIControlStateSelected];
    // 设置富文本属性
    NSMutableDictionary *attrNormal = [NSMutableDictionary dictionary];
    // 设置文字大小的属性
    attrNormal[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    // 设置按钮文字的大小属性
    [item setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTintColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    
    [self addSubCtrls];
}

- (void)addSubCtrls {
    self.tabBar.tintColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    //首页
    RSServiceViewController * serviceVc = [[RSServiceViewController alloc]init];
    serviceVc.tabBarItem.tag = 0;
    serviceVc.tabBarItem.title = @"首页";
    serviceVc.tabBarItem.image =  [UIImage imageNamed:@"画板"];
    UIImage * image0 = [UIImage imageNamed:@"画板复制 4"];
    UIImage * newImage0 = [image0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    serviceVc.tabBarItem.selectedImage = newImage0;
    RSMyNavigationViewController * myNav0 = [[RSMyNavigationViewController alloc]initWithRootViewController:serviceVc];
    //审核
    RSShenHeViewController * shenVc = [[RSShenHeViewController alloc]init];
    shenVc.tabBarItem.tag = 1;
    shenVc.tabBarItem.title = @"流程审批";
    shenVc.tabBarItem.image =  [UIImage imageNamed:@"画板复制"];
    UIImage * image1 = [UIImage imageNamed:@"画板复制 5"];
    UIImage * newImage1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shenVc.tabBarItem.selectedImage = newImage1;
    RSMyNavigationViewController * myNav1 = [[RSMyNavigationViewController alloc]initWithRootViewController:shenVc];
    //发起
    RSLaunchViewController * launchVc = [[RSLaunchViewController alloc]init];
    launchVc.tabBarItem.tag = 2;
    launchVc.tabBarItem.title = @"流程发起";
    launchVc.tabBarItem.image =  [UIImage imageNamed:@"画板复制 2"];
    UIImage * image2 = [UIImage imageNamed:@"画板复制 6"];
    UIImage * newImage2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    launchVc.tabBarItem.selectedImage = newImage2;
    RSMyNavigationViewController * myNav2 = [[RSMyNavigationViewController alloc]initWithRootViewController:launchVc];
    //我的
    RSMenuViewController * menuVc = [[RSMenuViewController alloc]init];
    menuVc.tabBarItem.tag = 3;
    menuVc.tabBarItem.title = @"个人中心";
    menuVc.tabBarItem.image =  [UIImage imageNamed:@"画板复制 3"];
    UIImage * image3 = [UIImage imageNamed:@"画板复制 7"];
    UIImage * newImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    menuVc.tabBarItem.selectedImage = newImage3;
    RSMyNavigationViewController * myNav3 = [[RSMyNavigationViewController alloc]initWithRootViewController:menuVc];
    self.viewControllers = @[myNav0,myNav1,myNav2,myNav3];
}
@end
