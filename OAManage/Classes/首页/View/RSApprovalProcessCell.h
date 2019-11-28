//
//  RSApprovalProcessCell.h
//  OAManage
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSApprovalProcessSecondModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSApprovalProcessCell : UITableViewCell

@property (nonatomic,strong)RSApprovalProcessSecondModel * approvalProcessmodel;

@property (nonatomic,assign)CGFloat cellH;

@property (nonatomic,strong)UIButton * openBtn;

@end

NS_ASSUME_NONNULL_END
