//
//  AppDelegate.m
//  OAManage
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "RSMenuViewController.h"
#import "RSLoginViewController.h"
#import "NetworkTool.h"
#import "FSAES128.h"
//#import <UMCommon/UMConfigure.h>
//首页
#import "RSShowImageViewController.h"

//新版本
#import "RSMainViewController.h"

@interface AppDelegate ()
{
     UIViewController *tempViewControl;
}


// 当前屏幕与设计尺寸宽度比例
@property ( nonatomic , assign ) CGFloat  autoSizeScaleW;
// 当前屏幕与设计尺寸高度比例
@property ( nonatomic , assign ) CGFloat  autoSizeScaleH;

@end

@implementation AppDelegate





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
//    [UMConfigure setLogEnabled:YES];
//    [UMConfigure initWithAppkey:@"5dca71324ca357eb33000a23" channel:@"App Store"];

    
    //    [MobClick setScenarioType:E_UM_NORMAL];
    
    if(@available(iOS 13.0,*)){
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleUnspecified;
    }
    
    
    //小米推送
    [MiPushSDK registerMiPush:self type:0 connect:YES];
    //这边要对登录的数据进行判断是否有用户信息保存，有的话，先去重新获取用户信息在跳转页面
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSData * data = [user objectForKey:@"OAUSERMODEL"];
    RSUserModel * usermodel  = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString * aes = [user objectForKey:@"AES"];
    aes = [aes substringToIndex:aes.length - 6];
    NSTimeInterval interval = [aes doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString * dateString1 = [formatter stringFromDate:date];
    NSDate * monthagoData = [self getPriousorLaterDateFromDate:date withMonth:+1];
    NSString * laterString = [formatter stringFromDate:monthagoData];
    //当前时间
    NSDate * Currentdate = [NSDate date];
    NSString * dateString = [formatter stringFromDate:Currentdate];
    if (laterString.length > 0) {
        if ([dateString isEqualToString:laterString]) {
            [MiPushSDK unsetAccount:[NSString stringWithFormat:@"%ld",(long)usermodel.userId]];
            [user removeObjectForKey:@"AES"];
            [user removeObjectForKey:@"OAUSERMODEL"];
            [user synchronize];
        }
    }
    if (usermodel.appLoginToken.length < 1) {
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        RSMyNavigationViewController * mayNa = [[RSMyNavigationViewController alloc]initWithRootViewController:loginVc];
        self.window.rootViewController = mayNa;
    }else{
    //假的根控制器
    RSShowImageViewController * viewVc= [[RSShowImageViewController alloc]init];
    self.window.rootViewController = viewVc;
    NSString * canshu = URL_YIGODATA_APPLOGINTOKEN(usermodel.appLoginToken);
    NSString * soapStr = URL_YIGODATA_IOS(URL_LOGINWEBSERVICE, URL_USERINFO, canshu);
    NetworkTool * network = [[NetworkTool alloc]init];
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:soapStr andURLName:URL_USERINFO];
    network.successReload = ^(NSDictionary *dict) {
        RSUserModel * usermodel = [[RSUserModel alloc]init];
        usermodel.aesKey = dict[@"aesKey"];
        usermodel.appLoginToken = dict[@"appLoginToken"];
        usermodel.deptName = dict[@"deptName"];
        usermodel.sex = dict[@"sex"];
        usermodel.userCode = dict[@"userCode"];
        usermodel.userId = [dict[@"userId"] integerValue];
        usermodel.userName = dict[@"userName"];
        usermodel.deptId = [dict[@"deptId"] integerValue];
        usermodel.empId = [dict[@"empId"] integerValue];
        usermodel.empName = dict[@"empName"];
        usermodel.AM_Requisition = [dict[@"flowAccess"][@"AM_Requisition"]boolValue];
        usermodel.AM_SetlleIn = [dict[@"flowAccess"][@"AM_SetlleIn"]boolValue];
        usermodel.BL_OutNotice = [dict[@"flowAccess"][@"BL_OutNotice"]boolValue];
        usermodel.BM_MtlReturn = [dict[@"flowAccess"][@"BM_MtlReturn"]boolValue];
        usermodel.BM_OutNotice = [dict[@"flowAccess"][@"BM_OutNotice"]boolValue];
        usermodel.BM_Transfer = [dict[@"flowAccess"][@"BM_Transfer"]boolValue];
        usermodel.BS_OutNotice = [dict[@"flowAccess"][@"BS_OutNotice"]boolValue];
        usermodel.ES_OutNotice = [dict[@"flowAccess"][@"ES_OutNotice"]boolValue];
        usermodel.ES_Transfer = [dict[@"flowAccess"][@"ES_Transfer"]boolValue];
        usermodel.FG_EngQuotation = [dict[@"flowAccess"][@"FG_EngQuotation"]boolValue];
        usermodel.FG_ProcessProduct = [dict[@"flowAccess"][@"FG_ProcessProduct"]boolValue];
        usermodel.FG_ProcessProtocol = [dict[@"flowAccess"][@"FG_ProcessProtocol"]boolValue];
        usermodel.FG_ProfitQuote = [dict[@"flowAccess"][@"FG_ProfitQuote"]boolValue];
        usermodel.Flow_Advertising = [dict[@"flowAccess"][@"Flow_Advertising"]boolValue];
        usermodel.Flow_ApplyActivity = [dict[@"flowAccess"][@"Flow_ApplyActivity"]boolValue];
        usermodel.Flow_ApplyLeave = [dict[@"flowAccess"][@"Flow_ApplyLeave"]boolValue];
        usermodel.Flow_Become = [dict[@"flowAccess"][@"Flow_Become"]boolValue];
        usermodel.Flow_BreakDown = [dict[@"flowAccess"][@"Flow_BreakDown"]boolValue];
        usermodel.Flow_Business = [dict[@"flowAccess"][@"Flow_Business"]boolValue];
        usermodel.Flow_Cachet = [dict[@"flowAccess"][@"Flow_Cachet"]boolValue];
        usermodel.Flow_Chapter = [dict[@"flowAccess"][@"Flow_Chapter"]boolValue];
        usermodel.Flow_Contract = [dict[@"flowAccess"][@"Flow_Contract"]boolValue];
        usermodel.Entertain = [dict[@"flowAccess"][@"Entertain"]boolValue];
        usermodel.Flow_Entertain = [dict[@"flowAccess"][@"Flow_Entertain"]boolValue];
        usermodel.Flow_EquipService = [dict[@"flowAccess"][@"Flow_EquipService"]boolValue];
        usermodel.Flow_Equipment = [dict[@"flowAccess"][@"Flow_Equipment"]boolValue];
        usermodel.Flow_FileUpdate = [dict[@"flowAccess"][@"Flow_FileUpdate"]boolValue];
        usermodel.Flow_FixedAssets = [dict[@"flowAccess"][@"Flow_FixedAssets"]boolValue];
        usermodel.Flow_HumanNeed = [dict[@"flowAccess"][@"Flow_HumanNeed"]boolValue];
        usermodel.Flow_InCachet = [dict[@"flowAccess"][@"Flow_InCachet"]boolValue];
        
        usermodel.Flow_WorkOvertime =  [dict[@"flowAccess"][@"Flow_WorkOvertime"]boolValue];
        usermodel.Flow_SpecialApplication = [dict[@"flowAccess"][@"Flow_SpecialApplication"]boolValue];
        
        
        usermodel.Flow_InvestContract = [dict[@"flowAccess"][@"Flow_InvestContract"]boolValue];
        usermodel.Flow_Payment = [dict[@"flowAccess"][@"Flow_Payment"]boolValue];
        usermodel.Flow_PostMove = [dict[@"flowAccess"][@"Flow_PostMove"]boolValue];
        usermodel.Flow_Purchase = [dict[@"flowAccess"][@"Flow_Purchase"]boolValue];
        usermodel.Flow_Quit = [dict[@"flowAccess"][@"Flow_Quit"]boolValue];
        usermodel.Flow_Receptions = [dict[@"flowAccess"][@"Flow_Receptions"]boolValue];
        usermodel.Flow_Restaurant = [dict[@"flowAccess"][@"Flow_Restaurant"]boolValue];
        usermodel.Flow_RsApplyLeave = [dict[@"flowAccess"][@"Flow_RsApplyLeave"]boolValue];
        usermodel.Flow_RsBreakDown = [dict[@"flowAccess"][@"Flow_RsBreakDown"]boolValue];
        usermodel.Flow_RsPayment = [dict[@"flowAccess"][@"Flow_RsPayment"]boolValue];
        usermodel.Flow_SaleContract = [dict[@"flowAccess"][@"Flow_SaleContract"]boolValue];
        usermodel.Flow_SupplierConsume = [dict[@"flowAccess"][@"Flow_SupplierConsume"]boolValue];
        usermodel.Flow_UsedIdle = [dict[@"flowAccess"][@"Flow_UsedIdle"]boolValue];
        usermodel.Flow_VehicleReservation = [dict[@"flowAccess"][@"Flow_VehicleReservation"]boolValue];
        usermodel.Flow_WasteDisposal = [dict[@"flowAccess"][@"Flow_WasteDisposal"]boolValue];
        usermodel.SC_PayIn = [dict[@"flowAccess"][@"SC_PayIn"]boolValue];
        usermodel.SL_OutNotice = [dict[@"flowAccess"][@"SL_OutNotice"]boolValue];
        usermodel.SL_Transfer = [dict[@"flowAccess"][@"SL_Transfer"]boolValue];
        usermodel.SM_SendNotice = [dict[@"flowAccess"][@"SM_SendNotice"]boolValue];
        usermodel.SM_Transfer = [dict[@"flowAccess"][@"SM_Transfer"]boolValue];
        usermodel.UseCar = [dict[@"flowAccess"][@"UseCar"]boolValue];
        
        usermodel.OA_Market_Home = [dict[@"flowAccess"][@"OA_Market_Home"]boolValue];
        usermodel.OA_BM_IO = [dict[@"flowAccess"][@"OA_BM_IO"]boolValue];
        usermodel.OA_SL_IO = [dict[@"flowAccess"][@"OA_SL_IO"]boolValue];
        usermodel.OA_Lease = [dict[@"flowAccess"][@"OA_Lease"]boolValue];
        usermodel.OA_Ledger  = [dict[@"flowAccess"][@"OA_Ledger"]boolValue];
        usermodel.OA_Ledger_Dtl = [dict[@"flowAccess"][@"OA_Ledger_Dtl"]boolValue];
        
        usermodel.OA_Market_Fee = [dict[@"flowAccess"][@"OA_Market_Fee"]boolValue];
               usermodel.OA_Market_Dealer_Fee  = [dict[@"flowAccess"][@"OA_Market_Dealer_Fee"]boolValue];
               usermodel.OA_Market_Pay_In  = [dict[@"flowAccess"][@"OA_Market_Pay_In"]boolValue];
        
        usermodel.OA_Market_Settle_In  = [dict[@"flowAccess"][@"OA_Market_Settle_In"]boolValue];
        
        usermodel.Flow_PropertyServices = [dict[@"flowAccess"][@"Flow_PropertyServices"]boolValue];
        usermodel.Flow_TrainingCosts = [dict[@"flowAccess"][@"Flow_TrainingCosts"]boolValue];

        [MiPushSDK setAccount:[NSString stringWithFormat:@"%ld",(long)usermodel.userId]];
        [user removeObjectForKey:@"OAUSERMODEL"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:usermodel];
        [user setObject:data forKey:@"OAUSERMODEL"];
        [user synchronize];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            RSMainViewController * mainVc = [[RSMainViewController alloc]init];
            self.window.rootViewController = mainVc;

        });
    };
    network.failure = ^(NSDictionary *dict) {
        [MiPushSDK unsetAccount:[NSString stringWithFormat:@"%ld",(long)usermodel.userId]];
        [user removeObjectForKey:@"AES"];
        [user removeObjectForKey:@"OAUSERMODEL"];
        [user synchronize];

       // AppDelegate * appdelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        RSMyNavigationViewController *  mayNa = [[RSMyNavigationViewController alloc]initWithRootViewController:loginVc];
        self.window.rootViewController = mayNa;
     };
    }
    //
    self.window.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    [self.window makeKeyAndVisible];
   
    // 点击通知打开app处理逻辑
    NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo){
        NSString *messageId = [userInfo objectForKey:@"_id_"];
        if (messageId!=nil) {
            [MiPushSDK openAppNotify:messageId];
        }
    }
    [self initAutoScaleSize];
    //设置键盘
    [self settIQKeyMananger];
    //监测网络
    [self networkInspect];
    return YES;
}

