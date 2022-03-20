//
//  RSStockViewController.h
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBaseViewController.h"

#import "RSShipperMode.h"
#import "RSWarehouseModel.h"
#import "RSStoreAreaModel.h"
NS_ASSUME_NONNULL_BEGIN



@protocol RSStockViewControllerDelegate <NSObject>

//荒料
- (void)huangliaoSelectContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray;;

//大板
- (void)dabanChoosingContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray;

@end



@interface RSStockViewController : RSBaseViewController


//货主ID的模型
@property (nonatomic,strong)RSShipperMode * shippermodel;
//仓库
@property (nonatomic,strong)RSWarehouseModel * warehousemodel;
//库区
@property (nonatomic,strong)RSStoreAreaModel * storeAreamodel;


//这个是上个页面传递过来的数组，用来存储上个页面选中的数组------荒料
@property (nonatomic,strong)NSMutableArray * selectionArray;

//选择的cell的数组 --------------大板
@property (nonatomic,strong)NSMutableArray * selectdeContentArray;


//huangliao 为荒料 daban 为大板
@property (nonatomic,strong)NSString * selectType;

@property (nonatomic,weak)id<RSStockViewControllerDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
