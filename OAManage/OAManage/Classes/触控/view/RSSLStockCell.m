//
//  RSSLStockCell.m
//  OAManage
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLStockCell.h"


@interface RSSLStockCell()

/// 标题的背景
@property (nonatomic, strong) UIView *backView;

@end


@implementation RSSLStockCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
             [self setupCell];
        
        
    }
    return self;
}



-(void)setupCell {
    self.backView = [[UIView alloc]init];
    self.backView.userInteractionEnabled = YES;
    self.backView.frame = CGRectMake(12, 0, SCW - 24, 70.5);
    self.backView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.contentView addSubview:self.backView];
    
    UIView * showView = [[UIView alloc]initWithFrame:CGRectMake(10, 6, SCW - 44, 64.5)];
    showView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
    [self.backView addSubview:showView];
    
    
    
    UIView * blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#27c79a"];
    blueView.frame = CGRectMake(9.5, 11.5, 2.5, 13);
    [showView addSubview:blueView];
    
    //片号
    UILabel * filmNumberLabel = [[UILabel alloc]init];
    filmNumberLabel.frame = CGRectMake(CGRectGetMaxX(blueView.frame) + 4.5 , 8, 120, 20);
    filmNumberLabel.text = [NSString stringWithFormat:@"片号%d",1];
    filmNumberLabel.font = [UIFont systemFontOfSize:14];
    filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    filmNumberLabel.textAlignment = NSTextAlignmentLeft;
    [showView addSubview:filmNumberLabel];
    _filmNumberLabel = filmNumberLabel;
    
    
    //图片
//    UIImageView * iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(filmNumberLabel.frame), 6, 50, 20)];
//    iamgeView.image = [UIImage imageNamed:@"印章 To be reviewed"];
//    [showView addSubview:iamgeView];
//    _iamgeView = iamgeView;
    
    
    UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(showView.frame.size.width - 11 - 18, 23.5, 25,25);
    [selectBtn setImage:[UIImage imageNamed:@"Oval 9"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [showView addSubview:selectBtn];
    _selectBtn = selectBtn;
    
    //长
    UILabel * longLabel = [[UILabel alloc]init];
    longLabel.frame = CGRectMake(CGRectGetMaxX(blueView.frame) + 4.5, CGRectGetMaxY(filmNumberLabel.frame) + 7.5, 80, 20);
    longLabel.text = @"面积(m²)";
    longLabel.font = [UIFont systemFontOfSize:14];
    longLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    longLabel.textAlignment = NSTextAlignmentLeft;
    [showView addSubview:longLabel];
    
    
    
    
    
    
    //长的值
    UILabel * longDetailLabel = [[UILabel alloc]init];
    longDetailLabel.font = [UIFont systemFontOfSize:14];
   // CGSize size = [self obtainLabelTextSize:@"0.1" andFont:longDetailLabel.font];
    longDetailLabel.frame = CGRectMake(CGRectGetMaxX(longLabel.frame) + 14, CGRectGetMaxY(filmNumberLabel.frame) + 7.5, SCW - CGRectGetMaxX(longLabel.frame) - 14, 20);
    longDetailLabel.text = @"0.1";
    
    
    longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    longDetailLabel.textAlignment = NSTextAlignmentLeft;
    [showView addSubview:longDetailLabel];
    _longDetailLabel= longDetailLabel;
    
    
   
    
    
    
    
}


//- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
//    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
//                                     options:NSStringDrawingUsesLineFragmentOrigin
//                                  attributes:@{NSFontAttributeName:font}
//                                     context:nil].size;
//    return size;
//}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