- (void)initAutoScaleSize
{
    
    if (SCH==480)
    {
        //4s
        _autoSizeScaleW =SCW/375;
        _autoSizeScaleH =SCH/667;
    }
    else if(SCH==568)
    {
        //5
        _autoSizeScaleW =SCW/375;
        _autoSizeScaleH =SCH/667;
    }
    else if(SCH==667)
     {
//4.7
        //6 6s 7 8 se
        _autoSizeScaleW =SCW/375;
        _autoSizeScaleH =SCH/667;
    }
    else if(SCH==736)
    {
//5.5
        //6p 7p 8p
        _autoSizeScaleW =SCW/375;
        _autoSizeScaleH =SCH/736;
    }else if(SCH== 812){
//5.8
     //iphonex iPhone XS iphone11pro
      _autoSizeScaleW =SCW/375;
        _autoSizeScaleH =SCH/812;


    }else if(SCH== 896){
//6.1
     //iphonexr  iphone11  iphone xs max  iPhone 11 pro max
_autoSizeScaleW =SCW/414;
        _autoSizeScaleH =SCH/896;

    }else if(SCH== 780){
       //iphone 12 mini
_autoSizeScaleW =SCW/360;
        _autoSizeScaleH =SCH/780;
 
    }else if(SCH == 844){
       //iphone 12  iPhone 12 pro
_autoSizeScaleW =SCW/390;
        _autoSizeScaleH =SCH/844;
 
    }else if(SCH == 926){
       //iPhone 12 pro max
 _autoSizeScaleW =SCW/428;
        _autoSizeScaleH =SCH/926;
    }
else
    {
        _autoSizeScaleW =1;
        _autoSizeScaleH =1;
    }
}

