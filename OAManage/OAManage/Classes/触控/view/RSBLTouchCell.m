//
//  RSBLTouchCell.m
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBLTouchCell.h"


@interface RSBLTouchCell()


@property (nonatomic,strong)UILabel * productNameLabel;

@property (nonatomic,strong)UILabel * productDetailLabel;

@property (nonatomic,strong)UILabel * productTypeDetailLabel;

@end

@implementation RSBLTouchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
         //内容信息
         UIView * exceptionView = [[UIView alloc]init];
         exceptionView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
         [self.contentView addSubview:exceptionView];
         
        exceptionView.frame = CGRectMake(12, 12, SCW - 24, 126 - 12);
         
//         exceptionView.sd_layout
//         .leftSpaceToView(self.contentView, 12)
//         .rightSpaceToView(self.contentView, 12)
//         .topSpaceToView(self.contentView, 12)
//        .bottomSpaceToView(self.contentView, 0);
         
         
         exceptionView.layer.cornerRadius = 3;
         
         
         UIImageView * yellewView = [[UIImageView alloc]init];
         //yellewView.backgroundColor = [UIColor colorWithHexColorStr:@"#FBC05F"];
         yellewView.image = [UIImage imageNamed:@"Rectangle 32 Copy 4"];
         yellewView.contentMode = UIViewContentModeScaleAspectFill;
         yellewView.clipsToBounds = YES;
         [exceptionView addSubview:yellewView];
         
        yellewView.frame = CGRectMake(0, 10, 4, 17);
         
//         yellewView.sd_layout
//         .leftSpaceToView(exceptionView, 0)
//         .topSpaceToView(exceptionView, 10)
//         .heightIs(17)
//         .widthIs(4);
         
         UIImageView * blueView = [[UIImageView alloc]init];
         blueView.image = [UIImage imageNamed:@"Rectangle 32 Copy 5"];
         blueView.contentMode = UIViewContentModeScaleAspectFill;
         blueView.clipsToBounds = YES;
         [exceptionView addSubview:blueView];
         
        blueView.frame = CGRectMake(exceptionView.yj_width - 4, 10, 4, 17);
        
//         blueView.sd_layout
//         .rightSpaceToView(exceptionView, 0)
//         .topSpaceToView(exceptionView, 10)
//         .heightIs(17)
//         .widthIs(4);
         
         
         //物料号
         UILabel * productNameLabel = [[UILabel alloc]init];
         productNameLabel.text = @"ESB00295/DH-539";
         productNameLabel.font = [UIFont systemFontOfSize:15];
         productNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
         productNameLabel.textAlignment = NSTextAlignmentLeft;
         [exceptionView addSubview:productNameLabel];
         _productNameLabel = productNameLabel;
 
        
         
         //删除按键
         UIButton * productDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
          [productDeleteBtn setImage:[UIImage imageNamed:@"垃圾桶"] forState:UIControlStateNormal];
        // [productDeleteBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#D5DBE4"]];
         [exceptionView addSubview:productDeleteBtn];
         _productDeleteBtn = productDeleteBtn;
         
         
         //分割线
         UIView * midView = [[UIView alloc]init];
         midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
         [exceptionView addSubview:midView];
         
         
         
         //物料名称
         UILabel * productLabel = [[UILabel alloc]init];
         productLabel.text = @"物料名称";
         productLabel.font = [UIFont systemFontOfSize:15];
         productLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
         productLabel.textAlignment = NSTextAlignmentLeft;
         [exceptionView addSubview:productLabel];
         
         
         UILabel * productDetailLabel = [[UILabel alloc]init];
         productDetailLabel.text = @"白玉兰";
         productDetailLabel.font = [UIFont systemFontOfSize:15];
         productDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
         productDetailLabel.textAlignment = NSTextAlignmentRight;
         [exceptionView addSubview:productDetailLabel];
         _productDetailLabel = productDetailLabel;
         
         //物料类型
         UILabel * productTypeLabel = [[UILabel alloc]init];
         productTypeLabel.text = @"体积(m³)";
         productTypeLabel.font = [UIFont systemFontOfSize:15];
         productTypeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
         productTypeLabel.textAlignment = NSTextAlignmentLeft;
         [exceptionView addSubview:productTypeLabel];
         
         
         UILabel * productTypeDetailLabel = [[UILabel alloc]init];
         productTypeDetailLabel.text = @"5.883";
         productTypeDetailLabel.font = [UIFont systemFontOfSize:15];
         productTypeDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
         productTypeDetailLabel.textAlignment = NSTextAlignmentRight;
         [exceptionView addSubview:productTypeDetailLabel];
         _productTypeDetailLabel = productTypeDetailLabel;
        
        
        productNameLabel.frame = CGRectMake(17, 10, (SCW - 24) * 0.5, 21);
        
