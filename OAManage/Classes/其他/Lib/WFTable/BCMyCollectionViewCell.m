//
//  BCMyCollectionViewCell.m
//  xxxxxxxx
//
//  Created by WF on 2017/1/5.
//  Copyright © 2017年 WF. All rights reserved.
//

#import "BCMyCollectionViewCell.h"
@interface BCMyCollectionViewCell ()


@end
@implementation BCMyCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
        _label.layer.borderWidth = 0.5f;
        _label.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:13.f];
        _label.text=_labelText;
        [self addSubview:_label];
        
    }
    return self;
}
-(void)setLabelText:(NSString *)labelText{
    _labelText = labelText;
    
}

@end
