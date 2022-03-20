//
//  RSOnlineModel.h
//  OAManage
//
//  Created by mac on 2020/3/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSOnlineModel : NSObject


@property (nonatomic,strong)NSString * coverUrl;

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * createUser;

@property (nonatomic,assign)NSInteger onlineId;

@property (nonatomic,assign)NSInteger status;
//@property (nonatomic,strong)NSString * infoType;

//@property (nonatomic,strong)NSString * location;

//@property (nonatomic,strong)NSString * noticeType;

@property (nonatomic,strong)NSString * publishTime;

@property (nonatomic,strong)NSString * publisher;

@property (nonatomic,strong)NSString * url;

@property (nonatomic,strong)NSString * videoDescribe;

@property (nonatomic,strong)NSString * videoFormat;

@property (nonatomic,strong)NSString * videoTitle;
@property (nonatomic,strong)NSString * videoType;
@property (nonatomic,assign)NSInteger  videoTypeId;

//@property (nonatomic,strong)NSString * updateTime;

//@property (nonatomic,strong)NSString * updateUser;



@end

NS_ASSUME_NONNULL_END
