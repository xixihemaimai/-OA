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
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
        //图片
        UIImageView * shenHeImageView = [[UIImageView alloc]init];
        shenHeImageView.image = [UIImage imageNamed:@"全部"];
        [self.contentView addSubview:shenHeImageView];
        _shenHeImageView = shenHeImageView;
        //文字
        UILabel * shenHeLabel = [[UILabel alloc]init];
        shenHeLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        shenHeLabel.numberOfLines = 0;
        shenHeLabel.textColor = [UIColor colorWithHexColorStr:@"#7D7D7D"];
        shenHeLabel.textAlignment = NSTextAlignmentCenter;
       
        [self.contentView addSubview:shenHeLabel];
        _shenHeLabel = shenHeLabel;
        
        
        shenHeImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 2)
        .widthIs(12)
        .heightEqualToWidth();
        
        
        shenHeLabel.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0);
        
        
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
