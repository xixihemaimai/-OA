//
//  RSWKOAmanagerViewController.h
//  OAManage
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^updateView)(void);

@interface RSWKOAmanagerViewController : RSBaseViewController

@property (nonatomic,assign)NSInteger billId;

@property (nonatomic,strong)NSString * billKey;

@property (nonatomic,assign)NSInteger workItemId;

@property (nonatomic,strong)NSString * usertime;


@property (nonatomic,strong)NSString * creatorName;

@property (nonatomic,strong)NSString * deptName;


@property (nonatomic,strong)NSString * type;

@property (nonatomic,strong)NSString * URL;


@property (nonatomic,strong)NSString * Currenttitle;


@property (nonatomic,assign)CGFloat version;


@property (nonatomic,strong)NSString * isaddProcess;

@property (nonatomic,strong)NSString * isApproval;

//新增返回block
@property (nonatomic,copy)updateView UpdateView;


@end

NS_ASSUME_NONNULL_END
