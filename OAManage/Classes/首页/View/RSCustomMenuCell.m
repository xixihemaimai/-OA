//
//  RSCustomMenuCell.m
//  OAManage
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSCustomMenuCell.h"

@implementation RSCustomMenuCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
     
        //图片
        UIImageView * menuImageView = [[UIImageView alloc]init];
        menuImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:menuImageView];
        _menuImageView = menuImageView;
        //文字
        UILabel * menuLabel = [[UILabel alloc]init];
        menuLabel.textAlignment = NSTextAlignmentLeft;
        menuLabel.font = [UIFont systemFontOfSize:Textadaptation(16)];
        menuLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        [self.contentView addSubview:menuLabel];
        _menuLabel = menuLabel;
        //向右的图片
        UIImageView * menuRightView = [[UIImageView alloc]init];
        menuRightView.contentMode = UIViewContentModeScaleAspectFill;
        menuRightView.image = [UIImage imageNamed:@"向右"];
        [self.contentView addSubview:menuRightView];
        
        
        
        
        if (IS_IPHONE) {
            menuImageView.sd_layout
            .leftSpaceToView(self.contentView, 21)
            .centerYEqualToView(self.contentView)
            .widthIs((19 * SCW) / SCW)
            .heightEqualToWidth();
            
            menuLabel.sd_layout
            .leftSpaceToView(menuImageView, 7)
            .centerYEqualToView(self.contentView)
            .widthRatioToView(self.contentView, 0.4)
            .heightIs(23);
            
            menuRightView.sd_layout
            .rightSpaceToView(self.contentView, 12)
            .centerYEqualToView(self.contentView)
            .widthIs((9 / SCW) * SCW)
            .heightIs(15);
            
        }else{
            if (DEVICES_IS_PRO_12_9) {
                menuImageView.sd_layout
                .leftSpaceToView(self.contentView, 21)
                .centerYEqualToView(self.contentView)
                .widthIs(19 * SCALE_TO_PRO )
                .heightEqualToWidth();
                
                menuLabel.sd_layout
                .leftSpaceToView(menuImageView, 7)
                .centerYEqualToView(self.contentView)
                .widthRatioToView(self.contentView, 0.4)
                .heightIs(23);
                
                menuRightView.sd_layout
                .rightSpaceToView(self.contentView, 12)
                .centerYEqualToView(self.contentView)
                .widthIs((9 / SCW) * SCW)
                .heightIs(15);
                
            }else{
                menuImageView.sd_layout
                .leftSpaceToView(self.contentView, 21)
                .centerYEqualToView(self.contentView)
                .widthIs(19  * SCALE_TO_PRO)
                .heightEqualToWidth();
                
                menuLabel.sd_layout
                .leftSpaceToView(menuImageView, 7)
                .centerYEqualToView(self.contentView)
                .widthRatioToView(self.contentView, 0.4)
                .heightIs(23);
                
                menuRightView.sd_layout
                .rightSpaceToView(self.contentView, 12)
                .centerYEqualToView(self.contentView)
                .widthIs((9 / SCW) * SCW)
                .heightIs(15);
                
                
            }
            
            
        }
       

    }
    return self;
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
