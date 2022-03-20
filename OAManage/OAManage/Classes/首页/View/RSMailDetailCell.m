//
//  RSMailDetailCell.m
//  OAManage
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSMailDetailCell.h"

@implementation RSMailDetailCell

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

       
       UILabel * phoneNameLabel = [[UILabel alloc]init];
       phoneNameLabel.text = @"电话1";
       phoneNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
       phoneNameLabel.textAlignment = NSTextAlignmentLeft;
       phoneNameLabel.font = [UIFont systemFontOfSize:16];
       [self.contentView addSubview:phoneNameLabel];
       _phoneNameLabel = phoneNameLabel;
       
       UILabel * phoneLabel = [[UILabel alloc]init];
       phoneLabel.text = @"18899996666";
       phoneLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
       phoneLabel.textAlignment = NSTextAlignmentLeft;
       phoneLabel.font = [UIFont systemFontOfSize:18];
       [self.contentView addSubview:phoneLabel];
       _phoneLabel = phoneLabel;
       
       UIButton * playPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       [playPhoneBtn setImage:[UIImage imageNamed:@"电话"] forState:UIControlStateNormal];
       [self.contentView addSubview:playPhoneBtn];
       _playPhoneBtn = playPhoneBtn;
       
       
       playPhoneBtn.frame = CGRectMake(self.contentView.yj_width - 16, 60/2 - 16, 32, 32);
//       playPhoneBtn.sd_layout
//       .rightSpaceToView(self.contentView, 15)
//       .centerYEqualToView(self.contentView)
//       .widthIs(32)
//       .heightEqualToWidth();
       
       phoneNameLabel.frame = CGRectMake(15, 7.5, self.contentView.yj_width - 15 - 15, 22.5);
//       phoneNameLabel.sd_layout
//       .leftSpaceToView(self.contentView, 15)
//       .topSpaceToView(self.contentView, 7.5)
//       .heightIs(22.5)
//       .rightSpaceToView(playPhoneBtn, 15);
       
       phoneLabel.frame = CGRectMake(15, CGRectGetMaxY(phoneNameLabel.frame) + 0.5, self.contentView.yj_width - 15 - 15, 25);
//       phoneLabel.sd_layout
//       .leftEqualToView(phoneNameLabel)
//       .rightEqualToView(phoneNameLabel)
//       .topSpaceToView(phoneNameLabel, 0.5)
//       .bottomSpaceToView(self.contentView, 7.5);
       
       
       
   }
    return self;
}

@end
