//
//  RSNewCustomLabel.m
//  OAManage
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSNewCustomLabel.h"

@implementation RSNewCustomLabel



+ (instancetype)initWithFrame:(CGRect)frame andFont:(UIFont *)font andBackgroundColor:(UIColor *)color andText:(NSString *)text andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)textAlignment andNumberOfLines:(NSInteger)numberOfLines andUserInteractionEnabled:(BOOL)userInteractionEnabled{
    
    RSNewCustomLabel * newCustomlabel = [[RSNewCustomLabel alloc]init];
    newCustomlabel.frame = frame;
    newCustomlabel.font = font;
    newCustomlabel.backgroundColor = color;
    newCustomlabel.text = text;
    newCustomlabel.textAlignment = textAlignment;
    newCustomlabel.numberOfLines = numberOfLines;
    newCustomlabel.userInteractionEnabled = userInteractionEnabled;
    return newCustomlabel;
}


@end
