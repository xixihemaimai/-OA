//
//  RSContractCell.m
//  OAManage
//
//  Created by mac on 2020/9/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSContractCell.h"

@interface RSContractCell ()

@property (nonatomic,strong)UIImageView * statusImage;

@property (nonatomic,strong)UILabel * numberLabel;

@property (nonatomic,strong)UILabel * titleLabel;

@property (nonatomic,strong)UILabel * timeLabel;

@property (nonatomic,strong)UILabel * statusLabel;

@end


@implementation RSContractCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView * statusView = [[UIView alloc]init];
        statusView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        [self.contentView addSubview:statusView];
        
        
        UIImageView * statusImage = [[UIImageView alloc]init];
        statusImage.image = [UIImage imageNamed:@"编组2"];
        [statusView addSubview:statusImage];
        _statusImage = statusImage;
        
        UILabel * numberLabel = [[UILabel alloc]init];
        numberLabel.text = @"合同编号:CGRK201901070001";
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.font = [UIFont systemFontOfSize:16];
        numberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [statusView addSubview:numberLabel];
        _numberLabel = numberLabel;
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"合同标题:厦门开尔新有限公司地摊";
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [statusView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"合同日期:2019-09-18";
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont systemFontOfSize:15];
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [statusView addSubview:timeLabel];
        _timeLabel = timeLabel;
        
        UILabel * statusLabel = [[UILabel alloc]init];
        statusLabel.text = @"审核中";
        statusLabel.font = [UIFont systemFontOfSize:12];
        statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
        statusLabel.textAlignment = NSTextAlignmentRight;
        [statusView addSubview:statusLabel];
        _statusLabel = statusLabel;
        
        statusView.frame = CGRectMake(12, 5, SCW - 24, 102);
        
//        statusView.sd_layout
//        .leftSpaceToView(self.contentView, 12)
//        .rightSpaceToView(self.contentView, 12)
//        .topSpaceToView(self.contentView, 5)
//        .bottomSpaceToView(self.contentView, 5);
        
        statusView.layer.cornerRadius = 6;
        statusView.layer.masksToBounds = YES;
        
//        statusImage.sd_layout
//        .leftSpaceToView(statusView, 14.5)
//        .topSpaceToView(statusView, 16)
//        .widthIs(32)
//        .heightEqualToWidth();
        
        statusImage.frame = CGRectMake( 14.5, 16, 32, 32);
        
        
//        numberLabel.sd_layout
//        .leftSpaceToView(statusImage, 9)
//        .topSpaceToView(statusView, 12)
//        .rightSpaceToView(statusView, 12)
//        .heightIs(22.5);
        
        
        numberLabel.frame = CGRectMake(CGRectGetMaxX(statusImage.frame) + 9, 12, SCW - 48, 22.5);
        
//        titleLabel.sd_layout
//        .leftEqualToView(numberLabel)
//        .rightEqualToView(numberLabel)
//        .topSpaceToView(numberLabel, 0)
//        .heightIs(22.5);
        
        titleLabel.frame = CGRectMake(CGRectGetMaxX(statusImage.frame) + 9, CGRectGetMaxY(numberLabel.frame), SCW - 48 - 12, 22.5);
        
//        timeLabel.sd_layout
//        .leftEqualToView(titleLabel)
//        .topSpaceToView(titleLabel, 0)
//        .rightSpaceToView(statusView, 0.5)
//        .heightIs(22.5);
        
        timeLabel.frame = CGRectMake(CGRectGetMaxX(statusImage.frame) + 9, CGRectGetMaxY(titleLabel.frame), statusView.yj_width * 0.5, 22.5);
        
//        statusLabel.sd_layout
//        .rightSpaceToView(statusView, 13)
//        .bottomSpaceToView(statusView, 18)
//        .heightIs(16.5)
//        .widthIs(50);
        statusLabel.frame = CGRectMake(SCW - 24 - 13 - 50, 102 - 18, 50, 16.5);
        
    }
    return self;
}

- (void)setColumnarmodel:(RSColumnarModel *)columnarmodel{
    _columnarmodel = columnarmodel;
    //0 未提交  2 审核中  10 已生效  12 已过期）
    
    if (_columnarmodel.status == 2) {
        _statusImage.image = [UIImage imageNamed:@"编组2"];
        _statusLabel.text = @"审核中";
        _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
    }else if (_columnarmodel.status == 10){
        _statusImage.image = [UIImage imageNamed:@"已入库"];
        _statusLabel.text = @"已生效";
        _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        
    }else if (_columnarmodel.status == 12){
        _statusImage.image = [UIImage imageNamed:@"已过期"];
        _statusLabel.text = @"已过期";
        _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#F15244"];
    }else{
        _statusImage.image = [UIImage imageNamed:@"编组2"];
        _statusLabel.text = @"未提交";
        _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
    }
    _numberLabel.text = [NSString stringWithFormat:@"合同编号:%@",_columnarmodel.no];
    _titleLabel.text = [NSString stringWithFormat:@"合同标题:%@",_columnarmodel.billTitle];
    _timeLabel.text = [NSString stringWithFormat:@"合同日期:%@",_columnarmodel.billDate];
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
