//
//  RSInformationModel.m
//  OAManage
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSInformationModel.h"

@implementation RSInformationModel
//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{
//             @"informationId" : @"id"
//             };
//}

+ (NSDictionary * )mj_replacedKeyFromPropertyName
{
    return @{
        @"informationId" : @"id"
        };
}

@end
