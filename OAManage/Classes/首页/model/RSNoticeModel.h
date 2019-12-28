//
//  RSNoticeModel.h
//  OAManage
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSNoticeModel : NSObject
//内容
@property (nonatomic,strong)NSString * content;
//createTime 创建时间
@property (nonatomic,strong)NSString * createTime;
//创建用户
@property (nonatomic,assign)NSInteger createUser;
//id
@property (nonatomic,assign)NSInteger noticeId;
//noticeType
@property (nonatomic,strong)NSString * noticeType;
//发布时间
@property (nonatomic,strong)NSString * publishTime;
//发布者
@property (nonatomic,strong)NSString * publisher;
//状态
@property (nonatomic,assign)NSInteger status;
//标题
@property (nonatomic,strong)NSString * title;
//更新时间
@property (nonatomic,strong)NSString * updateTime;
//updateUser
@property (nonatomic,assign)NSInteger updateUser;
//网址
@property (nonatomic,strong)NSString * url;

@end

NS_ASSUME_NONNULL_END
