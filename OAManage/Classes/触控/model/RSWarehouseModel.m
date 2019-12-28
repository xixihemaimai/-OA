//
//  RSWarehouseModel.m
//  OAManage
//
//  Created by mac on 2019/12/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSWarehouseModel.h"

@implementation RSWarehouseModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"warehouseId" : @"id"
             };
}
@end
