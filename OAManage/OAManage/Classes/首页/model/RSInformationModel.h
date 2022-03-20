//
//  RSInformationModel.h
//  OAManage
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSInformationModel : NSObject

/**
 内容    串
 createTime    字符串（$ date-time ）
 创建用户    整数（$ int32 ）
 ID    整数（$ int32 ）
 imageUrl    串
 infoType    串
 发布时间    字符串（$ date-time ）
 发布者    串
 状态    整数（$ int32 ）
 标题    串
 更新时间    字符串（$ date-time ）
 updateUser    整数（$ int32 ）
 网址    串
 */


@property (nonatomic,strong)NSString * content;

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,assign)NSInteger createUser;

@property (nonatomic,strong)NSString * informationId;

@property (nonatomic,strong)NSString * imageUrl;

@property (nonatomic,strong)NSString * infoType;

@property (nonatomic,strong)NSString * publishTime;

@property (nonatomic,strong)NSString * publisher;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSString * title;

@property (nonatomic,strong)NSString *  updateTime;

@property (nonatomic,assign)NSInteger updateUser;

@property (nonatomic,strong)NSString * url;



@end

NS_ASSUME_NONNULL_END
