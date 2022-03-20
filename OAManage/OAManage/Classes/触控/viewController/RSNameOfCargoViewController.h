//
//  RSNameOfCargoViewController.h
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBaseViewController.h"
#import "RSShipperMode.h"
#import "RSWarehouseModel.h"
#import "RSStoreAreaModel.h"
#import "RSFeeModel.h"
NS_ASSUME_NONNULL_BEGIN


typedef void(^Block)(RSShipperMode * shippermodel,NSString * type);

typedef void(^WarehouseBlock)(RSWarehouseModel * warehousemodel,NSString * type);

typedef void(^StoreAreaBlock)(RSStoreAreaModel * storeAreamodel,NSString * type);

typedef void(^FeeBlock)(RSFeeModel * feemodel,NSString * type);

@interface RSNameOfCargoViewController : RSBaseViewController

//huangliao 为荒料 daban 为大板
@property (nonatomic,strong)NSString * selectType;


@property (nonatomic,strong)Block block;


@property (nonatomic,strong)WarehouseBlock warehouseblock;

@property (nonatomic,strong)StoreAreaBlock storeAreablock;

@property (nonatomic,strong)RSWarehouseModel * warehousemodel;

@property (nonatomic,strong)FeeBlock feeblock;

//dealer货主  warehouse仓库 storeArea 库存 fee 费用
@property (nonatomic,strong)NSString * type;


@end

NS_ASSUME_NONNULL_END
