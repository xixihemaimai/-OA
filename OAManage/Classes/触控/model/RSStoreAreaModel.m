//
//  RSStoreAreaModel.m
//  OAManage
//
//  Created by mac on 2019/12/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSStoreAreaModel.h"

@implementation RSStoreAreaModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"storeAreaId" : @"id"
             };
}
@end
