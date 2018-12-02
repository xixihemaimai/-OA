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
    manager.requestSerializer.timeoutInterval = 15;
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


//获取用户信息
- (void)reloadWebServiceNoDataURL:(NSString *)URLstr  andParameters:(NSString *)soapStr andURLName:(NSString *)urlName{
    _tempStr = urlName;
    URLstr = [URLstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    URLstr =  [URLstr stringByReplacingOccurrencesOfString:@"%20" withString:@""];
    [self reloadWebServiceNetDataUrl:URLstr andParameters:soapStr withBlock:^(id responseObject, BOOL success) {
        if (success) {
//            NSString *result = [[NSString alloc] initWithData:responseObject                            encoding:NSUTF8StringEncoding];
//            NSLog(@"=========%@",result);
            NSXMLParser * parser = [[NSXMLParser alloc]initWithData:responseObject];
            parser.delegate = self;
            [parser parse];
        }else{
            //URL_USERINFO URL_LOGIN
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
            }else {
               [SVProgressHUD showErrorWithStatus:@"获取失败"];
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
            }else if ([_tempStr isEqualToString:URL_NOTICE]){
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                NSMutableArray * array = [RSInformationModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
                if (self.successArrayReload) {
                    self.successArrayReload(array);
                }
            }else if ([_tempStr isEqualToString:URL_TOBEAUDIT]){
                NSDictionary * dic = [self decryptMethodWithDictionary:dict];
                NSMutableArray * array = [RSAuditedModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
                if (self.successArrayReload) {
                    self.successArrayReload(array);
                }
            }else if ([_tempStr isEqualToString:URL_FLOWLIST]){
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
                    [user removeObjectForKey:@"OAUSERMODEL"];
                    [user removeObjectForKey:@"AES"];
                    [user synchronize];
                    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                    RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
                    appdelegate.window.rootViewController = loginVc;
            }
        }else {
            if (  [_tempStr isEqualToString:URL_CHANGPWD] || [_tempStr isEqualToString:URL_NOTICE] || [_tempStr isEqualToString:URL_TOBEAUDIT] || [_tempStr isEqualToString:URL_FLOWLIST] || [_tempStr isEqualToString:URL_MYAUDIT] || [_tempStr isEqualToString:URL_AUDITFLOW] || [_tempStr isEqualToString:URL_LOGOUT]){
                [self errerAlertUserStatus:dict];
            }else if ([_tempStr isEqualToString:URL_LOGIN] ||[_tempStr isEqualToString:URL_GENPUBLICKEY] || [_tempStr isEqualToString:URL_FINDROLE]){
                
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
        else if ([_tempStr isEqualToString:URL_USERINFO]){
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
    
    [SVProgressHUD dismiss];
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
    NSInteger status = [dict[@"status"] integerValue];
    if (status == -2) {
        [SVProgressHUD showErrorWithStatus:@"参数错误"];
    }else if (status == -1){
        [SVProgressHUD showErrorWithStatus:@"系统错误"];
    }else if (status == -3){
        [SVProgressHUD showErrorWithStatus:@"接口不存在"];
    }else if (status == -4){
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",dict[@"message"]]];
    }else if (status == -5){
       // [SVProgressHUD showErrorWithStatus:@"未登录"];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user removeObjectForKey:@"OAUSERMODEL"];
        [user removeObjectForKey:@"AES"];
        [user synchronize];
        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        appdelegate.window.rootViewController = loginVc;
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
        [SVProgressHUD showErrorWithStatus:@"登录失效"];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user removeObjectForKey:@"OAUSERMODEL"];
        [user removeObjectForKey:@"AES"];
        [user synchronize];
        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        appdelegate.window.rootViewController = loginVc;
        return nil;

    }else{
        NSData *jsonData = [userData dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
         return dic;
    }
   
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
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}




@end
