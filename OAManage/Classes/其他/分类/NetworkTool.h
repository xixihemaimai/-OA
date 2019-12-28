//
//  NetworkTool.h
//  WebServiceDemo
//
//  Created by mac on 2018/10/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "RSWorkContentModel.h"

typedef void(^AFNetworkingBlock)(id responseObject,BOOL success);
//解析完成之后的回调字典
typedef void(^SuccessReload)(NSDictionary * dict);
//这边是解析完成之后的回调数组
typedef void(^SuccessArrayReload)(NSMutableArray *array);
//获取工作日志的内容
typedef void(^WorkSuccess)(RSWorkContentModel *workContentmodel);
//删除工作日志的列表
typedef void(^DeleteSuccess)();



//上拉获取失败
//下拉获取失败
//失败
typedef void(^Failure)(NSDictionary * dict);

@interface NetworkTool : NSObject
{
    NSMutableString *currentElementValue;  //用于存储元素标签的值
    
    BOOL storingFlag; //查询标签所对应的元素是否存在
}


@property (nonatomic,strong)SuccessReload successReload;

@property (nonatomic,strong)Failure failure;

@property (nonatomic,strong)SuccessArrayReload successArrayReload;

@property (nonatomic,strong)WorkSuccess workSuccess;

@property (nonatomic,strong)DeleteSuccess deleteSuccess;


//网络请求
- (void)reloadWebServiceNetDataUrl:(NSString *)URLStr andParameters:(NSString *)soapStr withBlock:(AFNetworkingBlock)block;

//获取用户信息
- (void)reloadWebServiceNoDataURL:(NSString *)URLstr  andParameters:(NSString *)soapStr andURLName:(NSString *)urlName;


- (void)newReloadWebServiceNoDataURL:(NSString *)URLstr  andParameters:(NSDictionary *)soapStr andURLName:(NSString *)urlName;


//新的请求方式(新的请求方式)
- (void)newReloadWebServiceNetDataUrl:(NSString *)url withParameters:(NSDictionary *)parameters andURLName:(NSString *)urlName withBlock:(AFNetworkingBlock)block;


@end


