//
//  NetworkTool.m
//  WebServiceDemo
//
//  Created by mac on 2018/10/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "NetworkTool.h"
#import "AppDelegate.h"
#import "RSLoginViewController.h"


#import "RSMenuViewController.h"



#import "RSRoleModel.h"

#import "RSInformationModel.h"
#import "RSAuditedModel.h"
#import "RSShenHeModel.h"
#import "RSApprovalProcessModel.h"
//通讯录
#import "RSMailModel.h"

//banner
#import "RSBannerModel.h"
//公告
#import "RSNoticeModel.h"
//体系文件
#import "RSSystemModel.h"
//体系文件类型
#import "RSSystemTypeModel.h"
//工作日志列表
#import "RSNewAuditedModel.h"


#import "RSWorkContentModel.h"
#import "RSWorkTypeModel.h"

//解控列表
#import "RSTouchModel.h"
//货主名
#import "RSShipperMode.h"
//仓库
#import "RSWarehouseModel.h"
//库区
#import "RSStoreAreaModel.h"

//视频的分类
#import "RSOnlineTypeModel.h"

//视频模型
#import "RSOnlineModel.h"


@interface NetworkTool() <NSXMLParserDelegate>

//这个字符串是用来区分是那个网络的
@property (nonatomic,strong)NSString * tempStr;

@end


@implementation NetworkTool

//这边是获取单页的UITableview的数据
- (void)reloadWebServiceNetDataUrl:(NSString *)URLStr andParameters:(NSString *)soapStr withBlock:(AFNetworkingBlock)block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 30.f;
    // 返回NSData
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头，也可以不设置
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"SOAPAction"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error)
    {
             return soapStr;
    }];
    [manager POST:URLStr parameters:soapStr progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(error,NO);
    }];
}

//新的请求方式
- (void)newReloadWebServiceNetDataUrl:(NSString *)url withParameters:(NSDictionary *)parameters andURLName:(NSString *)urlName withBlock:(AFNetworkingBlock)block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    manager.requestSerializer.timeoutInterval = 30.0f;
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        block(responseObject,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        block(error,NO);
    }];
}



