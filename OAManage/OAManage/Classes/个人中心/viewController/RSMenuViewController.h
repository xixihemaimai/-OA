//
//  RSMenuViewController.h
//  OAManage
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSMenuViewController;
@protocol RSMenuViewControllerDelegate <NSObject>


- (void)didTableViewIndexpath:(NSIndexPath *)indexpath andViewController:(RSMenuViewController *)menVc;

@end


@interface RSMenuViewController : RSBaseViewController



@property (nonatomic,weak)id<RSMenuViewControllerDelegate>delegate;

@end


