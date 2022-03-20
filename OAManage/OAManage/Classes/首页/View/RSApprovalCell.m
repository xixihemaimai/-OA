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


@property (nonatomic,strong)UIImageView * approvalImageView;
@end


@implementation RSApprovalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图片
        UIImageView * approvalImageView = [[UIImageView alloc]init];
        approvalImageView.contentMode =  UIViewContentModeScaleAspectFill;
        approvalImageView.image = [UIImage imageNamed:@"logo"];
        [self.contentView addSubview:approvalImageView];
        _approvalImageView = approvalImageView;
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
        approvalDepartmentLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        approvalDepartmentLabel.text = @"信息部";
        approvalDepartmentLabel.textAlignment = NSTextAlignmentLeft;
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
        approvalTimeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        approvalTimeLabel.textAlignment = NSTextAlignmentRight;
        approvalTimeLabel.font = [UIFont systemFontOfSize:Textadaptation(10)];
        [self.contentView addSubview:approvalTimeLabel];
        _approvalTimeLabel = approvalTimeLabel;
        
       //底部横线
        UIView * approvalBottomView = [[UIView alloc]init];
        approvalBottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:approvalBottomView];
        _approvalBottomView = approvalBottomView;
        
//        approvalImageView.sd_layout
//        .leftSpaceToView(self.contentView, 12)
//        .topSpaceToView(self.contentView, 19)
//        .widthIs(32)
//        .heightEqualToWidth();
        
        
        approvalImageView.frame = CGRectMake(12, 19, 32, 32);
        
        
        approvalImageView.layer.cornerRadius = approvalImageView.yj_width * 0.5;
//        approvalImageView.layer.masksToBounds = YES;
        
//        approvalNameLabel.sd_layout
//        .topEqualToView(approvalImageView)
//        .leftSpaceToView(approvalImageView, 10)
//        .widthRatioToView(self.contentView, 0.4)
//        .heightIs(20);
        
        approvalNameLabel.frame = CGRectMake(CGRectGetMaxX(approvalImageView.frame) + 10, 19, SCW * 0.4, 20);
        
//        approvalDepartmentLabel.sd_layout
//        .leftSpaceToView(approvalNameLabel, -100)
//       // .bottomEqualToView(approvalNameLabel)
//        .bottomSpaceToView(approvalNameLabel, -19)
//        .widthRatioToView(self.contentView, 0.2)
//        .heightIs(14);
        
        approvalDepartmentLabel.frame = CGRectMake(CGRectGetMaxX(approvalNameLabel.frame) - 100, 22.5, SCW * 0.2, 14);
        
//        approvalTimeLabel.sd_layout
//        .topEqualToView(approvalDepartmentLabel)
//        .rightSpaceToView(self.contentView, 12)
//        .widthRatioToView(self.contentView, 0.4)
//        //.heightRatioToView(self.contentView, 0.4);
//        .bottomEqualToView(approvalDepartmentLabel);
        
        approvalTimeLabel.frame = CGRectMake(self.contentView.yj_width - self.contentView.yj_width * 0.4 - 5, 22.5, self.contentView.yj_width * 0.4, 14);
            
//            approvalContentLabel.sd_layout
//            .leftEqualToView(approvalNameLabel)
//            .rightSpaceToView(self.contentView, 12)
//            .topSpaceToView(approvalNameLabel, 0)
//            .heightRatioToView(self.contentView, 0.3);
        
        approvalContentLabel.frame = CGRectMake(CGRectGetMaxX(approvalImageView.frame) + 10, CGRectGetMaxY(approvalNameLabel.frame), 200, self.contentView.yj_height * 0.45);
            
//            approvalStatusLabel.sd_layout
//            .leftEqualToView(approvalContentLabel)
//            .rightEqualToView(approvalContentLabel)
//            .topSpaceToView(approvalContentLabel, 0)
//            .heightIs(20);
        approvalStatusLabel.frame = CGRectMake(CGRectGetMaxX(approvalImageView.frame) + 10, CGRectGetMaxY(approvalContentLabel.frame), 200, 20);
        
//        approvalBottomView.sd_layout
//        .leftSpaceToView(self.contentView, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .heightIs(1)
//        .bottomSpaceToView(self.contentView, 0);
        
        approvalBottomView.frame = CGRectMake(0, self.contentView.yj_height - 1, SCW, 1);
        
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
    CGSize size = [_approvalNameLabel.text sizeWithAttributes:@{NSFontAttributeName:_approvalNameLabel.font}];

    _approvalNameLabel.sd_layout
    .topEqualToView(_approvalImageView)
    .leftSpaceToView(_approvalImageView, 10)
    .widthIs(size.width)
    .heightIs(20);
    
    
    //部门
    _approvalDepartmentLabel.text = [NSString stringWithFormat:@"%@",auditemodel.deptName];
    
    
    CGSize approvalDepartmentsize = [_approvalDepartmentLabel.text sizeWithAttributes:@{NSFontAttributeName:_approvalDepartmentLabel.font}];
    
//    _approvalDepartmentLabel.sd_layout
//    .leftSpaceToView(_approvalNameLabel, 5)
//   .bottomSpaceToView(_approvalNameLabel, -19)
//    .widthIs(approvalDepartmentsize.width)
//    .heightIs(14);
    
    
    _approvalDepartmentLabel.frame = CGRectMake(CGRectGetMaxX(_approvalNameLabel.frame) + 5, 22.5, approvalDepartmentsize.width, 14);
    
    
    _approvalStatusLabel.text = [NSString stringWithFormat:@"%@",auditemodel.workFlowType];
    
    NSString * current = _auditemodel.createtime;
    current = [current substringToIndex:16];
    
    _approvalTimeLabel.text = [NSString stringWithFormat:@"%@",current];
    CGSize approvalTimeLabelSize = [_approvalTimeLabel.text sizeWithAttributes:@{NSFontAttributeName:_approvalTimeLabel.font}];
//    _approvalTimeLabel.sd_layout
//    .topEqualToView(_approvalDepartmentLabel)
//    .rightSpaceToView(self.contentView, 12)
//    .widthIs(approvalTimeLabelSize.width)
//    .bottomEqualToView(_approvalDepartmentLabel);
    
    _approvalTimeLabel.frame = CGRectMake(self.contentView.yj_width - self.contentView.yj_width * 0.4 - 5, 22.5, approvalTimeLabelSize.width, 14);
    
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
