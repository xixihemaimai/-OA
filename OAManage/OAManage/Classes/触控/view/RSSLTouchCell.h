//
//  RSSLTouchCell.h
//  OAManage
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LYFTableViewCellScrollAction)(void);
typedef void(^LYFTableViewCellDeleteAction)(NSIndexPath *indexPath);

NS_ASSUME_NONNULL_BEGIN

@interface RSSLTouchCell : UITableViewCell

//片号
@property (nonatomic, strong)UILabel * filmNumberLabel;

@property (nonatomic, strong)UILabel *longDetailLabel;
/// 删除事件
@property (nonatomic, copy) LYFTableViewCellDeleteAction deleteAction;
/// 滑动事件
@property (nonatomic, copy) LYFTableViewCellScrollAction scrollAction;
/// 滑动视图
@property (nonatomic, strong) UIScrollView *mainScrollView;
/// 组数行数
@property (nonatomic, strong) NSIndexPath *indexPath;
/// 打开状态
@property (nonatomic, assign) BOOL isOpen;



@end

NS_ASSUME_NONNULL_END
