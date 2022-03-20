//
//  RSXNoticeCell.h
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSNoticeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSXNoticeCell : UITableViewCell

@property (nonatomic,strong)RSNoticeModel * noticemodel;

//提醒是否是未读的状态
@property (nonatomic,strong)UIView * redView;

@end

NS_ASSUME_NONNULL_END
