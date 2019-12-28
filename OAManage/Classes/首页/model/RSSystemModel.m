//
//  RSSystemModel.m
//  OAManage
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSystemModel.h"

@implementation RSSystemModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"systemId" : @"id"
             };
}
@end
