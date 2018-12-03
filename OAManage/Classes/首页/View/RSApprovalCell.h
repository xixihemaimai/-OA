//
//  RSApprovalCell.h
//  OAManage
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSAuditedModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSApprovalCell : UITableViewCell

@property (nonatomic,strong)RSAuditedModel * auditemodel;


@property (nonatomic,strong)UIView * approvalBottomView;
@end

NS_ASSUME_NONNULL_END
