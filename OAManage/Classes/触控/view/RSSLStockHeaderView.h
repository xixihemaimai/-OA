//
//  RSSLStockHeaderView.h
//  OAManage
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSlStockModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RSSLStockHeaderView : UITableViewHeaderFooterView


@property (nonatomic, strong) UITapGestureRecognizer * tap;


@property (nonatomic, strong)UIButton * selectBtn;


@property (nonatomic, strong)UIImageView * choosingDirectionImageView;

@property (nonatomic,strong)RSSlStockModel * slstockmodel;


@end

NS_ASSUME_NONNULL_END
