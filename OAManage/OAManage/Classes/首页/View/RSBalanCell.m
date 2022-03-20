//
//  RSBalanCell.m
//  OAManage
//
//  Created by mac on 2021/3/22.
//  Copyright © 2021 mac. All rights reserved.
//

#import "RSBalanCell.h"


@interface RSBalanCell()


@end


@implementation RSBalanCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //加工费`
        UILabel * machiningLabel = [[UILabel alloc]init];
        machiningLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        machiningLabel.font = [UIFont systemFontOfSize:16];
        _machiningLabel = machiningLabel;
        machiningLabel.numberOfLines = 0;
        machiningLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:machiningLabel];
        
        UILabel * machNumberLabel = [[UILabel alloc]init];
        _machNumberLabel = machNumberLabel;
        machNumberLabel.numberOfLines = 0;
        machNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        machNumberLabel.font = [UIFont systemFontOfSize:16];
        machNumberLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:machNumberLabel];
        
        
        machiningLabel.frame = CGRectMake(23.5, 40/2 - 22.5/2 , 150, 22.5);
        
        machNumberLabel.frame = CGRectMake(CGRectGetMaxX(machiningLabel.frame), 40/2 - 22.5/2, self.contentView.yj_width - CGRectGetMaxX(machiningLabel.frame), 22.5);
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
