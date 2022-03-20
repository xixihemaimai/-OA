//
//  RSFeeModel.m
//  OAManage
//
//  Created by mac on 2020/10/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSFeeModel.h"

@implementation RSFeeModel
//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{
//             @"feeId" : @"id"
//             };
//}

+ (NSDictionary * )mj_replacedKeyFromPropertyName
{
    return @{
        @"feeId" : @"id"
        };
}

@end
