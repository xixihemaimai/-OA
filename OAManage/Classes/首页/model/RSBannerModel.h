//
//  RSBannerModel.h
//  OAManage
//
//  Created by mac on 2019/12/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSBannerModel : NSObject
//创建时间
@property (nonatomic,strong)NSString * createTime;
//创建用户
@property (nonatomic,assign)NSInteger createUser;
//ID
@property (nonatomic,assign)NSInteger bannerId;
//图片地址
@property (nonatomic,strong)NSString * imageUrl;
//地址
@property (nonatomic,strong)NSString * location;
//状态
@property (nonatomic,assign)NSInteger status;
//标题
@property (nonatomic,strong)NSString * title;
//更新时间
@property (nonatomic,strong)NSString * updateTime;
//updateUser
@property (nonatomic,strong)NSString * updateUser;
//网址
@property (nonatomic,strong)NSString * url;

@end

NS_ASSUME_NONNULL_END
