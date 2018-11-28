//
//  RSUserModel.m
//  OAManage
//
//  Created by mac on 2018/11/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSUserModel.h"

@implementation RSUserModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    /**
     userId  用户ID
     userName 用户名称
     userCode 用户代码
     appLoginToken 登录标识(相当于之前的LoginKey)
     deptName 部门名称
     sex 性别
     */
    [aCoder encodeObject:self.userId forKey:@"userID"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userCode forKey:@"userCode"];
    [aCoder encodeObject:self.appLoginToken forKey:@"appLoginToken"];
    [aCoder encodeObject:self.deptName forKey:@"deptName"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.aesKey forKey:@"aesKey"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.userId= [aDecoder decodeObjectForKey:@"userID"];
        self.userCode = [aDecoder decodeObjectForKey:@"userCode"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.appLoginToken = [aDecoder decodeObjectForKey:@"appLoginToken"];
        self.deptName = [aDecoder decodeObjectForKey:@"deptName"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.aesKey = [aDecoder decodeObjectForKey:@"aesKey"];
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    RSUserModel * usermodel = [[self.class allocWithZone:zone] init];
    usermodel.userId = self.userId;
    usermodel.userCode = self.userCode;
    usermodel.userName = self.userName;
    usermodel.appLoginToken = self.appLoginToken;
    usermodel.deptName = self.deptName;
    usermodel.sex = self.sex;
    usermodel.aesKey = self.aesKey;
    return usermodel;
}

@end
