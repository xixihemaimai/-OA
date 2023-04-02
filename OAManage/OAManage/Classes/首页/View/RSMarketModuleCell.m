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
        
        
        mananView.frame = CGRectMake(12, 5, SCW - 24, 85);
        
        mananImage.frame = CGRectMake(15,85/2 - 16, 32, 32);
        
        mananLabel.frame = CGRectMake(CGRectGetMaxX(mananImage.frame) + 15, 20.5, 150, 24);
        
        functionLabel.frame = CGRectMake(CGRectGetMaxX(mananImage.frame) + 15, CGRectGetMaxY(mananLabel.frame), 150, 20);
        
        functionImage.frame = CGRectMake(mananView.yj_width - 12 - 21, 85/2 - 21/2, 21, 21);
        
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
