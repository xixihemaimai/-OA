//
//  RSLoginOffView.h
//  OAManage
//
//  Created by 杨冰 on 2023/3/31.
//  Copyright © 2023 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSLoginOffView : UIView


@property (nonatomic,strong)void(^inputPassword)(NSString * password,BOOL isSure);
@end

NS_ASSUME_NONNULL_END
