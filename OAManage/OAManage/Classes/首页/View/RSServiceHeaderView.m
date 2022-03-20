//
//  RSServiceHeaderView.m
//  OAManage
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSServiceHeaderView.h"

@implementation RSServiceHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        
        UIView * showView = [[UIView alloc]initWithFrame:CGRectMake(15, 30/2 - 7.5, 4, 15)];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        [self.contentView addSubview:showView];
        
        
        UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        moreBtn.frame = CGRectMake(SCW - 60, 7.5, 50, 20);
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [moreBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        [self.contentView addSubview:moreBtn];
        _moreBtn = moreBtn;
        
        
        UILabel * informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(showView.frame) + 5, 30/2 - 10.5, 200, 20)];
        informationLabel.text = @"热门资讯";
        informationLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        informationLabel.font = [UIFont systemFontOfSize:16];
        informationLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:informationLabel];
        
        
       
        
//        showView.sd_layout
//        .leftSpaceToView(self.contentView, 15)
//        .centerYEqualToView(self.contentView)
//        .heightIs(15)
//        .widthIs(4);
        
        showView.layer.cornerRadius = 3;
//        showView.layer.masksToBounds = YES;
        
        
//        moreBtn.sd_layout
//        .rightSpaceToView(self.contentView, 15)
//        .centerYEqualToView(self.contentView)
//        .heightIs(20)
//        .widthIs(50);
//
//
//
//        informationLabel.sd_layout
//        .centerYEqualToView(self.contentView)
//        .leftSpaceToView(showView, 5)
//        .rightSpaceToView(moreBtn, 10)
//        .heightIs(20);
        
        
        
        
    }
    return self;
}

@end
