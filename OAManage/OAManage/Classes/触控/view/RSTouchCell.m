//
//  RSTouchCell.m
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTouchCell.h"


@interface RSTouchCell()

@property (nonatomic,strong)UIImageView * showImageView;
@property (nonatomic,strong)UILabel * showLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * productLabel;
@property (nonatomic,strong)UILabel * numberLabel;

@property (nonatomic,strong)UILabel * statusLabel;
@end


@implementation RSTouchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
         UIView * showView = [[UIView alloc]init];
                showView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
                [self.contentView addSubview:showView];
                
                //显示界面的内容
                UIImageView * showImageView = [[UIImageView alloc]init];
                showImageView.contentMode = UIViewContentModeScaleAspectFill;
                showImageView.clipsToBounds = YES;
                showImageView.image = [UIImage imageNamed:@"已入库"];
                [showView addSubview:showImageView];
                _showImageView = showImageView;
                //单号
                UILabel * showLabel = [[UILabel alloc]init];
                showLabel.text = @"单号：CGRK201901070001";
                showLabel.textAlignment = NSTextAlignmentLeft;
                showLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                UIFont * font = [UIFont fontWithName:@"PingFangSC" size:16];
                showLabel.font = font;
                [showView addSubview:showLabel];
                _showLabel = showLabel;
                //时间
                UILabel * timeLabel = [[UILabel alloc]init];
                timeLabel.text = @"2019/01/12";
                timeLabel.textAlignment = NSTextAlignmentRight;
                timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
                timeLabel.font = [UIFont systemFontOfSize:10];
                [showView addSubview:timeLabel];
                _timeLabel = timeLabel;
                //物料名称
                UILabel * productLabel = [[UILabel alloc]init];
                productLabel.text = @"货主名称：白小黑";
                productLabel.textAlignment = NSTextAlignmentLeft;
                productLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
                productLabel.font = [UIFont systemFontOfSize:15];
                [showView addSubview:productLabel];
                _productLabel = productLabel;
                //颗数
                UILabel * numberLabel = [[UILabel alloc]init];
                numberLabel.text = @"园区荒料号：EAB84789998";
                numberLabel.textAlignment = NSTextAlignmentLeft;
                numberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
                numberLabel.font = [UIFont systemFontOfSize:15];
                [showView addSubview:numberLabel];
                _numberLabel = numberLabel;
                //立方米
                UILabel * areaLabel = [[UILabel alloc]init];
                areaLabel.text = @"总体积：3.234m³";
                areaLabel.textAlignment = NSTextAlignmentLeft;
                areaLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
                areaLabel.font = [UIFont systemFontOfSize:15];
                [showView addSubview:areaLabel];
                _areaLabel = areaLabel;
                //状态
                UILabel * statusLabel = [[UILabel alloc]init];
                statusLabel.text = @"已入库";
                statusLabel.textAlignment = NSTextAlignmentRight;
                statusLabel.textColor = [UIColor colorWithHexColorStr:@"#26C589"];
                statusLabel.font = [UIFont systemFontOfSize:12];
                [showView addSubview:statusLabel];
                _statusLabel = statusLabel;
                
                
                //异常类型
//                UILabel * abnormalLabel = [[UILabel alloc]init];
//                abnormalLabel.text = @"异常类型:断裂处理";
//                abnormalLabel.textAlignment = NSTextAlignmentLeft;
//                abnormalLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
//                abnormalLabel.font = [UIFont systemFontOfSize:15];
//                [showView addSubview:abnormalLabel];
//                _abnormalLabel = abnormalLabel;
                
                //异常类型的详情值
        //        UILabel * abnormalDetailLabel = [[UILabel alloc]init];
        //        abnormalDetailLabel.text = @"断裂处理";
        //        abnormalDetailLabel.textAlignment = NSTextAlignmentLeft;
        //        abnormalDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        //        abnormalDetailLabel.font = [UIFont systemFontOfSize:15];
        //        [showView addSubview:abnormalDetailLabel];
                
        showView.frame = CGRectMake(12, 8, SCW - 24, 113);
                
//                showView.sd_layout
//                .leftSpaceToView(self.contentView, 12)
//                .rightSpaceToView(self.contentView, 12)
//                .topSpaceToView(self.contentView, 8)
//                .bottomSpaceToView(self.contentView, 0);
                showView.layer.cornerRadius = 6;
                
