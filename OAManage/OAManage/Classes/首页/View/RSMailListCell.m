//
//  RSMailListCell.m
//  OAManage
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSMailListCell.h"

@implementation RSMailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        UIImageView * headerImage = [[UIImageView alloc]init];
        headerImage.image = [UIImage imageNamed:@"Group 2 Copy"];
        [self.contentView addSubview:headerImage];
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"名字";
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        
        UILabel * positionLabel = [[UILabel alloc]init];
        positionLabel.text = @"职位";
        positionLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        positionLabel.font = [UIFont systemFontOfSize:12];
        positionLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:positionLabel];
        _positionLabel = positionLabel;
        
        
        UIView * bottom = [[UIView alloc]init];
        bottom.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:bottom];
        
        headerImage.frame = CGRectMake(15, 8, 44, 44);
//        headerImage.sd_layout
//        .leftSpaceToView(self.contentView, 15)
//        .topSpaceToView(self.contentView, 8)
//        .bottomSpaceToView(self.contentView, 8)
//        .widthIs(44)
//        .heightEqualToWidth();
        
        nameLabel.frame = CGRectMake(CGRectGetMaxX(headerImage.frame) + 12, 8, self.contentView.yj_width - CGRectGetMaxX(headerImage.frame) - 12 - 15, 22.5);
//        nameLabel.sd_layout
//        .leftSpaceToView(headerImage, 12)
//        .topEqualToView(headerImage)
//        .rightSpaceToView(self.contentView, 15)
//        .heightIs(22.5);
        
//        positionLabel.sd_layout
//        .leftEqualToView(nameLabel)
//        .rightEqualToView(nameLabel)
//        .topSpaceToView(nameLabel, 0)
//        .bottomEqualToView(headerImage);
        positionLabel.frame = CGRectMake(CGRectGetMaxX(headerImage.frame) + 12, CGRectGetMaxY(nameLabel.frame), self.contentView.yj_width - CGRectGetMaxX(headerImage.frame) - 12 - 15, 25);
        
//        bottom.sd_layout
//        .leftSpaceToView(self.contentView, 15)
//        .rightSpaceToView(self.contentView, 15)
//        .bottomEqualToView(self.contentView)
//        .heightIs(0.5);
        
        bottom.frame = CGRectMake(15, 59.5, self.contentView.yj_width - 30, 0.5);
        
    }
    return self;
}


@end
