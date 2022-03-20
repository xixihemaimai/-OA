//
//  RSApprovalProcessCell.h
//  OAManage
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSWorkTypeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSApprovalProcessCell : UITableViewCell


@property (nonatomic,strong)RSWorkTypeModel * workTypemodel;

@property (nonatomic,assign)CGFloat cellH;

@property (nonatomic,strong)UIButton * openBtn;

@property (nonatomic,strong)UILabel * concreteContentLabel;
@end

NS_ASSUME_NONNULL_END
