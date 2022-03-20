//
//  RSNameOfCargoCell.h
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSShipperMode.h"
#import "RSWarehouseModel.h"
#import "RSStoreAreaModel.h"
#import "RSFeeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSNameOfCargoCell : UITableViewCell

@property (nonatomic,strong)RSShipperMode * shippermodel;

@property (nonatomic,strong)RSWarehouseModel * warehousemodel;

@property (nonatomic,strong)RSStoreAreaModel * storeAreamodel;

@property (nonatomic,strong)RSFeeModel * feemodel;
@end

NS_ASSUME_NONNULL_END
