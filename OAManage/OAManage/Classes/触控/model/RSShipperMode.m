//
//  RSShipperMode.m
//  OAManage
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSShipperMode.h"

@implementation RSShipperMode
//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{
//             @"shipperId" : @"id"
//             };
//}

+ (NSDictionary * )mj_replacedKeyFromPropertyName
{
    return @{
        @"shipperId" : @"id"
        };
}

@end
