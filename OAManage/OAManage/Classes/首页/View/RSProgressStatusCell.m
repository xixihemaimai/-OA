//
//  RSProgressStatusCell.m
//  OAManage
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSProgressStatusCell.h"


@interface RSProgressStatusCell()

@property (nonatomic,strong) UIImageView * verticalImageView;
@property (nonatomic,strong) UILabel * departmentLabel;
@property (nonatomic,strong) UILabel * statusLabel;


@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * contentLabel;


@property (nonatomic,strong) UILabel * timeLabel;
@end



@implementation RSProgressStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ECECEC"];
        
        
        //竖直的view
        UIView * verticalView = [[UIView alloc]init];
        verticalView.backgroundColor = [UIColor colorWithHexColorStr:@"#DEDEDE"];
        [self.contentView addSubview:verticalView];
        
        
        //竖直的图片
        UIImageView * verticalImageView = [[UIImageView alloc]init];
        verticalImageView.contentMode = UIViewContentModeScaleAspectFill;
        verticalImageView.image = [UIImage imageNamed:@"进行中图标"];
        [self.contentView addSubview:verticalImageView];
        _verticalImageView = verticalImageView;
        
        
        //横的图片
        UIImageView * transverseImageView = [[UIImageView alloc]init];
        //transverseImageView.contentMode = UIViewContentModeScaleAspectFill;
        transverseImageView.image = [UIImage imageNamed:@"Rectangle"];
        //transverseImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:transverseImageView];
        
        
        //部门
        UILabel * departmentLabel = [[UILabel alloc]init];
        departmentLabel.text = @"人事审核";
        departmentLabel.textAlignment = NSTextAlignmentLeft;
        departmentLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        departmentLabel.font = [UIFont systemFontOfSize:Textadaptation(14)];
        [transverseImageView addSubview:departmentLabel];
        _departmentLabel = departmentLabel;
        
        
        //状态
        //status
        UILabel * statusLabel = [[UILabel alloc]init];
        statusLabel.text = @"待你审核";
        statusLabel.textAlignment = NSTextAlignmentLeft;
        statusLabel.textColor = [UIColor colorWithHexColorStr:@"#F5A623"];
        statusLabel.font = [UIFont systemFontOfSize:Textadaptation(12)];
        [transverseImageView addSubview:statusLabel];
        _statusLabel = statusLabel;
        
        
        //人物的头像
        //headImageview
        UIImageView * headImageview = [[UIImageView alloc]init];
        headImageview.contentMode = UIViewContentModeScaleAspectFill;
        headImageview.image = [UIImage imageNamed:@"logo"];
        [transverseImageView addSubview:headImageview];
        
        
        //名字
        //name
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"叶一一";
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        [transverseImageView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        //什么事情内容
        //content
        UILabel * contentLabel = [[UILabel alloc]init];
        contentLabel.text = @"同意，请注意完成工作内容";
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        contentLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        [transverseImageView addSubview:contentLabel];
        _contentLabel = contentLabel;
        
        //时间
        //time
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"2018-9-9 11:30";
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        timeLabel.font = [UIFont systemFontOfSize:Textadaptation(12)];
        [transverseImageView addSubview:timeLabel];
        _timeLabel = timeLabel;
        
        //是否有向右的图片
        //rightImageView
        UIImageView * rightImageView = [[UIImageView alloc]init];
        rightImageView.contentMode = UIViewContentModeScaleAspectFill;
        rightImageView.image = [UIImage imageNamed:@"向右"];
        [transverseImageView addSubview:rightImageView];
        rightImageView.hidden = YES;
        
        
        //同意的图片
        //Agree
        UIImageView * agreeImageView = [[UIImageView alloc]init];
        agreeImageView.contentMode = UIViewContentModeScaleAspectFill;
        agreeImageView.image = [UIImage imageNamed:@"审批完图片 copy 2"];
        [transverseImageView addSubview:agreeImageView];
        
        
        
//        verticalView.sd_layout
//        .leftSpaceToView(self.contentView, 18)
//        .topSpaceToView(self.contentView, 0)
//        .bottomSpaceToView(self.contentView, 0)
//        .widthIs(1);
        
        
        
        
        verticalView.frame = CGRectMake(18, 0, 1, (144 / SCW) * SCW);
        
        verticalImageView.frame = CGRectMake(11, 19, 16, 16);
        
//        transverseImageView.sd_layout
//        .leftSpaceToView(self.contentView, 32)
//        .topSpaceToView(self.contentView, 14)
//        .bottomSpaceToView(self.contentView, 14)
//        .rightSpaceToView(self.contentView, 13);
        
        transverseImageView.frame = CGRectMake(32, 14, SCW - 46, (144 / SCW) * SCW - 28);
        
        departmentLabel.frame = CGRectMake(17, 11, transverseImageView.yj_width * 0.4, (144 / SCW) * SCW * 0.15);
//        departmentLabel.sd_layout
//        .leftSpaceToView(transverseImageView, 17)
//        .topSpaceToView(transverseImageView, 11)
//        .widthRatioToView(transverseImageView, 0.4)
//        .heightRatioToView(self.contentView, 0.15);
        
        statusLabel.frame = CGRectMake(17, CGRectGetMaxY(departmentLabel.frame) + 1, transverseImageView.yj_width * 0.4, (144 / SCW) * SCW * 0.15);
//        statusLabel.sd_layout
//        .leftEqualToView(departmentLabel)
//        .rightEqualToView(departmentLabel)
//        .topSpaceToView(departmentLabel, 1)
//        .heightRatioToView(self.contentView, 0.15);
        
        
//        verticalImageView.sd_layout
//        .leftSpaceToView(self.contentView, 11)
//        .topSpaceToView(self.contentView, 19)
//        .widthIs(16)
//        .heightEqualToWidth();
        
        
        
            
//            verticalImageView.sd_layout
//            .leftSpaceToView(self.contentView, 11)
//            .topSpaceToView(self.contentView, 19)
//            .widthIs(16)
//            .heightEqualToWidth();
        
        
        headImageview.frame = CGRectMake(17, CGRectGetMaxY(statusLabel.frame) + 10, (32 / SCW) * SCW, (32 / SCW) * SCW);
            
//            headImageview.sd_layout
//            .leftEqualToView(departmentLabel)
//            .topSpaceToView(statusLabel, 10)
//            .widthIs((32 / SCW) * SCW)
//            .heightEqualToWidth();
            
        
        nameLabel.frame = CGRectMake(CGRectGetMaxX(headImageview.frame) + 12, headImageview.yj_y, transverseImageView.yj_width * 0.4, (144 / SCW) * SCW * 0.1);
//            nameLabel.sd_layout
//            .leftSpaceToView(headImageview, 12)
//            .topEqualToView(headImageview)
//            .widthRatioToView(transverseImageView, 0.4)
//            .heightRatioToView(self.contentView, 0.1);
            
        contentLabel.frame = CGRectMake(CGRectGetMaxX(headImageview.frame) + 12, CGRectGetMaxY(nameLabel.frame) + 4, SCW - CGRectGetMaxX(headImageview.frame) - 50, (144 / SCW) * SCW * 0.1);
//            contentLabel.sd_layout
//            .leftEqualToView(nameLabel)
//            .topSpaceToView(nameLabel, 4)
//            .rightSpaceToView(transverseImageView, 15)
//            .heightRatioToView(self.contentView, 0.1);
            
        rightImageView.frame = CGRectMake(SCW - 15 - 9, CGRectGetMaxY(transverseImageView.frame) + 18, 9, 15);
//            rightImageView.sd_layout
//            .rightSpaceToView(transverseImageView, 15)
//            .topSpaceToView(transverseImageView, 18)
//            .widthIs(9)
//            .heightIs(15);
//
            
//            agreeImageView.sd_layout
//            .rightSpaceToView(contentLabel, 10)
//            .widthIs(13)
//            .heightEqualToWidth()
//            .bottomEqualToView(headImageview);
        
        /**
         
         headImageview.frame = CGRectMake(17, CGRectGetMaxY(statusLabel.frame) + 10, (32 / SCW) * SCW, (32 / SCW) * SCW);
         */
            
        agreeImageView.frame = CGRectMake(self.frame.size.width - 30, contentLabel.yj_y, 13, 13);
            
          
        
        headImageview.layer.cornerRadius = headImageview.yj_width * 0.5;
        headImageview.layer.masksToBounds = YES;
 
//        timeLabel.sd_layout
//        .leftSpaceToView(nameLabel, 0)
//        .rightSpaceToView(transverseImageView, 15)
//        .topEqualToView(nameLabel)
//        .bottomEqualToView(nameLabel);
        
        timeLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame), nameLabel.yj_y, 120, (144 / SCW) * SCW * 0.1);
        
    }
    return self;
}


- (void)setApprovalProcessmodel:(RSApprovalProcessModel *)approvalProcessmodel{
    _approvalProcessmodel = approvalProcessmodel;
    _statusLabel.text = [NSString stringWithFormat:@"%@",_approvalProcessmodel.resultInfo];
    _nameLabel.text = [NSString stringWithFormat:@"%@",_approvalProcessmodel.userName];
    
    _departmentLabel.text = [NSString stringWithFormat:@"%@",_approvalProcessmodel.workItemName];
    _contentLabel.text = [NSString stringWithFormat:@"%@",_approvalProcessmodel.userInfo];
    
    if ([_approvalProcessmodel.resultInfo isEqualToString:@"通过"]) {
        _verticalImageView.image = [UIImage imageNamed:@"审批完图片"];
        NSString * current = _approvalProcessmodel.finishTime;
        current = [current substringToIndex:16];
        _timeLabel.text = [NSString stringWithFormat:@"%@",current];
        
    }else{
        NSString * current = _approvalProcessmodel.createTime;
        current = [current substringToIndex:16];
        _timeLabel.text = [NSString stringWithFormat:@"%@",current];
        _verticalImageView.image = [UIImage imageNamed:@"进行中图标"];
    }
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
