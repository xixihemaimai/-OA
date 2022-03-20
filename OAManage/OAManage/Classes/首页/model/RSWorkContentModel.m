//
//  RSWorkContentModel.m
//  OAManage
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSWorkContentModel.h"

@implementation RSWorkContentModel

- (NSMutableArray *)inCompleteArray{
    if (!_inCompleteArray) {
        _inCompleteArray = [NSMutableArray array];
    }
    return _inCompleteArray;
}

- (NSMutableArray *)todayPlanArray{
    if (!_todayPlanArray) {
        _todayPlanArray = [NSMutableArray array];
    }
    return _todayPlanArray;
}

- (NSMutableArray *)tomorrowPlanArray{
    if (!_tomorrowPlanArray) {
        _tomorrowPlanArray = [NSMutableArray array];
    }
    return _tomorrowPlanArray;
}





//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{
//             @"workId" : @"id"
//             };
//}


+ (NSDictionary * )mj_replacedKeyFromPropertyName
{
    return @{
        @"workId" : @"id"
        };
}

@end
