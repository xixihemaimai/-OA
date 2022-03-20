//
//  RSSLHeaderView.h
//  OAManage
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSLPieceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSLHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong)UIButton * downBtn;

@property (nonatomic,strong)UIButton * productDeleteBtn;

@property (nonatomic,strong)UIImageView * downImageView;

@property (nonatomic,strong)RSSLPieceModel * slpiecemodel;

@end

NS_ASSUME_NONNULL_END
