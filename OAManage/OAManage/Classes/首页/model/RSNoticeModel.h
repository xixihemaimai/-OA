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
@property (nonatomic,copy)NSString * content;
//createTime 创建时间
@property (nonatomic,copy)NSString * createTime;
//创建用户
@property (nonatomic,assign)NSInteger createUser;
//id
@property (nonatomic,assign)NSInteger noticeId;
//noticeType
@property (nonatomic,copy)NSString * noticeType;
//发布时间
@property (nonatomic,copy)NSString * publishTime;
//发布者
@property (nonatomic,copy)NSString * publisher;
//状态
@property (nonatomic,assign)NSInteger status;
//标题
@property (nonatomic,copy)NSString * title;
//更新时间
@property (nonatomic,copy)NSString * updateTime;
//updateUser
@property (nonatomic,assign)NSInteger updateUser;
//网址
@property (nonatomic,copy)NSString * url;
//未读
@property (nonatomic,assign)NSInteger readState;

@end

NS_ASSUME_NONNULL_END
