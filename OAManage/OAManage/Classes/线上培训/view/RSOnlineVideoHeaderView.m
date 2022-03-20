//
//  RSOnlineVideoHeaderView.m
//  OAManage
//
//  Created by mac on 2020/3/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSOnlineVideoHeaderView.h"



@implementation RSOnlineVideoHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
//        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        //简介
        UILabel * introductLabel = [[UILabel alloc]init];
        introductLabel.text = @"简介";
        introductLabel.textColor =[UIColor colorWithHexColorStr:@"#333333"];
        introductLabel.font = [UIFont systemFontOfSize:17];
        introductLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:introductLabel];
        
        
        
        //底线
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        [self.contentView addSubview:bottomView];
        
        
        //内容
        RSInformationLabel * showLabel = [[RSInformationLabel alloc]init];
        showLabel.numberOfLines = 0;
        showLabel.text = @"让你效率翻倍的计划-跳出定计划又做不完的死循环";
        showLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        showLabel.font = [UIFont systemFontOfSize:15];
        showLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:showLabel];
        _showLabel = showLabel;
        
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:midView];
        
        
        
        introductLabel.frame = CGRectMake(15.5, 12, SCW - 15.5 - 15.5, 24);
        
        introductLabel.sd_layout
        .leftSpaceToView(self.contentView, 15.5)
        .topSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 15.5)
        .heightIs(24);
        
        
//        bottomView.sd_layout
//        .leftEqualToView(introductLabel)
//        .widthIs(35)
//        .heightIs(3)
//        .topSpaceToView(introductLabel, 0);
        
       
        bottomView.frame = CGRectMake(15.5, CGRectGetMaxY(introductLabel.frame), 35, 3);
        bottomView.layer.cornerRadius = 1.5;
//        bottomView.layer.masksToBounds = YES;
        
        
//        showLabel.sd_layout
//        .leftEqualToView(introductLabel)
//        .rightEqualToView(introductLabel)
//        .topSpaceToView(bottomView, 6)
//        .heightIs(72);
        
        showLabel.frame = CGRectMake(15.5, CGRectGetMaxY(bottomView.frame) + 6, SCW - 15.5 - 15.5, 72);
        
//        midView.sd_layout
//        .leftSpaceToView(self.contentView, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .bottomSpaceToView(self.contentView, 0)
//        .heightIs(0.5);
        
        midView.frame = CGRectMake(0, self.contentView.yj_height - 0.5, SCW, 0.5);
        
    }
    return self;
}

@end
