//
//  RSPersonSecondCell.m
//  石来石往
//
//  Created by mac on 2017/9/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSPersonSecondCell.h"

@implementation RSPersonSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:Textadaptation(15)];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        
        UILabel * phoneLabel = [[UILabel alloc]init];
        _phoneLabel = phoneLabel;
        phoneLabel.textAlignment = NSTextAlignmentRight;
        phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        phoneLabel.font = [UIFont systemFontOfSize:Textadaptation(15)];
        [self.contentView addSubview:phoneLabel];
        
        
        UIView * bottoview = [[UIView alloc]init];
        bottoview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottoview];
        nameLabel.frame = CGRectMake(12, 24 - 7.5, SCW * 0.4, 15);
        phoneLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 10, 12, SCW - CGRectGetMaxX(nameLabel.frame) - 10 - 32, 24);
        bottoview.frame = CGRectMake(0, 47, SCW, 1);
        
        
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