- (CGFloat)autoScaleW:(CGFloat)w{
    return w * self.autoSizeScaleW;
}
- (CGFloat)autoScaleH:(CGFloat)h{
    return h * self.autoSizeScaleH;
}

//获取后一个月的时间
-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    NSDate * mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}
//FIXME:这边是设置键盘
- (void)settIQKeyMananger{
    IQKeyboardManager * keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}
//FIXME:这边是网络
-(void)networkInspect
{
    __weak typeof(self) weakSelf = self;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //NSLog(@"未知网络");
                [weakSelf showNetWorkBar];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //NSLog(@"没有网络");
                //此步意义不明
                //                if([[self topViewController]class] ==[ToolNetWorkSolveVC class])
                //                {
                //                    [self dismissNetWorkBar];
                //                    return;
                //                }
                // [self showNetWorkBar];
                [weakSelf showNetWorkBar];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //NSLog(@"手机自带网络");
                //   [weakSelf showPhoneNetworkBar];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //NSLog(@"WIFI");
                //[weakSelf showWIFINetworkBar];
                break;
        }
    }];
    //开始监控
    [manager startMonitoring];
}

- (void)showNetWorkBar{
    tempViewControl = [self topViewController];
    [self showNotNetworkView:[self topViewController]];
}

- (void)showWIFINetworkBar{
    tempViewControl = [self topViewController];
    [self showWifiNetwork:[self topViewController]];
}

