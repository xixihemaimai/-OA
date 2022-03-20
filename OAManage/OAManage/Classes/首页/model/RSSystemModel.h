//
//  RSSystemModel.h
//  OAManage
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSystemModel : NSObject

/**
 createTime    string($date-time)
 createUser    integer($int32)
 fileName    string
 fileType    string
 id    integer($int32)
 status    integer($int32)
 updateTime    string($date-time)
 updateUser    integer($int32)
 url    string
 */

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,assign)NSInteger createUser;

@property (nonatomic,strong)NSString * fileName;

@property (nonatomic,strong)NSString * fileType;

@property (nonatomic,assign)NSInteger fileTypeId;

@property (nonatomic,assign)NSInteger systemId;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,assign)NSInteger updateUser;

@property (nonatomic,strong)NSString * url;

@end

NS_ASSUME_NONNULL_END
