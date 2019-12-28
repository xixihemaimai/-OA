//
//  RSBLTouchViewController.h
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBaseViewController.h"

#import "RSShipperMode.h"
#import "RSWarehouseModel.h"
#import "RSStoreAreaModel.h"

#import "RSTouchModel.h"
NS_ASSUME_NONNULL_BEGIN



@interface RSBLTouchViewController : RSBaseViewController

//huangliao 为荒料 daban 为大板
@property (nonatomic,strong)NSString * selectType;
//是new还是上个页面cell带过来的new 新 reload 旧
@property (nonatomic,strong)NSString * showType;

@property (nonatomic,assign)NSInteger billId;

@property (nonatomic,strong)RSTouchModel * touchmodel;

@property (nonatomic,strong)void(^reload)(BOOL isreload);

@end

NS_ASSUME_NONNULL_END
