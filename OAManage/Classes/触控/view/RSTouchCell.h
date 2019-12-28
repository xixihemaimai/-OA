//
//  RSTouchCell.h
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTouchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSTouchCell : UITableViewCell

@property (nonatomic,strong)RSTouchModel * touchmodel;

@property (nonatomic,strong)UILabel * areaLabel;

@end

NS_ASSUME_NONNULL_END
