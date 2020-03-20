//
//  RSOnlineModel.m
//  OAManage
//
//  Created by mac on 2020/3/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSOnlineModel.h"

@implementation RSOnlineModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"onlineId" : @"id"
             };
}
@end
