//
//  RSHomeFristHeaderView.m
//  OAManage
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHomeFristHeaderView.h"

@implementation RSHomeFristHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        
        UIButton * homeFristBtn = [[UIButton alloc]init];
        [homeFristBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [self.contentView addSubview:homeFristBtn];
        _homeFristBtn = homeFristBtn;
        
        UILabel * homeFristHeaderLabel = [[UILabel alloc]init];
        homeFristHeaderLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        homeFristHeaderLabel.text = @"待审核";
        homeFristHeaderLabel.textAlignment = NSTextAlignmentLeft;
        homeFristHeaderLabel.font = [UIFont systemFontOfSize:Textadaptation(16)];
        [homeFristBtn addSubview:homeFristHeaderLabel];
        _homeFristHeaderLabel = homeFristHeaderLabel;
        
        //方向
        UIImageView * homeFristImageView = [[UIImageView alloc]init];
        homeFristImageView.image = [UIImage imageNamed:@"向右"];
        [homeFristBtn addSubview:homeFristImageView];
        _homeFristImageView = homeFristImageView;
        
        
        homeFristBtn.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        homeFristHeaderLabel.sd_layout
        .centerYEqualToView(homeFristBtn)
        .leftSpaceToView(homeFristBtn, 15)
        .widthRatioToView(homeFristBtn, 0.4)
        .topSpaceToView(homeFristBtn, 11)
        .bottomSpaceToView(homeFristBtn, 11);
        
        
        homeFristImageView.sd_layout
        .centerYEqualToView(homeFristBtn)
        .rightSpaceToView(homeFristBtn, 15)
        .widthIs(9)
        .heightIs(15);
        
        
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
