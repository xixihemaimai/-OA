//
//  RSProgressView.m
//  OAManage
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSProgressView.h"

@implementation RSProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //第一个原点
        UIView * firstView = [[UIView alloc]init];
        firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [self addSubview:firstView];
        _firstView = firstView;
        
        
        
        //第一个中间的view
        UIView * firstProgressView = [[UIView alloc]init];
        firstProgressView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [self addSubview:firstProgressView];
        
        
        //第一个label
        UILabel * firstLabel = [[UILabel alloc]init];
        firstLabel.text  = @"提出申请";
       // firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        firstLabel.textAlignment = NSTextAlignmentLeft;
        firstLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        [self addSubview:firstLabel];
        _firstLabel = firstLabel;
        
        
        //第二个原点
        UIView * secondView = [[UIView alloc]init];
       // secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        [self addSubview:secondView];
        _secondView = secondView;
        
        
        //第二个中间的view
        UIView * secondProgressView = [[UIView alloc]init];
        secondProgressView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [self addSubview:secondProgressView];
        
        
        
        //第二个label
        UILabel * secondLabel = [[UILabel alloc]init];
        secondLabel.text  = @"进行中";
        //secondLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        secondLabel.textAlignment = NSTextAlignmentCenter;
        secondLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        [self addSubview:secondLabel];
        _secondLabel = secondLabel;
        
        //第三个原点
        UIView * thirdView = [[UIView alloc]init];
       // thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [self addSubview:thirdView];
        _thirdView = thirdView;
        
        //第三个label
        UILabel * thirdLabel = [[UILabel alloc]init];
        thirdLabel.text  = @"审核结束";
       // thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        thirdLabel.textAlignment = NSTextAlignmentRight;
        thirdLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        [self addSubview:thirdLabel];
        _thirdLabel = thirdLabel;
        
        
        //底下view
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        [self addSubview:bottomview];
    
        
        [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.height.mas_equalTo(11);
            make.top.mas_equalTo(25);
        }];
        
        [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(secondView.mas_bottom).offset(11);
        }];
        
        
        
        [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(25);
            make.left.mas_equalTo(50);
            make.width.height.mas_equalTo(11);
        }];
        
        [firstProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(secondView);
            make.left.equalTo(firstView.mas_right);
            make.right.equalTo(secondView.mas_right);
            make.height.mas_equalTo(1);
        }];
        
        
        
        
        [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(firstView);
            make.top.equalTo(firstView.mas_bottom).offset(11);
        }];
        
        [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(secondProgressView);
//            make.left.equalTo(secondProgressView.mas_right);
            make.top.mas_equalTo(25);
            make.right.mas_equalTo(-50);
            make.width.height.mas_equalTo(11);
        }];
        
        
        [secondProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(secondView);
            make.left.equalTo(secondView.mas_right);
            make.right.equalTo(thirdView.mas_left);
            make.height.mas_equalTo(1);
        }];
        
        
        
        [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(thirdView.mas_bottom).offset(11);
            make.centerX.equalTo(thirdView);
        }];
        
        firstView.layer.cornerRadius = 11 * 0.5;
        firstView.layer.masksToBounds = YES;
        secondView.layer.cornerRadius = 11 * 0.5;
        secondView.layer.masksToBounds = YES;
        thirdView.layer.cornerRadius = 11 * 0.5;
        thirdView.layer.masksToBounds = YES;
        
        [bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(8);
        }];
    
    }
    return self;
}

@end
