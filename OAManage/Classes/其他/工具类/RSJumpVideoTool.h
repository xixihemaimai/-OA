//
//  RSJumpVideoTool.h
//  OAManage
//
//  Created by mac on 2020/3/19.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSOnlineModel.h"
#import "RSOnlineVideoPlayViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSJumpVideoTool : NSObject
+ (void)canYouSkipThePlaybackVideoInterfaceMoment:(RSOnlineModel *)onlinemodel andViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
