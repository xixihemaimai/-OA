//
//  RSPopViewController.h
//  OAManage
//
//  Created by mac on 2020/9/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSPopViewController : UIViewController

- (instancetype)initwithContentObjectLabel:(NSString *)objectLabel andNumberLabel:(NSString *)numberLabel andPayServiceArray:(NSArray *)payService andPayNumberArray:(NSArray *)payNumber;


@end

NS_ASSUME_NONNULL_END
