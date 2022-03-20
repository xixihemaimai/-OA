//
//  RSAuditedModel.h
//  OAManage
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSAuditedModel : NSObject

@property (nonatomic,assign)double amount;

@property (nonatomic,assign)NSInteger  billId;

@property (nonatomic,strong)NSString * billKey;

@property (nonatomic,strong)NSString * billName;

@property (nonatomic,strong)NSString * createtime;

@property (nonatomic,strong)NSString * creatorName;

@property (nonatomic,strong)NSString * deptName;

@property (nonatomic,strong)NSString * lastTime;

@property (nonatomic,strong)NSString * makedate;

@property (nonatomic,assign)NSInteger pagerank;

@property (nonatomic,strong)NSString * workFlowType;


@property (nonatomic,assign)NSInteger workItemId;

@property (nonatomic,strong)NSString * workitemname;
@end

NS_ASSUME_NONNULL_END
