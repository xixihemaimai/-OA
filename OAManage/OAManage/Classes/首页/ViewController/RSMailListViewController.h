//
//  RSMailListViewController.h
//  OAManage
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSMailListViewController : RSBaseViewController

@property (nonatomic ,strong ) UIView *inputView; //左边输入视图

@property (nonatomic , strong) UITextField *nameTextField;//搜索框

@property (nonatomic , strong) UIImageView *imgSearch; //搜索图片

@end

NS_ASSUME_NONNULL_END
