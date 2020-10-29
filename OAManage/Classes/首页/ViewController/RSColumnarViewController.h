//
//  RSColumnarViewController.h
//  OAManage
//
//  Created by mac on 2020/9/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


typedef enum{
    //荒料出入库
    bmstock = 0,
    //大板出入库
    slstock = 1,
    //招商总账
    ledger = 2,
    //招商租赁
    lease = 3,
    //招商商户账单明细
    totalLedger = 4
}JoinType;

@interface RSColumnarViewController : RSBaseViewController

@property (nonatomic,assign)JoinType joinType;

@end

NS_ASSUME_NONNULL_END
