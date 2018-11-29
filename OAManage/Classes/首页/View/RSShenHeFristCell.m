//
//  RSShenHeFristCell.m
//  OAManage
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSShenHeFristCell.h"

@implementation RSShenHeFristCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       // self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
        //图片
        UIImageView * shenHeImageView = [[UIImageView alloc]init];
        shenHeImageView.image = [UIImage imageNamed:@"全部"];
        [self.contentView addSubview:shenHeImageView];
        _shenHeImageView = shenHeImageView;
        //文字
        UILabel * shenHeLabel = [[UILabel alloc]init];
        shenHeLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        shenHeLabel.numberOfLines = 0;        
        shenHeLabel.lineBreakMode = 1;
        shenHeLabel.backgroundColor = [UIColor clearColor];
        shenHeLabel.textColor = [UIColor colorWithHexColorStr:@"#7D7D7D"];
        shenHeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:shenHeLabel];
        _shenHeLabel = shenHeLabel;
        
        UILabel * countLabel = [[UILabel alloc]init];
        countLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF8C76"];
        countLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.font = [UIFont systemFontOfSize:Textadaptation(9)];
        countLabel.text = @"21";
        [self.contentView addSubview:countLabel];
        _countLabel = countLabel;
        
        
        shenHeImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 2)
        .widthIs(8)
        .heightEqualToWidth();
        
        
        shenHeLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 20);
        
        countLabel.sd_layout
        .leftSpaceToView(shenHeLabel, 0)
        .topSpaceToView(self.contentView, 10)
        .widthIs(12)
        .heightEqualToWidth();
        
        
        countLabel.layer.cornerRadius = countLabel.yj_width * 0.5;
        countLabel.layer.masksToBounds = YES;
        
        
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
