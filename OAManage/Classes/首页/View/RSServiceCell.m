//
//  RSServiceCell.m
//  OAManage
//
//  Created by mac on 2019/11/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSServiceCell.h"

@implementation RSServiceCell

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
        
        UILabel * newLabel = [[UILabel alloc]init];
        newLabel.numberOfLines = 0;
        newLabel.font = [UIFont systemFontOfSize:12];
        newLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        newLabel.textAlignment = NSTextAlignmentLeft;
        newLabel.text = @"海西石材城由福建三叶集团重磅打造，地处世界石材加工中心--中国·水头，占地2000亩,海西石材城由福建三叶集团重磅打造，地处世界石材加工中心--中国·水头，占地2000亩,海西石材城由福建三叶集团重磅打造，地处世界石材加工中心--中国·水头，占地2000亩,海西石材城由福建三叶集团重磅打造，地处世界石材加工中心--中国·水头，占地2000亩,海西石材城由福建三叶集团重磅打造，地处世界石材加工中心--中国·水头，占地2000亩,";
        [self.contentView addSubview:newLabel];
        
        
        
        UIImageView * newImage = [[UIImageView alloc]init];
        newImage.image = [UIImage imageNamed:@"背景"];
        [self.contentView addSubview:newImage];
        
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:bottomview];
        
        
        newImage.sd_layout
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 8)
        .widthIs(65.5)
        .heightIs(50);
        newImage.layer.cornerRadius = 4.76;
        newImage.layer.masksToBounds = YES;
        
        
        
        
        
        newLabel.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topEqualToView(newImage)
        .rightSpaceToView(newImage, 6.5)
        .bottomSpaceToView(self.contentView, 8);
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(0.5);
        
        
        
    }
    return self;
}


@end
