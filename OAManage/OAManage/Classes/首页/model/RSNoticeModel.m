//
//  RSNoticeModel.m
//  OAManage
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSNoticeModel.h"

@implementation RSNoticeModel
//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{
//             @"noticeId" : @"id"
//             };
//}


+ (NSDictionary * )mj_replacedKeyFromPropertyName
{
    return @{
        @"noticeId" : @"id"
        };
}
@end
