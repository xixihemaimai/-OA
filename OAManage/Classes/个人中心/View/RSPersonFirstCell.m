//
//  RSPersonFirstCell.m
//  石来石往
//
//  Created by mac on 2017/9/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSPersonFirstCell.h"

@implementation RSPersonFirstCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel * iconLabel = [[UILabel alloc]init];
        iconLabel.text = @"头像";
        iconLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        iconLabel.font = [UIFont systemFontOfSize:Textadaptation(15)];
        [self.contentView addSubview:iconLabel];
        
        
        
        UIImageView * headerview = [[UIImageView alloc]init];
        [self.contentView addSubview:headerview];
        
        
        
        UIImageView * rightImageView = [[UIImageView alloc]init];
        rightImageView.image = [UIImage imageNamed:@"向右"];
        [self.contentView addSubview:rightImageView];
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        

        
        _headerview = headerview;
        iconLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(15)
        .widthIs(80);
        
        headerview.sd_layout
        .centerYEqualToView(self.contentView)
        .heightIs(60)
        .widthIs(60)
        .rightSpaceToView(self.contentView, 32);
        
        headerview.layer.cornerRadius = headerview.yj_width * 0.5;
        headerview.layer.masksToBounds = YES;
        
        
        rightImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 13)
        .widthIs(9)
        .heightIs(15);
        
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
        
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
