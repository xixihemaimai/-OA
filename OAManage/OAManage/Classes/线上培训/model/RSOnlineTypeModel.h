//
//  RSOnlineTypeModel.h
//  OAManage
//
//  Created by mac on 2020/3/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSOnlineTypeModel : NSObject

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * createUser;

@property (nonatomic,strong)NSString * name;

@property (nonatomic,assign)NSInteger onlineTypeId;

@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,strong)NSString * updateUser;
@end

NS_ASSUME_NONNULL_END
