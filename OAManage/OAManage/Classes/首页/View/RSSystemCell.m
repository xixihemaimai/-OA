//
//  RSSystemCell.m
//  OAManage
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSystemCell.h"

@interface RSSystemCell()


@property (nonatomic,strong)UIImageView * fileType;

@property (nonatomic,strong)UILabel * fileLabel;



@end


@implementation RSSystemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView * fileType = [[UIImageView alloc]init];
        fileType.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:fileType];
        _fileType = fileType;
        
        UILabel * fileLabel = [[UILabel alloc]init];
        fileLabel.font = [UIFont systemFontOfSize:15];
        fileLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        fileLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:fileLabel];
        _fileLabel = fileLabel;
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:bottomview];
        
        bottomview.frame = CGRectMake(24, 44, SCW - 48, 0.5);
//       bottomview.sd_layout
//        .leftSpaceToView(self.contentView, 24)
//        .rightSpaceToView(self.contentView, 24)
//        .bottomSpaceToView(self.contentView, 0)
//        .heightIs(0.5);
        
        
//        fileType.sd_layout
//        .centerYEqualToView(self.contentView)
//        .leftSpaceToView(self.contentView, 15)
//        .widthIs(18)
//        .heightIs(18);
        fileType.frame = CGRectMake(15, 44.5/2 - 9, 18, 18);
        
//        fileLabel.sd_layout
//        .leftSpaceToView(fileType, 6.5)
//        .centerYEqualToView(self.contentView)
//        .rightSpaceToView(self.contentView, 15)
//        .heightIs(21);
        fileLabel.frame = CGRectMake(CGRectGetMaxX(fileType.frame) + 6.5, 44.5/2 - 21/2, SCW - CGRectGetMaxX(fileType.frame) - 6.5 - 15, 21);
        
        
    }
    return self;
}


- (void)setSystemmodel:(RSSystemModel *)systemmodel{
    _systemmodel = systemmodel;
    NSString * format = [NSString string];
     NSRange rage = [_systemmodel.url rangeOfString:@"." options:NSBackwardsSearch];// NSBackwardsSearch 表示最后的一个 // 去掉options表示从第一个开始
     if (rage.location != NSNotFound) {
       format = [_systemmodel.url substringFromIndex:rage.location];
//         NSLog(@"-------------%@",format);
         if ([format isEqualToString:@".doc"] || [format isEqualToString:@".docx"]) {
             _fileType.image = [UIImage imageNamed:@"w"];
         }else if ([format isEqualToString:@".xls"] || [format isEqualToString:@".xlsx"]){
             _fileType.image = [UIImage imageNamed:@"w(1)"];
         }else if ([format isEqualToString:@".pdf"]){
             _fileType.image = [UIImage imageNamed:@"p"];
         }else{
             _fileType.image = [UIImage imageNamed:@"qit"];
         }
     }else{
          _fileType.image = [UIImage imageNamed:@"qit"];
     }
    _fileLabel.text = [NSString stringWithFormat:@"%@",_systemmodel.fileName];
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
