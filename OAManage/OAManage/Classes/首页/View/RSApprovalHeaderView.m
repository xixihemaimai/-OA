//
//  RSApprovalHeaderView.m
//  OAManage
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSApprovalHeaderView.h"

@implementation RSApprovalHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"今日计划";
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"添加复制 10"] forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:addBtn];
        _addBtn = addBtn;
        
        
        addBtn.frame = CGRectMake(SCW - 50 - 15, 40/2 - 22.5/2, 50, 22.5);
        
//        addBtn.sd_layout
//        .centerYEqualToView(self.contentView)
//        .rightSpaceToView(self.contentView, 15)
//        .heightIs(22.5)
//        .widthIs(50);
        
        
        addBtn.imageView.sd_layout
        .heightIs(16)
        .widthEqualToHeight();
        
        
        addBtn.titleLabel.sd_layout
        .leftSpaceToView(addBtn.imageView, 4)
        .widthIs(40);
        

        
        

//        titleLabel.sd_layout
//        .centerYEqualToView(self.contentView)
//        .leftSpaceToView(self.contentView, 15)
//        .rightSpaceToView(addBtn, 15)
//        .heightIs(22.5);
//
        titleLabel.frame = CGRectMake(15, 40/2 - 22.5/2,SCW - CGRectGetMaxX(addBtn.frame) + 100, 22.5);
        
        
    }
    return self;
}



@end
