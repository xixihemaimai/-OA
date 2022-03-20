//
//  RSTouchAlertView.h
//  OAManage
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol RSTouchAlertViewDelegate <NSObject>

- (void)inputName:(NSString *)string andBlockName:(NSString *)blockName;

@end



@interface RSTouchAlertView : UIView

@property (nonatomic,weak)id<RSTouchAlertViewDelegate>delegate;


-(void)showView;
-(void)closeView;


@end

NS_ASSUME_NONNULL_END
