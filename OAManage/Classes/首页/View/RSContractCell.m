//
//  RSContractCell.m
//  OAManage
//
//  Created by mac on 2020/9/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSContractCell.h"

@implementation RSContractCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView * statusView = [[UIView alloc]init];
        statusView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        [self.contentView addSubview:statusView];
        
        
        UIImageView * statusImage = [[UIImageView alloc]init];
        statusImage.image = [UIImage imageNamed:@"编组2"];
        [statusView addSubview:statusImage];
        
        
        UILabel * numberLabel = [[UILabel alloc]init];
        numberLabel.text = @"合同编号:CGRK201901070001";
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.font = [UIFont systemFontOfSize:16];
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [statusView addSubview:numberLabel];
        
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"合同标题:厦门开尔新有限公司地摊";
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [statusView addSubview:titleLabel];
        
        
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"合同日期:2019-09-18";
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont systemFontOfSize:15];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [statusView addSubview:timeLabel];
        
        
        UILabel * statusLabel = [[UILabel alloc]init];
        statusLabel.text = @"审核中";
        statusLabel.font = [UIFont systemFontOfSize:12];
        statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
        statusLabel.textAlignment = NSTextAlignmentRight;
        [statusView addSubview:statusLabel];
        
        
        statusView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 5)
        .bottomSpaceToView(self.contentView, 5);
        
        statusView.layer.cornerRadius = 6;
        statusView.layer.masksToBounds = YES;
        
        statusImage.sd_layout
        .leftSpaceToView(statusView, 14.5)
        .topSpaceToView(statusView, 16)
        .widthIs(32)
        .heightEqualToWidth();
        
        
        numberLabel.sd_layout
        .leftSpaceToView(statusImage, 9)
        .topSpaceToView(statusView, 12)
        .rightSpaceToView(statusView, 12)
        .heightIs(22.5);
        
        titleLabel.sd_layout
        .leftEqualToView(numberLabel)
        .rightEqualToView(numberLabel)
        .topSpaceToView(numberLabel, 0)
        .heightIs(22.5);
        timeLabel.sd_layout
        .leftEqualToView(titleLabel)
        .topSpaceToView(titleLabel, 0)
        .rightSpaceToView(statusView, 0.5)
        .heightIs(22.5);
        
        statusLabel.sd_layout
        .rightSpaceToView(statusView, 13)
        .bottomSpaceToView(statusView, 18)
        .heightIs(16.5)
        .widthIs(50);
        
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