//        productNameLabel.sd_layout
//        .leftSpaceToView(exceptionView, 17)
//        .topSpaceToView(exceptionView, 10)
//        .heightIs(21)
//        .widthRatioToView(exceptionView, 0.5);
        
        productDeleteBtn.frame = CGRectMake(SCW - 24 - 28 - 15.5, 6.5, 28, 28);
        
//        productDeleteBtn.sd_layout
//        .rightSpaceToView(exceptionView, 15.5)
//        .topSpaceToView(exceptionView, 6.5)
//        .widthIs(28)
//        .heightEqualToWidth();
        
        midView.frame = CGRectMake(0, CGRectGetMaxY(productNameLabel.frame) + 6, SCW - 24, 0.5);
        
        
//        midView.sd_layout
//        .leftSpaceToView(exceptionView, 0)
//        .rightSpaceToView(exceptionView, 0)
//        .topSpaceToView(productNameLabel, 6)
//        .heightIs(0.5);
        
        
        
        
//        productLabel.sd_layout
//        .leftSpaceToView(exceptionView, 17)
//        .topSpaceToView(midView, 7)
//        .widthIs(90)
//        .heightIs(21);
        
        productLabel.frame = CGRectMake(17, CGRectGetMaxY(midView.frame) + 7, 90, 21);
        
//        productDetailLabel.sd_layout
//        .rightSpaceToView(exceptionView, 15)
//        .topEqualToView(productLabel)
//        .bottomEqualToView(productLabel)
//        .widthRatioToView(exceptionView, 0.5);
        
        
        productDetailLabel.frame = CGRectMake(SCW - 24 - 15 - (SCW - 24) * 0.5, CGRectGetMaxY(midView.frame) + 7, (SCW - 24) * 0.5, 21);
        
//        productTypeLabel.sd_layout
//        .leftEqualToView(productLabel)
//        .rightEqualToView(productLabel)
//        .topSpaceToView(productLabel, 3)
//        .heightIs(21);
        
        productTypeLabel.frame = CGRectMake(17, CGRectGetMaxY(productLabel.frame) + 3, 90, 21);
        
        productTypeDetailLabel.frame = CGRectMake(SCW - 24 - 15 - (SCW - 24) * 0.5, CGRectGetMaxY(productLabel.frame) + 3, (SCW - 24) * 0.5, 21);
        
//        productTypeDetailLabel.sd_layout
//        .rightEqualToView(productDetailLabel)
//        .topEqualToView(productTypeLabel)
//        .bottomEqualToView(productTypeLabel)
//        .leftEqualToView(productDetailLabel);
        
        
    }
    return self;
}


- (void)setBmstockmodel:(RSBMStockModel *)bmstockmodel{
    _bmstockmodel = bmstockmodel;
    _productNameLabel.text = _bmstockmodel.blockNo;
    _productDetailLabel.text = _bmstockmodel.mtlName;
    _productTypeDetailLabel.text = [NSString stringWithFormat:@"%@",_bmstockmodel.volume];
    
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
