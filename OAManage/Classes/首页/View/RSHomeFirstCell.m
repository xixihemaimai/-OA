//
//  RSHomeFirstCell.m
//  OAManage
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHomeFirstCell.h"

@implementation RSHomeFirstCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        
        //视图
        UIView * homeFristView = [[UIView alloc]init];
        homeFristView.backgroundColor = [UIColor colorWithHexColorStr:@"#FEFDF1"];
        [self.contentView addSubview:homeFristView];
        _homeFristView = homeFristView;
        
        //图片
        UIImageView * homeFirstImageView = [[UIImageView alloc]init];
        homeFirstImageView.image = [UIImage imageNamed:@"公告"];
        homeFirstImageView.contentMode =  UIViewContentModeScaleAspectFill;
        [homeFristView addSubview:homeFirstImageView];
        
        
        //文字
        UILabel * homeFirstContentLabel = [[UILabel alloc]init];
        //homeFirstContentLabel.text = @"海西OA正式上线，敬请期待…";
        homeFirstContentLabel.textColor = [UIColor colorWithHexColorStr:@"#F89251"];
        homeFirstContentLabel.textAlignment = NSTextAlignmentLeft;
        homeFirstContentLabel.font = [UIFont systemFontOfSize:Textadaptation(14)];
        [homeFristView addSubview:homeFirstContentLabel];
        _homeFirstContentLabel = homeFirstContentLabel;
        
        //底部的横线
        UILabel * homeFirstTransverseLineLabel = [[UILabel alloc]init];
        homeFirstTransverseLineLabel.text = @"-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -";
        homeFirstTransverseLineLabel.textColor = [UIColor colorWithHexColorStr:@"#F89251"];
        homeFirstTransverseLineLabel.textAlignment = NSTextAlignmentLeft;
        homeFirstTransverseLineLabel.font = [UIFont systemFontOfSize:Textadaptation(5)];
        homeFirstTransverseLineLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FEFDF1"];
        [homeFristView addSubview:homeFirstTransverseLineLabel];
        _homeFirstTransverseLineLabel = homeFirstTransverseLineLabel;
        
        
        homeFristView.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        homeFirstImageView.sd_layout
        .leftSpaceToView(homeFristView, 11)
        .centerYEqualToView(homeFristView)
        .widthIs(18)
        .heightEqualToWidth();
        
        
        homeFirstContentLabel.sd_layout
        .leftSpaceToView(homeFirstImageView, 5)
        .rightSpaceToView(homeFristView, 0)
        .centerYEqualToView(homeFristView)
        .heightIs(20);
        
        homeFirstTransverseLineLabel.sd_layout
        .leftSpaceToView(homeFristView, 12)
        .rightSpaceToView(homeFristView, 12)
        .bottomSpaceToView(homeFristView, 0)
        .heightIs(4);
        
        
        
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
