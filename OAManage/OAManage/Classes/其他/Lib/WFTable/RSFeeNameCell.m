//
//  RSFeeNameCell.m
//  OAManage
//
//  Created by mac on 2020/10/30.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSFeeNameCell.h"

@implementation RSFeeNameCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 34)];
        _label.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
        _label.layer.borderWidth = 0.5f;
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorWithHexColorStr:@"#666666"];
//        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:_label];
        _label.userInteractionEnabled = YES;
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
