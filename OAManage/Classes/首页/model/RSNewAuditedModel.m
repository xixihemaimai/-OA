//
//  RSNewAuditedModel.m
//  OAManage
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSNewAuditedModel.h"

@implementation RSNewAuditedModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"auditedId" : @"id"
             };
}
@end
