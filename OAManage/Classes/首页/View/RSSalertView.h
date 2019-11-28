//
//  RSSalertView.h
//  OAManage
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

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

-(void)showView;
-(void)closeView;



@end

NS_ASSUME_NONNULL_END
