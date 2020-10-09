//
//  RSMarketModuleCell.m
//  OAManage
//
//  Created by mac on 2020/9/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSMarketModuleCell.h"

@implementation RSMarketModuleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        UIView * mananView = [[UIView alloc]init];
        mananView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F9FB"];
        [self.contentView addSubview:mananView];
        
        UIImageView * mananImage = [[UIImageView alloc]init];
        mananImage.image = [UIImage imageNamed:@""];
        [mananView addSubview:mananImage];
        _mananImage = mananImage;
        
        UILabel * mananLabel = [[UILabel alloc]init];
        mananLabel.text = @"合同管理";
        mananLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        mananLabel.font = [UIFont systemFontOfSize:17];
        mananLabel.textAlignment = NSTextAlignmentLeft;
        [mananView addSubview:mananLabel];
        _mananLabel = mananLabel;
        
        UILabel * functionLabel = [[UILabel alloc]init];
        functionLabel.text = @"查询审核合同";
        functionLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        functionLabel.font = [UIFont systemFontOfSize:14];
        functionLabel.textAlignment = NSTextAlignmentLeft;
        [mananView addSubview:functionLabel];
        _functionLabel = functionLabel;
        
        UIImageView * functionImage = [[UIImageView alloc]init];
        functionImage.image = [UIImage imageNamed:@"下一层"];
        [mananView addSubview:functionImage];
        
        mananView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5);
        
        mananImage.sd_layout
        .centerYEqualToView(mananView)
        .leftSpaceToView(mananView, 15)
        .widthIs(32)
        .heightIs(32);
        
        mananLabel.sd_layout
        .leftSpaceToView(mananImage, 15)
        .topSpaceToView(mananView, 20.5)
        .heightIs(24)
        .widthIs(150);
        
        functionLabel.sd_layout
        .leftEqualToView(mananLabel)
        .rightEqualToView(mananLabel)
        .topSpaceToView(mananLabel, 0)
        .heightIs(20);
        
        functionImage.sd_layout
        .centerYEqualToView(mananView)
        .rightSpaceToView(mananView, 24.5)
        .widthIs(21)
        .heightEqualToWidth();
        
        
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
