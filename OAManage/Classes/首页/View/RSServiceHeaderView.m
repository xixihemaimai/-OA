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
        
        
        
        UIView * showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        [self.contentView addSubview:showView];
        
        
        
        UILabel * informationLabel = [[UILabel alloc]init];
        informationLabel.text = @"热门资讯";
        informationLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        informationLabel.font = [UIFont systemFontOfSize:16];
        informationLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:informationLabel];
        
        
        UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [moreBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        [self.contentView addSubview:moreBtn];
        _moreBtn = moreBtn;
        
        showView.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .centerYEqualToView(self.contentView)
        .heightIs(15)
        .widthIs(4);
        
        showView.layer.cornerRadius = 3;
        showView.layer.masksToBounds = YES;
        
        
        moreBtn.sd_layout
        .rightSpaceToView(self.contentView, 15)
        .centerYEqualToView(self.contentView)
        .heightIs(20)
        .widthIs(50);
        
        
        
        informationLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(showView, 5)
        .rightSpaceToView(moreBtn, 10)
        .heightIs(20);
        
        
        
        
    }
    return self;
}

@end
