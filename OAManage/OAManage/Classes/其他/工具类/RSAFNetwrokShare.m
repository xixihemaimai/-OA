//
//  RSAFNetwrokShare.m
//  OAManage
//
//  Created by mac on 2021/4/13.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSAFNetwrokShare.h"

@implementation RSAFNetwrokShare



+ (instancetype) share{
    static RSAFNetwrokShare * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        _manager.manger = manager;
    });
    return _manager;
}

@end