- (void)showPhoneNetworkBar{
    tempViewControl = [self topViewController];
    [self showYouPhoneNetWork:[self topViewController]];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:self.window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

#pragma mark -- 当没有网络的时候
- (void)showNotNetworkView:(UIViewController *)viewController{
    Nonetwork *Nonet=[[Nonetwork alloc] initWithFrame:[UIScreen mainScreen].bounds];
    Nonet.Prompt=@"无法连接服务器，请检查你的网络设置";
    Nonet.typeDisappear=0;
    Nonet.Warningicon.image=[UIImage imageNamed:@"internet"];
    [Nonet popupWarningview];
    Nonet.returnsAnEventBlock = ^{
        // NSLog(@"重新加载数据");
    };
    [Nonet bringSubviewToFront:viewController.view];
    [viewController.view addSubview:Nonet];
}

#pragma mark -- 有WIFT的时候
- (void)showWifiNetwork:(UIViewController *)viewController{
    Nonetwork *Nonet=[[Nonetwork alloc] initWithFrame:[UIScreen mainScreen].bounds];
    Nonet.Prompt=@"已连接WIFI";
    Nonet.typeDisappear=0;
    Nonet.Warningicon.image=[UIImage imageNamed:@"WIFI 我fi"];
    [Nonet popupWarningview];
    Nonet.returnsAnEventBlock = ^{
        //NSLog(@"重新加载数据");
    };
    [Nonet bringSubviewToFront:viewController.view];
    [viewController.view addSubview:Nonet];
}

#pragma mark -- 手机的网络
- (void)showYouPhoneNetWork:(UIViewController *)viewController{
    Nonetwork *Nonet=[[Nonetwork alloc] initWithFrame:[UIScreen mainScreen].bounds];
    Nonet.Prompt=@"已连接手机网络";
    Nonet.typeDisappear=0;
    Nonet.Warningicon.image=[UIImage imageNamed:@"4g"];
    [Nonet popupWarningview];
    Nonet.returnsAnEventBlock = ^{
        //NSLog(@"重新加载数据");
    };
    [Nonet bringSubviewToFront:viewController.view];
    [viewController.view addSubview:Nonet];
}

#pragma mark -- 这下面都是小米推送获取推送消息ios10.0之前
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //NSLog(@"------------77777777------%@",[NSString stringWithFormat:@"APNS notify: %@", userInfo]);
    //NSString *messageId = [userInfo objectForKey:@"_id_"];
    // 当同时启动APNs与内部长连接时, 把两处收到的消息合并. 通过miPushReceiveNotification返回
    [MiPushSDK handleReceiveRemoteNotification:userInfo];
    //[MiPushSDK openAppNotify:messageId];
}

