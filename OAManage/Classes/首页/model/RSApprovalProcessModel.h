//
//  RSApprovalProcessModel.h
//  OAManage
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSApprovalProcessModel : NSObject

/**
 
 createTime = "2018-11-26 15:51:54 ";
 finishTime = "2018-11-26 15:51:54";
 resultInfo = "\U901a\U8fc7";
 userInfo = "";
 userName = "\U8bb8\U6cfd\U715c";
 userPhone = "";
 workItemId = 239508;
 workItemName = "\U5f00\U59cb\U8282\U70b9";
 */

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * finishTime;

@property (nonatomic,strong)NSString * resultInfo;

@property (nonatomic,strong)NSString * userInfo;

@property (nonatomic,strong)NSString * userName;

@property (nonatomic,strong)NSString * userPhone;

@property (nonatomic,assign)NSInteger  workItemId;

@property (nonatomic,strong)NSString * workItemName;



@end

NS_ASSUME_NONNULL_END
