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
@property (nonatomic,strong) UIView * verticalView;
@property (nonatomic,strong)UIImageView * transverseImageView;
@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong)UIImageView * headImageview;

@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong)UIImageView * agreeImageView;

@property (nonatomic,strong)UIImageView * rightImageView;
@end



@implementation RSProgressStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        //竖直的view
        UIView * verticalView = [[UIView alloc]init];
        verticalView.backgroundColor = [UIColor colorWithHexColorStr:@"#DEDEDE"];
        [self.contentView addSubview:verticalView];
        _verticalView = verticalView;
        
        //竖直的图片
        UIImageView * verticalImageView = [[UIImageView alloc]init];
        verticalImageView.contentMode = UIViewContentModeScaleAspectFill;
        verticalImageView.image = [UIImage imageNamed:@"进行中图标"];
        [self.contentView addSubview:verticalImageView];
        _verticalImageView = verticalImageView;
        
        
        //横的图片
        UIImageView * transverseImageView = [[UIImageView alloc]init];
        transverseImageView.image = [UIImage imageNamed:@"Rectangle"];
        [self.contentView addSubview:transverseImageView];
        _transverseImageView = transverseImageView;
        
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
        _headImageview = headImageview;
        
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
        contentLabel.text = @"同意，请注意完成工作内容同意";
        contentLabel.numberOfLines = 0;
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
//        rightImageView.hidden = YES;
        _rightImageView = rightImageView;
        
        //同意的图片
        //Agree
        UIImageView * agreeImageView = [[UIImageView alloc]init];
        agreeImageView.contentMode = UIViewContentModeScaleAspectFill;
        agreeImageView.image = [UIImage imageNamed:@"审批完图片 copy 2"];
        [transverseImageView addSubview:agreeImageView];
        _agreeImageView = agreeImageView;
      
        [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.width.mas_equalTo(1);
            make.top.bottom.equalTo(self.contentView);
        }];
        
        [self.transverseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(32);
            make.right.mas_equalTo(-13);
            make.top.mas_equalTo(6);
//            make.centerY.equalTo(self.verticalImageView.mas_centerY);
        }];
        
//        transverseImageView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//        transverseImageView.layer.cornerRadius = 5;
//        transverseImageView.layer.borderColor = [UIColor colorWithHexColorStr:@"#DBE0E3"].CGColor;
//        transverseImageView.layer.borderWidth = 0.5;
//        if (@available(iOS 11.0, *)) {
//            transverseImageView.layer.maskedCorners = true;
//        }
        
        [self.departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(17);
            make.top.mas_equalTo(11);
            make.right.equalTo(self.transverseImageView.mas_right);
            make.height.mas_equalTo(20);
        }];
        
        
        
        
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(17);
            make.right.equalTo(self.transverseImageView.mas_right);
            make.top.equalTo(self.departmentLabel.mas_bottom).offset(1);
            make.height.mas_equalTo(16.5);
        }];
        
        
        [self.headImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(17);
            make.top.equalTo(self.statusLabel.mas_bottom).offset(18);
            make.width.height.mas_equalTo(32);
        }];
        
        self.headImageview.layer.cornerRadius = 32 * 0.5;
        self.headImageview.layer.masksToBounds = YES;
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageview.mas_right).offset(12);
            make.top.equalTo(self.headImageview.mas_top);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(19);
        }];
        
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.transverseImageView.mas_right).offset(-16.5);
            make.top.equalTo(self.nameLabel.mas_top);
            make.height.mas_equalTo(19);
            make.bottom.equalTo(self.nameLabel.mas_bottom);
        }];
        
        [self.agreeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headImageview.mas_right);
            make.bottom.equalTo(self.headImageview.mas_bottom);
            make.width.height.mas_equalTo(13);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageview.mas_right).offset(12);
            make.top.equalTo(self.nameLabel.mas_bottom);
            make.right.equalTo(self.transverseImageView.mas_right).offset(-16.5);
            make.bottom.equalTo(self.transverseImageView.mas_bottom).offset(-15);
        }];
        
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-14.5);
            make.top.mas_equalTo(18);
            make.width.mas_equalTo(8.5);
            make.height.mas_equalTo(15);
        }];
        
        
        
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self.transverseImageView.mas_bottom).offset(6);
        }];
    }
    return self;
}

- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}


- (void)setApprovalProcessmodel:(RSApprovalProcessModel *)approvalProcessmodel{
    _approvalProcessmodel = approvalProcessmodel;
    _statusLabel.text = [NSString stringWithFormat:@"%@",_approvalProcessmodel.resultInfo];
    _nameLabel.text = [NSString stringWithFormat:@"%@",_approvalProcessmodel.userName];
    
    _departmentLabel.text = [NSString stringWithFormat:@"%@",_approvalProcessmodel.workItemName];
//    _contentLabel.text = [NSString stringWithFormat:@"%@",_approvalProcessmodel.userInfo];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
     paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
     NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    self.contentLabel.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_approvalProcessmodel.userInfo] attributes:attributes];
    
    
    CGFloat height = [self getHeightByWidth:SCW - 45 title:[NSString stringWithFormat:@"%@",_approvalProcessmodel.userInfo] font:[UIFont systemFontOfSize:Textadaptation(13)]];
    
    
//  NSLog(@"=============23=2========%lf",height);
    NSInteger count = height/13;
//  NSLog(@"============2234==========%ld",count);
    [self.verticalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.width.height.mas_equalTo(16);
        make.top.mas_equalTo(10 + count * 2);
//        if (count == 1){
//            make.top.mas_equalTo(12);
//        }else if (count == 2){
//            make.top.mas_equalTo(14);
//        }else if (count == 3){
//            make.top.mas_equalTo(16);
//        }else if (count == 4){
//            make.top.mas_equalTo(18);
//        }else if (count == 5){
//            make.top.mas_equalTo(20);
//        }else if (count == 6){
//            make.top.mas_equalTo(22);
//        }
    }];
    
    
    if ([_approvalProcessmodel.resultInfo isEqualToString:@"通过"]) {
        _verticalImageView.image = [UIImage imageNamed:@"审批完图片"];
        NSString * current = _approvalProcessmodel.finishTime;
        current = [current substringToIndex:16];
        _timeLabel.text = [NSString stringWithFormat:@"%@",current];
        _rightImageView.hidden = true;
    }else{
        _rightImageView.hidden = false;
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
