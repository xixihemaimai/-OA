//
//  RSNewAuditedCell.h
//  OAManage
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSNewAuditedModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSNewAuditedCell : UITableViewCell


@property (nonatomic,strong)RSNewAuditedModel * auditedmodel;


@property (nonatomic,strong)UIButton * deleteBtn;


@property (nonatomic,strong)UIButton * editBtn;

@end

NS_ASSUME_NONNULL_END
