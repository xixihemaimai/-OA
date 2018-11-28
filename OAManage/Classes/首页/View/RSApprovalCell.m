//
//  RSApprovalCell.m
//  OAManage
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSApprovalCell.h"


@interface RSApprovalCell()

@property (nonatomic,strong)UILabel * approvalNameLabel;


@property (nonatomic,strong) UILabel * approvalDepartmentLabel;


@property (nonatomic,strong) UILabel * approvalContentLabel;

@property (nonatomic,strong) UILabel * approvalStatusLabel;

@property (nonatomic,strong)UILabel * approvalTimeLabel;
@end


@implementation RSApprovalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图片
        UIImageView * approvalImageView = [[UIImageView alloc]init];
        approvalImageView.contentMode =  UIViewContentModeScaleAspectFill;
        approvalImageView.image = [UIImage imageNamed:@"logo"];
        [self.contentView addSubview:approvalImageView];
        
        //名字
        UILabel * approvalNameLabel = [[UILabel alloc]init];
        approvalNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        approvalNameLabel.text = @"陈小编";
        approvalNameLabel.textAlignment = NSTextAlignmentLeft;
        approvalNameLabel.font = [UIFont systemFontOfSize:Textadaptation(14)];
        [self.contentView addSubview:approvalNameLabel];
        _approvalNameLabel = approvalNameLabel;
        
        //部门
        UILabel * approvalDepartmentLabel = [[UILabel alloc]init];
        approvalDepartmentLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        approvalDepartmentLabel.text = @"信息部";
        approvalDepartmentLabel.textAlignment = NSTextAlignmentRight;
        approvalDepartmentLabel.font = [UIFont systemFontOfSize:Textadaptation(10)];
        [self.contentView addSubview:approvalDepartmentLabel];
        _approvalDepartmentLabel = approvalDepartmentLabel;
        
        //审批的内容
        UILabel * approvalContentLabel = [[UILabel alloc]init];
        approvalContentLabel.text = @"请假申请: 1.5天";
        approvalContentLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        approvalContentLabel.textAlignment = NSTextAlignmentLeft;
        approvalContentLabel.font = [UIFont systemFontOfSize:Textadaptation(16)];
        [self.contentView addSubview:approvalContentLabel];
        _approvalContentLabel = approvalContentLabel;
        //审批的状态
        UILabel * approvalStatusLabel = [[UILabel alloc]init];
        approvalStatusLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        approvalStatusLabel.textAlignment = NSTextAlignmentLeft;
        approvalStatusLabel.text = @"带我审批";
        approvalStatusLabel.font = [UIFont systemFontOfSize:Textadaptation(14)];
        [self.contentView addSubview:approvalStatusLabel];
        _approvalStatusLabel = approvalStatusLabel;
        //时间
        UILabel * approvalTimeLabel = [[UILabel alloc]init];
        approvalTimeLabel.text = @"10:40";
        approvalTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        approvalTimeLabel.textAlignment = NSTextAlignmentRight;
        approvalTimeLabel.font = [UIFont systemFontOfSize:Textadaptation(10)];
        [self.contentView addSubview:approvalTimeLabel];
        _approvalTimeLabel = approvalTimeLabel;
        
       //底部横线
        UIView * approvalBottomView = [[UIView alloc]init];
        approvalBottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:approvalBottomView];
        
        
        approvalImageView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 19)
        .widthIs(32)
        .heightEqualToWidth();
        
        approvalImageView.layer.cornerRadius = approvalImageView.yj_width * 0.5;
        approvalImageView.layer.masksToBounds = YES;
        
        approvalNameLabel.sd_layout
        .topEqualToView(approvalImageView)
        .leftSpaceToView(approvalImageView, 10)
        .widthRatioToView(self.contentView, 0.4)
        .heightIs(20);
        
        approvalDepartmentLabel.sd_layout
        .leftSpaceToView(approvalNameLabel, -100)
        .bottomEqualToView(approvalNameLabel)
        .widthRatioToView(self.contentView, 0.2)
        .heightIs(14);
        
        
        approvalTimeLabel.sd_layout
        .topEqualToView(approvalDepartmentLabel)
        .rightSpaceToView(self.contentView, 12)
        .widthRatioToView(self.contentView, 0.4)
        //.heightRatioToView(self.contentView, 0.4);
        .bottomEqualToView(approvalDepartmentLabel);
        
        if (IS_IPHONE) {
            
            approvalContentLabel.sd_layout
            .leftEqualToView(approvalNameLabel)
            .rightSpaceToView(self.contentView, 12)
            .topSpaceToView(approvalNameLabel, 0)
            .heightRatioToView(self.contentView, 0.3);
            
            
            approvalStatusLabel.sd_layout
            .leftEqualToView(approvalContentLabel)
            .rightEqualToView(approvalContentLabel)
            .topSpaceToView(approvalContentLabel, 0)
            .heightIs(20);
        }else{
            
            
            if (DEVICES_IS_PRO_12_9) {
                
                
                approvalContentLabel.sd_layout
                .leftEqualToView(approvalNameLabel)
                .rightSpaceToView(self.contentView, 12)
                .topSpaceToView(approvalNameLabel, 10)
                .heightRatioToView(self.contentView, 0.3);
                
                
                approvalStatusLabel.sd_layout
                .leftEqualToView(approvalContentLabel)
                .rightEqualToView(approvalContentLabel)
                .topSpaceToView(approvalContentLabel, 10)
                .heightIs(20);
                
                
                
            }else{
                
                approvalContentLabel.sd_layout
                .leftEqualToView(approvalNameLabel)
                .rightSpaceToView(self.contentView, 12)
                .topSpaceToView(approvalNameLabel, 5)
                .heightRatioToView(self.contentView, 0.3);
                
                
                approvalStatusLabel.sd_layout
                .leftEqualToView(approvalContentLabel)
                .rightEqualToView(approvalContentLabel)
                .topSpaceToView(approvalContentLabel, 5)
                .heightIs(20);
                
            }
            
            
            
        }
        
        approvalBottomView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1)
        .bottomSpaceToView(self.contentView, 0);
    }
    return self;
}

- (void)setAuditemodel:(RSAuditedModel *)auditemodel{
    _auditemodel = auditemodel;
     if ([_auditemodel.billKey isEqualToString:@"Flow_ApplyLeave"] || [_auditemodel.billKey isEqualToString:@"Flow_RsApplyLeave"] || [_auditemodel.billKey isEqualToString:@"Flow_BreakDown"] || [_auditemodel.billKey isEqualToString:@"Flow_RsBreakDown"]) {
         _approvalContentLabel.text = [NSString stringWithFormat:@"%@:%0.1lf天",auditemodel.billName,auditemodel.amount];
         
     }else if ([_auditemodel.billKey isEqualToString:@"Flow_Payment"]){
         
         _approvalContentLabel.text = [NSString stringWithFormat:@"%@:¥%0.2lf",auditemodel.billName,auditemodel.amount];
     }else{
          _approvalContentLabel.text = [NSString stringWithFormat:@"%@",auditemodel.billName];
         
     }
    _approvalNameLabel.text = [NSString stringWithFormat:@"%@",auditemodel.creatorName];
    _approvalDepartmentLabel.text = [NSString stringWithFormat:@"%@",auditemodel.deptName];
    _approvalStatusLabel.text = [NSString stringWithFormat:@"%@",auditemodel.workFlowType];
    _approvalTimeLabel.text = [NSString stringWithFormat:@"%@",auditemodel.createtime];
    
    //"workFlowType":"待我审批","
    
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
