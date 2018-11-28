//
//  RSHomeThirdCell.m
//  OAManage
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHomeThirdCell.h"

@interface RSHomeThirdCell()

    

@property (nonatomic,strong)UILabel * homeThirdNameLabel;

@property (nonatomic,strong)UILabel * homeThirdContentLabel;

@property (nonatomic,strong)UILabel * homeThirdTimeLabel;



@end


@implementation RSHomeThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        //中间的视图
        UIView * homeThirdCenterView = [[UIView alloc]init];
        homeThirdCenterView.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
        [self.contentView addSubview:homeThirdCenterView];

        //图片
        UIImageView * homeThirdImageView = [[UIImageView alloc]init];
        homeThirdImageView.contentMode =  UIViewContentModeScaleAspectFill;
        homeThirdImageView.image = [UIImage imageNamed:@"logo"];
        [homeThirdCenterView addSubview:homeThirdImageView];
        
        //名字
        UILabel * homeThirdNameLabel = [[UILabel alloc]init];
        homeThirdNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        homeThirdNameLabel.text = @"陈小编";
        homeThirdNameLabel.textAlignment = NSTextAlignmentLeft;
        homeThirdNameLabel.font = [UIFont systemFontOfSize:Textadaptation(14)];
        [homeThirdCenterView addSubview:homeThirdNameLabel];
        _homeThirdNameLabel = homeThirdNameLabel;
        
        //审批的内容
        UILabel * homeThirdContentLabel = [[UILabel alloc]init];
        homeThirdContentLabel.text = @"请假申请: 1.5天";
        homeThirdContentLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        homeThirdContentLabel.textAlignment = NSTextAlignmentLeft;
        homeThirdContentLabel.font = [UIFont systemFontOfSize:Textadaptation(16)];
        [homeThirdCenterView addSubview:homeThirdContentLabel];
        _homeThirdContentLabel = homeThirdContentLabel;
     
        
        //时间
        UILabel * homeThirdTimeLabel = [[UILabel alloc]init];
        homeThirdTimeLabel.text = @"10:40";
        homeThirdTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        homeThirdTimeLabel.textAlignment = NSTextAlignmentRight;
        homeThirdTimeLabel.font = [UIFont systemFontOfSize:Textadaptation(10)];
        [homeThirdCenterView addSubview:homeThirdTimeLabel];
        _homeThirdTimeLabel = homeThirdTimeLabel;
        
        
        homeThirdCenterView.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 7)
        .bottomSpaceToView(self.contentView, 7);
        
        
        homeThirdCenterView.layer.cornerRadius = 3;
        homeThirdCenterView.layer.masksToBounds = YES;
        
        homeThirdImageView.sd_layout
        .leftSpaceToView(homeThirdCenterView, 17)
        .topSpaceToView(homeThirdCenterView, 14)
        .widthIs(32)
        .heightEqualToWidth();
        
        homeThirdImageView.layer.cornerRadius = homeThirdImageView.yj_width * 0.5;
        homeThirdImageView.layer.masksToBounds = YES;
        
        homeThirdNameLabel.sd_layout
        .leftSpaceToView(homeThirdImageView, 11)
        .topSpaceToView(homeThirdCenterView, 16)
        .widthRatioToView(self.contentView, 0.5)
        .heightIs(20);
        
        
      
        
        
        if (IS_IPHONE) {
            homeThirdTimeLabel.sd_layout
            .rightSpaceToView(homeThirdCenterView, 16)
            .topSpaceToView(homeThirdCenterView, 16)
            .bottomEqualToView(homeThirdNameLabel)
            .widthRatioToView(self.contentView, 0.4);
            
            
        }else{
            homeThirdTimeLabel.sd_layout
            .rightSpaceToView(homeThirdCenterView, 16)
            .topSpaceToView(homeThirdCenterView, 26)
            .widthRatioToView(self.contentView, 0.4)
            .heightRatioToView(self.contentView, 0.3);
            
        }
        
        
        
        homeThirdContentLabel.sd_layout
        .leftEqualToView(homeThirdNameLabel)
        .rightSpaceToView(homeThirdCenterView, 12)
        .topSpaceToView(homeThirdNameLabel, 2)
        .bottomSpaceToView(homeThirdCenterView, 15);
        
    }
    return self;
}



- (void)setAuditedmodel:(RSAuditedModel *)auditedmodel{
    _auditedmodel = auditedmodel;
    if ([_auditedmodel.billKey isEqualToString:@"Flow_ApplyLeave"] || [_auditedmodel.billKey isEqualToString:@"Flow_RsApplyLeave"] || [_auditedmodel.billKey isEqualToString:@"Flow_BreakDown"] || [_auditedmodel.billKey isEqualToString:@"Flow_RsBreakDown"]) {
        _homeThirdContentLabel.text = [NSString stringWithFormat:@"%@:%0.1lf天",_auditedmodel.billName,_auditedmodel.amount];
    }else if ([_auditedmodel.billKey isEqualToString:@"Flow_Payment"]){
        _homeThirdContentLabel.text = [NSString stringWithFormat:@"%@:¥%0.2lf",_auditedmodel.billName,_auditedmodel.amount];
    }else{
          _homeThirdContentLabel.text = [NSString stringWithFormat:@"%@",_auditedmodel.billName];
    }
    _homeThirdNameLabel.text = [NSString stringWithFormat:@"%@",_auditedmodel.creatorName];
    _homeThirdTimeLabel.text = [NSString stringWithFormat:@"%@",_auditedmodel.createtime];
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
