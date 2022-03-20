//
//  RSBalanceViewController.h
//  OAManage
//
//  Created by mac on 2020/9/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    //获取园区费用应收余额列表
    market_fee = 1,
    //获取商户费用应收余额列表
    dealer_fee = 2,
    //获取商户费用应收明细
//    dealer_fee_dtl = 3,
    //获取园区收款明细列表
    pay_market_fee = 4,
    //获取园区应收明细列表
    market_fee_dtl = 5
    
}MarketPee;


@interface RSBalanceViewController : RSBaseViewController

@property (nonatomic,assign)MarketPee marketpee;

@end

NS_ASSUME_NONNULL_END