//新的
- (void)newReloadWebServiceNoDataURL:(NSString *)URLstr andParameters:(NSDictionary *)soapStr andURLName:(NSString *)urlName{
    _tempStr = urlName;
    [self newReloadWebServiceNetDataUrl:URLstr withParameters:soapStr andURLName:urlName withBlock:^(id responseObject, BOOL success) {
//        NSLog(@"================================%@",responseObject);
        if (success) {
            BOOL isresult = [responseObject[@"success"]boolValue];
            if (isresult) {
                if ([urlName isEqualToString:URL_BANNER_IOS]) {
                    NSMutableArray * array = [RSBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                    if (self.successArrayReload) {
                        self.successArrayReload(array);
                    }
                }else if ([urlName isEqualToString:URL_NOTICE_IOS]){
                     NSMutableArray * array = [RSNoticeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                     if (self.successArrayReload) {
                         self.successArrayReload(array);
                     }
                }else if ([urlName isEqualToString:URL_INFORMATION_IOS]){
                    NSMutableArray * array = [RSInformationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                    if (self.successArrayReload) {
                        self.successArrayReload(array);
                    }
                }else if ([urlName isEqualToString:URL_SYS_FILES_IOS]){
                    
                     
                    NSMutableArray * array = [RSSystemModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                    if (self.successArrayReload) {
                        self.successArrayReload(array);
                    }
                }else if ([urlName isEqualToString:URL_SYS_FILES_TYPE_IOS]){
                    NSMutableArray * array = [RSSystemTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                    if (self.successArrayReload) {
                        self.successArrayReload(array);
                    }
                }else if ([urlName isEqualToString:URL_DIARY_IOS]){
                    
                    
                    NSMutableArray * array = [RSNewAuditedModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                    if (self.successArrayReload) {
                        self.successArrayReload(array);
                    }
                }else if ([urlName isEqualToString:URL_DIARY_GET_DTL_IOS] || [urlName isEqualToString:URL_DIARY_ADD_IOS] || [urlName isEqualToString:URL_DIARY_UPDATE_IOS]){
                    
                    RSWorkContentModel * workContentmodel = [[RSWorkContentModel alloc]init];
                    workContentmodel.createTime = responseObject[@"data"][@"createTime"];
                    workContentmodel.diaryDate = responseObject[@"data"][@"diaryDate"];
                    workContentmodel.summary = responseObject[@"data"][@"summary"];
                    workContentmodel.updateTime = responseObject[@"data"][@"updateTime"];
                    workContentmodel.createUser = [responseObject[@"data"][@"createUser"] integerValue];
                    workContentmodel.status = [responseObject[@"data"][@"status"] integerValue];
                    workContentmodel.updateUser = [responseObject[@"data"][@"updateUser"] integerValue];
                    workContentmodel.workId = [responseObject[@"data"][@"workId"] integerValue];
                    
                    NSMutableArray * inCompleteArray = [NSMutableArray array];
                    inCompleteArray = responseObject[@"data"][@"incomplete"];
                    for (int i = 0; i < inCompleteArray.count; i++) {
                       RSWorkTypeModel * workTypemodel = [RSWorkTypeModel statusWithDict:[inCompleteArray objectAtIndex:i] andIndex:i];
                       [workContentmodel.inCompleteArray addObject:workTypemodel];
                    }
                    
                    NSMutableArray * todayPlanArray = [NSMutableArray array];
                    todayPlanArray = responseObject[@"data"][@"todayPlan"];
                    for (int i = 0; i < todayPlanArray.count; i++) {
                       RSWorkTypeModel * workTypemodel = [RSWorkTypeModel statusWithDict:[todayPlanArray objectAtIndex:i] andIndex:i];
                       [workContentmodel.todayPlanArray addObject:workTypemodel];
                    }
                    NSMutableArray * tomorrowPlanArray = [NSMutableArray array];
                    tomorrowPlanArray = responseObject[@"data"][@"tomorrowPlan"];
                    for (int i = 0; i < tomorrowPlanArray.count; i++) {
                       RSWorkTypeModel * workTypemodel = [RSWorkTypeModel statusWithDict:[tomorrowPlanArray objectAtIndex:i] andIndex:i];
                       [workContentmodel.tomorrowPlanArray addObject:workTypemodel];
                    }
                    if (self.workSuccess) {
                        self.workSuccess(workContentmodel);
                    }
                }else if ([urlName isEqualToString:URL_DIARY_DELETE_IOS]){
                    if (self.deleteSuccess) {
                      self.deleteSuccess();
                    }
                }else if ([urlName isEqualToString:URL_VIDEO_IOS]){
                    //获取视频
                    NSMutableArray * array = [RSOnlineModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                    if (self.successArrayReload) {
                        self.successArrayReload(array);
                    }
                }else if ([urlName isEqualToString:URL_VIDEOTYPE_IOS]){
                    NSMutableArray * array = [RSOnlineTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                                       if (self.successArrayReload) {
                                           self.successArrayReload(array);
                                       }
                }else if ([urlName isEqualToString:URL_VIDEORECOMMEND_IOS]){
                    NSMutableArray * array = [RSOnlineModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
                    if (self.successArrayReload) {
                        self.successArrayReload(array);
                    }
                }
                else{
                   
                }
            }else{
                if ([urlName isEqualToString:URL_INFORMATION_IOS] || [urlName isEqualToString:URL_SYS_FILES_IOS] || [urlName isEqualToString:URL_DIARY_IOS] || [urlName isEqualToString:URL_DIARY_GET_DTL_IOS] || [urlName isEqualToString:URL_NOTICE_IOS] || [urlName isEqualToString:URL_VIDEO_IOS] || [urlName isEqualToString:URL_VIDEOTYPE_IOS] || [urlName isEqualToString:URL_VIDEORECOMMEND_IOS]) {
                    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                    if (self.failure) {
                        self.failure(dict);
                    }
                }
                [self newReloadErrorStatus:[responseObject[@"status"] integerValue]];
            }
        }else{
            
            
            
            if ([urlName isEqualToString:URL_INFORMATION_IOS] || [urlName isEqualToString:URL_SYS_FILES_IOS] || [urlName isEqualToString:URL_DIARY_IOS] || [urlName isEqualToString:URL_DIARY_GET_DTL_IOS] || [urlName isEqualToString:URL_NOTICE_IOS] || [urlName isEqualToString:URL_VIDEO_IOS] || [urlName isEqualToString:URL_VIDEOTYPE_IOS] || [urlName isEqualToString:URL_VIDEORECOMMEND_IOS]) {
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                if (self.failure) {
                    self.failure(dict);
                }
            }
             [self newReloadErrorStatus:[responseObject[@"status"] integerValue]];
        }
    }];
}

- (void)newReloadErrorStatus:(NSInteger)status{
    switch (status) {
        case 1:
            jxt_showToastMessage(@"错误", 0.75);
            break;
        case 10:
            [self userloginOut];
            break;
        case 11:
             jxt_showToastMessage(@"无权限", 0.75);
            break;
        case 2:
            jxt_showToastMessage(@"非法请求", 0.75);
            break;
        default:
             jxt_showToastMessage(@"请求失败", 0.75);
            break;
    }
}

//获取用户信息
- (void)reloadWebServiceNoDataURL:(NSString *)URLstr  andParameters:(NSString *)soapStr andURLName:(NSString *)urlName{
    _tempStr = urlName;
    URLstr = [URLstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    URLstr =  [URLstr stringByReplacingOccurrencesOfString:@"%20" withString:@""];
    [self reloadWebServiceNetDataUrl:URLstr andParameters:soapStr withBlock:^(id responseObject, BOOL success) {
        if (success) {
            NSXMLParser * parser = [[NSXMLParser alloc]initWithData:responseObject];
            parser.delegate = self;
            [parser parse];
        }else{
            if ([urlName isEqualToString:URL_USERINFO]) {
                if (self.failure) {
                    self.failure(responseObject);
                }
            }else if ([urlName isEqualToString:URL_LOGIN]){
                [SVProgressHUD showErrorWithStatus:@"登录失败"];
                if (self.failure) {
                    self.failure(responseObject);
                }
            }else if ([urlName isEqualToString:URL_LOGOUT]){
                [SVProgressHUD showErrorWithStatus:@"退出登录失败"];
            }else if ([urlName isEqualToString:URL_VALIDUSERCODE]){
                
                //这边是判断账号是否重名
                [SVProgressHUD showErrorWithStatus:@"判断账号重名失败"];
                if (self.failure) {
                    self.failure(responseObject);
                }
            }else if ([urlName isEqualToString:URL_REGISTERUSER]){
                [SVProgressHUD showErrorWithStatus:@"注册失败"];
                if (self.failure) {
                    self.failure(responseObject);
                }
            }
            else {
               [SVProgressHUD showErrorWithStatus:@"获取失败"];
                if (self.failure) {
                    self.failure(responseObject);
                }
            }
        }
    }];
}
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
}

//正在解析
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if ([elementName isEqualToString:@"unsafeInvokeServiceReturn"]) {
        storingFlag = true;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (storingFlag) {
        if (!currentElementValue) {
            currentElementValue = [[NSMutableString alloc] initWithString:string];
        }
        else {
            [currentElementValue appendString:string];
        }
    }
}
//解析完成
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //在子线程要回主线程去刷新界面
    if (storingFlag) {
        NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
         storingFlag = false;
        //字符串转字典
       NSDictionary * dict = [self dictionaryWithJsonString:trimmedString];
       BOOL issuccess = [dict[@"result"] boolValue];
        if (issuccess) {
            if ([_tempStr isEqualToString:URL_GENPUBLICKEY]){
                if (self.successReload) {
                    self.successReload(dict);
                }
            }else if ([_tempStr isEqualToString:URL_FINDROLE]){
                NSMutableArray * array = [RSRoleModel mj_objectArrayWithKeyValuesArray:dict[@"data"][@"list"]];
                if (self.successArrayReload) {
                    self.successArrayReload(array);
                }
            }else if ([_tempStr isEqualToString:URL_LOGIN]){
                //这边也可以做解密
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                if (self.successReload) {
                    self.successReload(dic);
                }
            }else if ([_tempStr isEqualToString:URL_USERINFO]){
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                if (self.successReload) {
                    self.successReload(dic);
                }
            }else if ([_tempStr isEqualToString:URL_CHANGPWD]){
                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",dict[@"message"]]];
                if (self.successReload) {
                    self.successReload(dict);
                }
            }else if ([_tempStr isEqualToString:URL_LIFTLIST]){
                //解控列表
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                 
                NSMutableArray * array = [RSTouchModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
                if (self.successArrayReload) {
                    self.successArrayReload(array);
                }
            }else if ([_tempStr isEqualToString:URL_STOCK]){
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                if (self.successReload) {
                    self.successReload(dic);
                }
                
            }else if ([_tempStr isEqualToString:URL_LIFTSAVE]){
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                
                if (self.successReload) {
                    self.successReload(dic);
                }
            }else if ([_tempStr isEqualToString:URL_LIFTLOAD]){
                
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                
                if (self.successReload) {
                    self.successReload(dic);
                }
            }else if ([_tempStr isEqualToString:URL_LIFTDELETE]){
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                
                if (self.successReload) {
                    self.successReload(dic);
                }
                
                
            }else if ([_tempStr isEqualToString:URL_LIFTUPDATE]){
                
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                
                if (self.successReload) {
                    self.successReload(dic);
                }
                
                
                
            }else if ([_tempStr isEqualToString:URL_LIFTSTATE]){
                
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                
                if (self.successReload) {
                        self.successReload(dic);
                }
            }else if ([_tempStr isEqualToString:URL_VALIDUSERCODE]){
                if (self.successReload) {
                    self.successReload(dict);
                }
            }else if ([_tempStr isEqualToString:URL_REGISTERUSER]){
                if (self.successReload) {
                    self.successReload(dict);
                }
            }
            
//            else if ([_tempStr isEqualToString:URL_NOTICE]){
//                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
//
//                NSMutableArray * array = [RSInformationModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
//                if (self.successArrayReload) {
//                    self.successArrayReload(array);
//                }
//            }
//            else if ([_tempStr isEqualToString:URL_TOBEAUDIT]){
//                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
//                NSMutableArray * array = [RSAuditedModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
//                if (self.successArrayReload) {
//                    self.successArrayReload(array);
//                }
//            }
            else if ([_tempStr isEqualToString:URL_FLOWLIST]){
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                NSMutableArray * array = [RSShenHeModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
                if (self.successArrayReload) {
                    self.successArrayReload(array);
                }
            }else if ([_tempStr isEqualToString:URL_MYAUDIT]){
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                NSMutableArray * array = [RSAuditedModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
                if (self.successArrayReload) {
                    self.successArrayReload(array);
                }
            }else if ([_tempStr isEqualToString:URL_AUDITFLOW]){
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                NSMutableArray * array = [RSApprovalProcessModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
                if (self.successArrayReload) {
                    self.successArrayReload(array);
                }
                if (self.successReload) {
                    self.successReload(dic);
                }
            }else if ([_tempStr isEqualToString:URL_LOGOUT]){
                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                    NSData * data = [user objectForKey:@"OAUSERMODEL"];
                    RSUserModel * usermodel  = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                    [MiPushSDK unsetAccount:[NSString stringWithFormat:@"%ld",usermodel.userId]];
                    [user removeObjectForKey:@"OAUSERMODEL"];
                    [user removeObjectForKey:@"AES"];
                    [user synchronize];
                    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                
                
                
                RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
                RSMyNavigationViewController * mayNa = [[RSMyNavigationViewController alloc]initWithRootViewController:loginVc];
                    appdelegate.window.rootViewController = mayNa;
            }else if ([_tempStr isEqualToString:URL_LOADMAILLIST]){
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                NSMutableArray * array = [RSMailModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
                if (self.successArrayReload) {
                    self.successArrayReload(array);
                }
            }else{
                
                //if ([_tempStr isEqualToString:URL_LOADDICTIONNARY])
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                if ([_tempStr isEqualToString:@"dealer"]) {
                    NSMutableArray * array = [RSShipperMode mj_objectArrayWithKeyValuesArray:dic[@"dealer"]];
                    if (self.successArrayReload) {
                        self.successArrayReload(array);
                    }
                }
                
                if ([_tempStr isEqualToString:@"warehouse"]) {
                  NSMutableArray * array1 = [RSWarehouseModel mj_objectArrayWithKeyValuesArray:dic[@"warehouse"]];
                  if (self.successArrayReload) {
                    self.successArrayReload(array1);
                  }
                }
                
                 if ([_tempStr isEqualToString:@"storeArea"]) {
                     NSMutableArray * array2 = [RSStoreAreaModel mj_objectArrayWithKeyValuesArray:dic[@"storeArea"]];
                     if (self.successArrayReload) {
                         self.successArrayReload(array2);
                     }
                 }
                
                
            }
        }else {
            //|| [_tempStr isEqualToString:URL_NOTICE] || [_tempStr isEqualToString:URL_TOBEAUDIT]
            if (  [_tempStr isEqualToString:URL_CHANGPWD] || [_tempStr isEqualToString:URL_FLOWLIST] || [_tempStr isEqualToString:URL_LOGOUT]){
                [self errerAlertUserStatus:dict];
            }else if ([_tempStr isEqualToString:URL_LOGIN] ||[_tempStr isEqualToString:URL_GENPUBLICKEY] || [_tempStr isEqualToString:URL_FINDROLE] || [_tempStr isEqualToString:URL_MYAUDIT] ||  [_tempStr isEqualToString:URL_AUDITFLOW] || [_tempStr isEqualToString:URL_LIFTLIST] || [_tempStr isEqualToString:URL_LIFTSAVE] || [_tempStr isEqualToString:URL_LIFTLOAD] || [_tempStr isEqualToString:URL_LIFTDELETE] || [_tempStr isEqualToString:URL_LIFTUPDATE] || [_tempStr isEqualToString:URL_LIFTSTATE] || [_tempStr isEqualToString:URL_VALIDUSERCODE] || [_tempStr isEqualToString:URL_REGISTERUSER]){
                [self errerAlertUserStatus:dict];
                if (self.failure) {
                    self.failure(dict);
                }
            }
//            else if ( [_tempStr isEqualToString:URL_GENPUBLICKEY]){
//
//                [self errerAlertUserStatus:dict];
//
//                if (self.failure) {
//                    self.failure(dict);
//                }
//
//            }else if ([_tempStr isEqualToString:URL_FINDROLE]){
//                [self errerAlertUserStatus:dict];
//
//                if (self.failure) {
//                    self.failure(dict);
//                }
//            }
        else if ([_tempStr isEqualToString:URL_USERINFO] || [_tempStr isEqualToString:URL_LOADMAILLIST] ){
//                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//                [user removeObjectForKey:@"OAUSERMODEL"];
//                [user removeObjectForKey:@"AES"];
//                [user synchronize];
//                AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//                RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//                appdelegate.window.rootViewController = loginVc;
                [self errerAlertUserStatus:dict];
            }
        }
    }
}

//结束解析
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
}

//错误提醒的分类
- (void)errerAlertUserStatus:(NSDictionary *)dict{
   // [SVProgressHUD dismiss];
    /**
     // 正常状态
     public static final int RET_STATUS_NORMAL = 0 ;
     // 参数错误
     public static final int RET_STATUS_PARAERR = -2 ;
     // 系统错误
     public static final int RET_STATUS_SYSTEMERR = -1 ;
     // 接口不存在
     public static final int RET_STATUS_NOTFOUND = -3 ;
     // 普通错误 (此错误 前端直接根据  message 提示即可)
     public static final int RET_STATUS_COMMONERR = -4 ;
     // 未登录
     public static final int RET_STATUS_UNLOGIN = -5 ;
     // 未知错误
     public static final int RET_STATUS_UNKNOWN = -999 ;
    */
    jxt_dismissHUD();
    NSInteger status = [dict[@"status"] integerValue];
    if (status == -2) {
       // [SVProgressHUD showErrorWithStatus:@"参数错误"];
        jxt_showToastMessage(@"参数错误", 0.75);
    }else if (status == -1){
        //[SVProgressHUD showErrorWithStatus:@"系统错误"];
        jxt_showToastMessage(@"系统错误", 0.75);
    }else if (status == -3){
        //[SVProgressHUD showErrorWithStatus:@"接口不存在"];
         jxt_showToastMessage(@"接口不存在", 0.75);
    }else if (status == -4){
        // [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",dict[@"message"]]];
        //jxt_showAlertMessage([NSString stringWithFormat:@"%@",dict[@"message"]]);
        jxt_showToastMessage([NSString stringWithFormat:@"%@",dict[@"message"]], 0.75);
    }else if (status == -5){
        [self userloginOut];
//        [SVProgressHUD showErrorWithStatus:@"登录已失效"];
//        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//        [user removeObjectForKey:@"OAUSERMODEL"];
//        [user removeObjectForKey:@"AES"];
//        [user synchronize];
//        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        appdelegate.window.rootViewController = loginVc;
    }else if (status == -999){
        [SVProgressHUD showErrorWithStatus:@"未知错误"];
    }
}

//解密的方法
- (NSDictionary *)decryptMethodWithDictionary:(NSDictionary *)dict{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString * const kInitVector = @"16-Bytes--String";
    NSString * data1 = [NSString stringWithFormat:@"%@",dict[@"data"]];
    NSString * userData = [FSAES128 decryptAES:data1 key:aes andKInItVector:kInitVector];
    if ([userData length] < 1) {
        [self userloginOut];
//        [SVProgressHUD showErrorWithStatus:@"登录失效"];
//        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//        [user removeObjectForKey:@"OAUSERMODEL"];
//        [user removeObjectForKey:@"AES"];
//        [user synchronize];
//        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
//        appdelegate.window.rootViewController = loginVc;
        return nil;
    }else{
        NSData *jsonData = [userData dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
         return dic;
    }
}

- (void)userloginOut{
    [JXTAlertView showToastViewWithTitle:@"登录已失效"
                                 message:@"你的账号在其他手机上面登录"
                                duration:2
                       dismissCompletion:^(NSInteger buttonIndex) {
                           //NSLog(@"关闭");
                           NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                           NSData * data = [user objectForKey:@"OAUSERMODEL"];
                           RSUserModel * usermodel  = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                           [MiPushSDK unsetAccount:[NSString stringWithFormat:@"%ld",(long)usermodel.userId]];
                           [user removeObjectForKey:@"OAUSERMODEL"];
                           [user removeObjectForKey:@"AES"];
                           [user synchronize];
                           AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        
               RSMyNavigationViewController * mayNa = [[RSMyNavigationViewController alloc]initWithRootViewController:loginVc];
                           appdelegate.window.rootViewController = mayNa;
                }];
}

//字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        //NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}




@end
