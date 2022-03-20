//
//  RSSLFootView.m
//  OAManage
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLFootView.h"

@implementation RSSLFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
       self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5f5f5"];
       UIView * view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCW - 24, 10)];
       view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
       [self.contentView addSubview:view];
       CGRect oldRect = view.bounds;
       oldRect.size.width = SCW - 24;
//       _view = view;
       UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
       
       CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
       maskLayer.path = maskPath.CGPath;
       maskLayer.frame = oldRect;
       view.layer.mask = maskLayer;

    }
    return self;
}

@end
