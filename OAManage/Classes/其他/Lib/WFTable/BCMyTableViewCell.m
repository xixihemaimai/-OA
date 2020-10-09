//
//  BCMyTableViewCell.m
//  xxxxxxxx
//
//  Created by WF on 2017/1/5.
//  Copyright © 2017年 WF. All rights reserved.
//

#import "BCMyTableViewCell.h"




@implementation BCMyTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        _label = [[RSMyLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 34)];
        _label.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
        _label.layer.borderWidth = 0.5f;
        _label.textAlignment = NSTextAlignmentLeft;
        _label.textColor = [UIColor colorWithHexColorStr:@"#666666"];
//        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:_label];
        _label.userInteractionEnabled = YES;
        
        UIButton * detailedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        detailedBtn.frame = CGRectMake(50, 0, 50, 40);
        [detailedBtn setTitle:@"明细" forState:UIControlStateNormal];
        [detailedBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
        detailedBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_label addSubview:detailedBtn];
        _detailedBtn = detailedBtn;
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
