//
//  RSRoleModel.m
//  OAManage
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSRoleModel.h"

@implementation RSRoleModel

//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{
//             @"roleID" : @"id"
//             };
//}



+ (NSDictionary * )mj_replacedKeyFromPropertyName
{
    return @{
        @"roleID" : @"id"
        };
}


@end
