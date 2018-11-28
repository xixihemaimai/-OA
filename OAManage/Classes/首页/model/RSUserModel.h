//
//  RSUserModel.h
//  OAManage
//
//  Created by mac on 2018/11/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSUserModel : NSObject<NSCopying>

/**
aesKey AES2的值
userId  用户ID
userName 用户名称
userCode 用户代码
appLoginToken 登录标识(相当于之前的LoginKey)
deptName 部门名称
sex 性别
*/
@property (nonatomic,strong)NSString * userId;

@property (nonatomic,strong)NSString * userName;

@property (nonatomic,strong)NSString * userCode;

@property (nonatomic,strong)NSString * appLoginToken;

@property (nonatomic,strong)NSString * deptName;

@property (nonatomic,strong)NSString * sex;

@property (nonatomic,strong)NSString * aesKey;

@end

NS_ASSUME_NONNULL_END
