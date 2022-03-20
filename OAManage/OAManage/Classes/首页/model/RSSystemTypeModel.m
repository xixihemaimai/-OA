//
//  RSSystemTypeModel.m
//  OAManage
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSystemTypeModel.h"

@implementation RSSystemTypeModel
//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{
//             @"systemtypeId" : @"id"
//             };
//}


+ (NSDictionary * )mj_replacedKeyFromPropertyName
{
    return @{
        @"systemtypeId" : @"id"
        };
}
@end
