//
//  RSBLTouchCell.h
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBMStockModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSBLTouchCell : UITableViewCell

@property (nonatomic,strong) UIButton * productDeleteBtn;

@property (nonatomic,strong)RSBMStockModel * bmstockmodel;

@end

NS_ASSUME_NONNULL_END
