//
//  RSOnlineVideoPlayViewController.h
//  OAManage
//
//  Created by mac on 2020/3/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSBaseViewController.h"
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
#import "RSOnlineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSOnlineVideoPlayViewController : UIViewController

//@property (nonatomic,strong)NSString * URLStr;

//@property (nonatomic,strong)NSString * videoDescro;

@property (nonatomic,strong)RSOnlineModel * onlinemodel;

@property (nonatomic,strong)RSUserModel * usermodel;

@end

NS_ASSUME_NONNULL_END
