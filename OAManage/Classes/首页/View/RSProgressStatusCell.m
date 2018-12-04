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
        
        
        
        verticalView.sd_layout
        .leftSpaceToView(self.contentView, 18)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .widthIs(1);
        
        
        
//        verticalImageView.sd_layout
//        .leftSpaceToView(self.contentView, 11)
//        .topSpaceToView(self.contentView, 19)
//        .widthIs(16)
//        .heightEqualToWidth();
        
        
        
     
        
        
        
        
        if (IS_IPHONE) {
            
            
            
            verticalImageView.sd_layout
            .leftSpaceToView(self.contentView, 11)
            .topSpaceToView(self.contentView, 19)
            .widthIs(16)
            .heightEqualToWidth();
            
            
            
            headImageview.sd_layout
            .leftEqualToView(departmentLabel)
            .topSpaceToView(statusLabel, 10)
            .widthIs((32 / SCW) * SCW)
            .heightEqualToWidth();
            
            
            
            nameLabel.sd_layout
            .leftSpaceToView(headImageview, 12)
            .topEqualToView(headImageview)
            .widthRatioToView(transverseImageView, 0.6)
            .heightRatioToView(self.contentView, 0.1);
            
            
            contentLabel.sd_layout
            .leftEqualToView(nameLabel)
            .topSpaceToView(nameLabel, 4)
            .rightSpaceToView(transverseImageView, 15)
            .heightRatioToView(self.contentView, 0.1);
            
            
            
            
            
            rightImageView.sd_layout
            .rightSpaceToView(transverseImageView, 15)
            .topSpaceToView(transverseImageView, 18)
            .widthIs(9)
            .heightIs(15);
            
            
            agreeImageView.sd_layout
            .rightSpaceToView(contentLabel, 10)
            .widthIs(13)
            .heightEqualToWidth()
            .bottomEqualToView(headImageview);
            
            
            
            transverseImageView.sd_layout
            .leftSpaceToView(self.contentView, 32)
            .topSpaceToView(self.contentView, 14)
            .bottomSpaceToView(self.contentView, 14)
            .rightSpaceToView(self.contentView, 13);
            
            
            
            departmentLabel.sd_layout
            .leftSpaceToView(transverseImageView, 17)
            .topSpaceToView(transverseImageView, 11)
            .widthRatioToView(transverseImageView, 0.4)
            .heightRatioToView(self.contentView, 0.15);
            
            statusLabel.sd_layout
            .leftEqualToView(departmentLabel)
            .rightEqualToView(departmentLabel)
            .topSpaceToView(departmentLabel, 1)
            .heightRatioToView(self.contentView, 0.15);
            
        }else{
            //SCALE_TO_PRO
            if (DEVICES_IS_PRO_12_9) {
                verticalImageView.sd_layout
                .leftSpaceToView(self.contentView, 11)
                .topSpaceToView(self.contentView, 30)
                .widthIs(16 * SCALE_TO_PRO)
                .heightEqualToWidth();
                
                
                transverseImageView.sd_layout
                .leftSpaceToView(self.contentView, 34)
                .topSpaceToView(self.contentView, 14)
                .bottomSpaceToView(self.contentView, 14)
                .rightSpaceToView(self.contentView, 13);
                
                
                
                departmentLabel.sd_layout
                .leftSpaceToView(transverseImageView, 17)
                .topSpaceToView(transverseImageView, 11)
                .widthRatioToView(transverseImageView, 0.4)
                .heightRatioToView(self.contentView, 0.2);
                
                statusLabel.sd_layout
                .leftEqualToView(departmentLabel)
                .rightEqualToView(departmentLabel)
                .topSpaceToView(departmentLabel, 1)
                .heightRatioToView(self.contentView, 0.2);
                
                
                
                headImageview.sd_layout
                .leftEqualToView(departmentLabel)
                .topSpaceToView(statusLabel, 15)
                .widthIs(32 *  SCALE_TO_PRO)
                .heightEqualToWidth();
                
                
                nameLabel.sd_layout
                .leftSpaceToView(headImageview, 12)
                .topSpaceToView(statusLabel, 3)
                .widthRatioToView(transverseImageView, 0.6)
                .heightRatioToView(self.contentView, 0.2);
                
                
                contentLabel.sd_layout
                .leftEqualToView(nameLabel)
                .topSpaceToView(nameLabel, 0)
                .rightSpaceToView(transverseImageView, 15)
                .heightRatioToView(self.contentView, 0.2);
                
                
                
                rightImageView.sd_layout
                .rightSpaceToView(transverseImageView, 15)
                .topSpaceToView(transverseImageView, 18)
                .widthIs(9 * SCALE_TO_PRO)
                .heightIs(15 * SCALE_TO_PRO);
                
                
                agreeImageView.sd_layout
                .rightSpaceToView(contentLabel, 10)
                .widthIs(13 * SCALE_TO_PRO)
                .heightEqualToWidth()
                .bottomEqualToView(headImageview);
                
                
                
                
                
                
            }else{
                
                
                transverseImageView.sd_layout
                .leftSpaceToView(self.contentView, 32)
                .topSpaceToView(self.contentView, 14)
                .bottomSpaceToView(self.contentView, 14)
                .rightSpaceToView(self.contentView, 13);
                
                
                verticalImageView.sd_layout
                .leftSpaceToView(self.contentView, 11)
                .topSpaceToView(self.contentView, 25)
                .widthIs((16 / SCW) * SCW)
                .heightEqualToWidth();
                
                
                
                
                departmentLabel.sd_layout
                .leftSpaceToView(transverseImageView, 17)
                .topSpaceToView(transverseImageView, 11)
                .widthRatioToView(transverseImageView, 0.4)
                .heightRatioToView(self.contentView, 0.2);
                
                statusLabel.sd_layout
                .leftEqualToView(departmentLabel)
                .rightEqualToView(departmentLabel)
                .topSpaceToView(departmentLabel, 1)
                .heightRatioToView(self.contentView, 0.2);
                
                headImageview.sd_layout
                .leftEqualToView(departmentLabel)
                .topSpaceToView(statusLabel, 15)
                .widthIs((32 / SCW) * SCW)
                .heightEqualToWidth();
                
                
                nameLabel.sd_layout
                .leftSpaceToView(headImageview, 12)
                .topSpaceToView(statusLabel, 3)
                .widthRatioToView(transverseImageView, 0.6)
                .heightRatioToView(self.contentView, 0.2);
                
                
                contentLabel.sd_layout
                .leftEqualToView(nameLabel)
                .topSpaceToView(nameLabel, 0)
                .rightSpaceToView(transverseImageView, 15)
                .heightRatioToView(self.contentView, 0.2);
                
                
                
                rightImageView.sd_layout
                .rightSpaceToView(transverseImageView, 15)
                .topSpaceToView(transverseImageView, 18)
                .widthIs((9 / SCW) * SCW)
                .heightIs((15 / SCW) * SCW);
                
                
                agreeImageView.sd_layout
                .rightSpaceToView(contentLabel, 10)
                .widthIs(13)
                .heightEqualToWidth()
                .bottomEqualToView(headImageview);
                
                
                
                
            }
            
            
          
            
            
        }

        headImageview.layer.cornerRadius = headImageview.yj_width * 0.5;
        headImageview.layer.masksToBounds = YES;
 
        
        timeLabel.sd_layout
        .rightSpaceToView(transverseImageView, 15)
        .topEqualToView(nameLabel)
        .bottomEqualToView(nameLabel)
        .widthRatioToView(transverseImageView, 0.5);
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