//                showImageView.sd_layout
//                .leftSpaceToView(showView, 15)
//                .topSpaceToView(showView, 16)
//                .widthIs(32)
//                .heightEqualToWidth();
        
        showImageView.frame = CGRectMake(15, CGRectGetMaxY(showView.frame) + 16, 32, 32);
                
//                showLabel.sd_layout
//                .topSpaceToView(showView, 12)
//                .leftSpaceToView(showImageView, 9)
//                .widthRatioToView(showView, 0.6)
//                .heightIs(23);
        showLabel.frame = CGRectMake(CGRectGetMaxX(showImageView.frame) + 9, CGRectGetMaxY(showView.frame) + 12, showView.yj_width * 0.6, 23);
                
                
//                timeLabel.sd_layout
//                .rightSpaceToView(showView, 14)
//                .topSpaceToView(showView, 19)
//                .heightIs(14)
//                .widthRatioToView(showView, 0.3);
        timeLabel.frame = CGRectMake(CGRectGetMaxX(showLabel.frame) + 5, CGRectGetMaxY(showView.frame) + 19, showView.yj_width * 0.2, 14);
                
                
//                productLabel.sd_layout
//                .leftEqualToView(showLabel)
//                .rightSpaceToView(showView, 12)
//                .topSpaceToView(showLabel, 3)
//                .heightIs(21);
        
        productLabel.frame = CGRectMake(CGRectGetMaxX(showImageView.frame) + 9, CGRectGetMaxY(showLabel.frame) + 3, showView.yj_width - CGRectGetMaxX(showImageView.frame) - 9 - 12, 21);
                
//                numberLabel.sd_layout
//                .leftEqualToView(productLabel)
//                .rightEqualToView(productLabel)
//                .topSpaceToView(productLabel, 3)
//                .heightIs(21);
        numberLabel.frame = CGRectMake(CGRectGetMaxX(showImageView.frame) + 9, CGRectGetMaxY(productLabel.frame) + 3, showView.yj_width - CGRectGetMaxX(showImageView.frame) - 9 - 12, 21);
                
//                areaLabel.sd_layout
//                .leftEqualToView(numberLabel)
//                .rightEqualToView(numberLabel)
//                .topSpaceToView(numberLabel, 3)
//                .heightIs(21);
        areaLabel.frame = CGRectMake(CGRectGetMaxX(showImageView.frame) + 9, CGRectGetMaxY(numberLabel.frame) + 3, showView.yj_width - CGRectGetMaxX(showImageView.frame) - 9 - 12, 21);
                
//                statusLabel.sd_layout
//                .rightSpaceToView(showView, 14)
//                .widthRatioToView(showView, 0.3)
//                .heightIs(14)
//                .bottomSpaceToView(showView, 13);
        statusLabel.frame = CGRectMake(showView.yj_width - 14 - showView.yj_width * 0.3, 113 - 13 - 14, showView.yj_width * 0.3, 14);
                
                
//                abnormalLabel.sd_layout
//                .leftEqualToView(areaLabel)
//                .rightEqualToView(areaLabel)
//                .topSpaceToView(areaLabel, 3)
//                .heightIs(21);
        
        
        
    }
    return self;
}

- (void)setTouchmodel:(RSTouchModel *)touchmodel{
    _touchmodel = touchmodel;
    if (_touchmodel.status == 10) {
        _showImageView.image = [UIImage imageNamed:@"已入库"];
        _statusLabel.text = @"已完成";
        _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#27c79a"];
    }else{
        
        _showImageView.image = [UIImage imageNamed:@"编组-1"];
        _statusLabel.text = @"待确认";
        _statusLabel.textColor = [UIColor colorWithHexColorStr:@"#fdad32"];
    }
    _showLabel.text = [NSString stringWithFormat:@"单号:%@",_touchmodel.no];
    _timeLabel.text = [NSString stringWithFormat:@"%@",_touchmodel.billDate];
    _productLabel.text = [NSString stringWithFormat:@"货主名称:%@",_touchmodel.deaName];
    _numberLabel.text = [NSString stringWithFormat:@"园区荒料号:%@",_touchmodel.msids];
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