#pragma mark 注册push服务.
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // [vMain printLog:[NSString stringWithFormat:@"APNS token: %@", [deviceToken description]]];
    //NSLog(@"-----------888888-------%@",[NSString stringWithFormat:@"APNS token: %@", [deviceToken description]]);
    // 注册APNS成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    //[vMain printLog:[NSString stringWithFormat:@"APNS error: %@", err]];
    // 注册APNS失败.
    // 自行处理.
    //NSLog(@"-----9999999-------%@",[NSString stringWithFormat:@"APNS error: %@", err]);
}

// iOS10新加入的回调方法
// 应用在前台收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        // [vMain printLog:[NSString stringWithFormat:@"APNS notify: %@", userInfo]];
        //NSLog(@"--------------10000-----------%@",[NSString stringWithFormat:@"APNS notify: %@", userInfo]);
        [MiPushSDK handleReceiveRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert);
}

// 点击通知进入应用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        // [vMain printLog:[NSString stringWithFormat:@"APNS notify: %@", userInfo]];
        // NSLog(@"---------------11111111----------%@",[NSString stringWithFormat:@"APNS notify: %@", userInfo]);
        [MiPushSDK handleReceiveRemoteNotification:userInfo];
    }
    completionHandler();
}
#pragma mark MiPushSDKDelegate
- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data
{
    //[vMain printLog:[NSString stringWithFormat:@"command succ(%@): %@", [self getOperateType:selector], data]];
    // NSLog(@"--------------122222222-----------%@",[NSString stringWithFormat:@"command succ(%@): %@", [self getOperateType:selector], data]);
    if ([selector isEqualToString:@"registerMiPush:"]) {
        //[vMain setRunState:YES];
    }else if ([selector isEqualToString:@"registerApp"]) {
        // 获取regId
        // NSLog(@"regid = %@", data[@"regid"]);
    }else if ([selector isEqualToString:@"bindDeviceToken:"]) {
        //  [MiPushSDK setAlias:@"1"];
        // [MiPushSDK subscribe:@"2"];
        // [MiPushSDK setAccount:@"8"];
        // 获取regId
    }else if ([selector isEqualToString:@"unregisterMiPush"]) {
        // [vMain setRunState:NO];
    }
    // [MiPushSDK getAllAccountAsync];
}

- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data
{
    //[vMain printLog:[NSString stringWithFormat:@"command error(%d|%@): %@", error, [self getOperateType:selector], data]];
    //  NSLog(@"-------------1333333333---------%@",[NSString stringWithFormat:@"command error(%d|%@): %@", error, [self getOperateType:selector], data]);
}

- (void)miPushReceiveNotification:(NSDictionary*)data
{
    // 1.当启动长连接时, 收到消息会回调此处
    // 2.[MiPushSDK handleReceiveRemoteNotification]
    //   当使用此方法后会把APNs消息导入到此
    //[vMain printLog:[NSString stringWithFormat:@"XMPP notify: %@", data]];
    // NSLog(@"---------14444444------%@",[NSString stringWithFormat:@"XMPP notify: %@", data]);
}

- (NSString*)getOperateType:(NSString*)selector
{
    NSString *ret = nil;
    if ([selector hasPrefix:@"registerMiPush:"] ) {
        ret = @"客户端注册设备";
    }else if ([selector isEqualToString:@"unregisterMiPush"]) {
        ret = @"客户端设备注销";
    }else if ([selector isEqualToString:@"registerApp"]) {
        ret = @"注册App";
    }else if ([selector isEqualToString:@"bindDeviceToken:"]) {
        ret = @"绑定 PushDeviceToken";
    }else if ([selector isEqualToString:@"setAlias:"]) {
        ret = @"客户端设置别名";
    }else if ([selector isEqualToString:@"unsetAlias:"]) {
        ret = @"客户端取消别名";
    }else if ([selector isEqualToString:@"subscribe:"]) {
        ret = @"客户端设置主题";
    }else if ([selector isEqualToString:@"unsubscribe:"]) {
        ret = @"客户端取消主题";
    }else if ([selector isEqualToString:@"setAccount:"]) {
        ret = @"客户端设置账号";
    }else if ([selector isEqualToString:@"unsetAccount:"]) {
        ret = @"客户端取消账号";
    }else if ([selector isEqualToString:@"openAppNotify:"]) {
        ret = @"统计客户端";
    }else if ([selector isEqualToString:@"getAllAliasAsync"]) {
        ret = @"获取Alias设置信息";
    }else if ([selector isEqualToString:@"getAllTopicAsync"]) {
        ret = @"获取Topic设置信息";
    }
    return ret;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == true) {   // 如果属性值为YES,仅允许屏幕向左旋转,否则仅允许竖屏
        return UIInterfaceOrientationMaskAll;  // 这里是屏幕要旋转的方向
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}

- (BOOL)shouldAutorotate
{
    if (_allowRotation == true) {
        return YES;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack
@synthesize persistentContainer = _persistentContainer;
- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"OAManage"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
