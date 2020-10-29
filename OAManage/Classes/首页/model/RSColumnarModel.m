//
//  RSColumnarModel.m
//  OAManage
//
//  Created by mac on 2020/10/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSColumnarModel.h"

@implementation RSColumnarModel

//获取商户费用应收余额列表
-(NSDictionary *)getDicOfOB{
    return @{@"dealerName":_dealerName,@"moneyBegin":_moneyBegin,@"moneyIn":_moneyIn,@"moneyOut":_moneyOut,@"moneyEnd":_moneyEnd};
}


//获取园区费用应收余额列表
-(NSDictionary *)getParkDicOfOB{
    return @{@"feeName":_feeName,@"moneyBegin":_moneyBegin,@"moneyIn":_moneyIn,@"moneyOut":_moneyOut,@"moneyEnd":_moneyEnd};
}


//获取园区收款明细列表
-(NSDictionary *)getParkDicOfDetailedOB{
    return @{@"dealerName":_dealerName,@"feeName":_feeName,@"money":_money,@"month":_month,@"notes":_notes,@"payType":_payType};
}


//获取园区应收明细列表
-(NSDictionary *)getParkDicOfReceivableOB{
     return @{@"dealerName":_dealerName,@"feeName":_feeName,@"money":_money,@"month":_month};
}
@end
