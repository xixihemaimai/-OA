//
//  RSApprovalProcessCell.m
//  OAManage
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSApprovalProcessCell.h"

@interface RSApprovalProcessCell()

@property (nonatomic,strong)UIView * showview;



@property (nonatomic,strong)UIView * midView;

@property (nonatomic,strong)UILabel * outResultLabel;

@property (nonatomic,strong)UILabel * informationLabel;

@end



@implementation RSApprovalProcessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        //view
        UIView * showview = [[UIView alloc]init];
        showview.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f7fa"];
        [self.contentView addSubview:showview];
        self.showview = showview;
        showview.layer.cornerRadius = 4;
        showview.layer.masksToBounds = YES;
        //具体内容
        UILabel * concreteContentLabel = [[UILabel alloc]init];
        concreteContentLabel.font = [UIFont systemFontOfSize:14];
        concreteContentLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        concreteContentLabel.numberOfLines = 0;
        [showview addSubview:concreteContentLabel];
        self.concreteContentLabel = concreteContentLabel;
        
        
        //打开或者关闭按键
        UIButton * openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[openBtn setTitle:@"打开" forState:UIControlStateNormal];
        [openBtn setImage:[UIImage imageNamed:@"三角形"] forState:UIControlStateNormal];
        [openBtn setImage:[UIImage imageNamed:@"三角形复制"] forState:UIControlStateSelected];
        [showview addSubview:openBtn];
        self.openBtn = openBtn;
        
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#EEEEEE"];
        [showview addSubview:midView];
        self.midView = midView;
        
        
        
        //重要程度
        UILabel * informationLabel = [[UILabel alloc]init];
        informationLabel.font = [UIFont systemFontOfSize:14];
        informationLabel.numberOfLines = 0;
        informationLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        [showview addSubview:informationLabel];
        self.informationLabel = informationLabel;
        
        //输出结果
        UILabel * outResultLabel = [[UILabel alloc]init];
        outResultLabel.font = [UIFont systemFontOfSize:14];
        outResultLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        outResultLabel.numberOfLines = 0;
        [showview addSubview:outResultLabel];
        self.outResultLabel = outResultLabel;
        
        
    }
    return self;
}

- (void)layoutSubviews{
    self.showview.frame = self.workTypemodel.viewFrame;
    self.concreteContentLabel.frame = self.workTypemodel.concreteContentFrame;
    self.openBtn.frame = self.workTypemodel.oepnBtnFrame;
    self.midView.frame = self.workTypemodel.midFrame;
    self.informationLabel.frame = self.workTypemodel.informationFrame;
    self.outResultLabel.frame = self.workTypemodel.outResultFrame;
}

- (void)setWorkTypemodel:(RSWorkTypeModel *)workTypemodel{
    _workTypemodel = workTypemodel;
    self.openBtn.selected = _workTypemodel.open;
    if (self.openBtn.selected) {
        self.midView.hidden = NO;
    }else{
        self.midView.hidden = YES;
    }
    self.concreteContentLabel.text = _workTypemodel.content;
    self.informationLabel.text = _workTypemodel.level;
    self.outResultLabel.text = _workTypemodel.result;
}



@end
