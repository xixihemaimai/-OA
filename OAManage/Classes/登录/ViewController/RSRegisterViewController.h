//
//  RSRegisterViewController.h
//  OAManage
//
//  Created by mac on 2019/12/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSRegisterViewController : RSBaseViewController


@property (nonatomic,strong)void(^registeUser)(NSString * userCode);

@end

NS_ASSUME_NONNULL_END
