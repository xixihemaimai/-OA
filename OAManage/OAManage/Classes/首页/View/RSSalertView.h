//
//  RSSalertView.h
//  OAManage
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol RSSalertViewDelegate <NSObject>

//确实，包括修改和添加
- (void)backSalertViewDataWithTitle:(NSString *)title andChoiceTitle:(NSString *)choiceTitle andSelect:(NSInteger)select andContentTextview:(NSString *)contentTextStr andResultTextview:(NSString *)resultTextStr andIndexpath:(NSIndexPath *)indexpath andAddType:(NSString *)addType;

//删除
- (void)deleteSalertViewContentIndexpath:(NSIndexPath *)indexpath andType:(NSString *)addType;


@end


@interface RSSalertView : UIView
/*选择的cell索引*/
@property (nonatomic,assign)NSInteger select;
//具体的步骤
@property (nonatomic,strong)UILabel * titleLabel;
//重要程度的选择
@property (nonatomic,strong)UIButton * choiceBtn;
//具体内容
@property (nonatomic,strong)UITextView * contentTextview;
//输出结果
@property (nonatomic,strong)UITextView * resultTextview;
//第几组第几行
@property (nonatomic,strong)NSIndexPath * indexpath;

//添加新的，还是修改 ,add添加，update(修改或者删除）
@property (nonatomic,strong)NSString * addType;

@property (nonatomic,weak)id<RSSalertViewDelegate>delegate;
-(void)showView;
-(void)closeView;



@end

NS_ASSUME_NONNULL_END
