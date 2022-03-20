//
//  RSNoticeMoreViewController.h
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReloadUnreadNumber)(void);

@interface RSNoticeMoreViewController : RSBaseViewController

@property (nonatomic,copy)ReloadUnreadNumber reReloadUnreadNumber;

@end

NS_ASSUME_NONNULL_END
