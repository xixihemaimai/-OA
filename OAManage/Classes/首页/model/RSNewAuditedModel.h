//
//  RSNewAuditedModel.h
//  OAManage
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSNewAuditedModel : NSObject

/**
 createTime = "2019-12-18 19:22:59";
 createUser = 426250;
 diaryDate = "2019-01-01 00:00:00";
 id = 1;
 status = 1;
 summary = "\U5b66\U4f1a\U4e86\U5199\U597d\U591a\U597d\U591abug";
 updateTime = "2019-12-18 19:22:59";
 updateUser = 426250;
 */
@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,assign)NSInteger createUser;

@property (nonatomic,strong)NSString * diaryDate;

@property (nonatomic,assign)NSInteger auditedId;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSString * summary;

@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,assign)NSInteger updateUser;


@property (nonatomic,strong)NSString * userDept;

@property (nonatomic,strong)NSString * userJob;

@property (nonatomic,strong)NSString * userName;

@end

NS_ASSUME_NONNULL_END
