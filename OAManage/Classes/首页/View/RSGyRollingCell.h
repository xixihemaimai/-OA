//
//  RSGyRollingCell.h
//  OAManage
//
//  Created by mac on 2019/11/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYNoticeViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSGyRollingCell : GYNoticeViewCell

@property (nonatomic,strong)UIImageView * tagImageView;

@property (nonatomic,strong)UILabel * titelLabel;

@property (nonatomic,strong)UIImageView * secondImageView;

@property (nonatomic,strong)UILabel * secondtitelLabel;

@end


NS_ASSUME_NONNULL_END
