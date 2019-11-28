//
//  RSNewCustomImageView.m
//  OAManage
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSNewCustomImageView.h"

@implementation RSNewCustomImageView


+ (instancetype)initWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)color andImage:(NSString *)image andUserInteractionEnabled:(BOOL)userInteractionEnabled{
    RSNewCustomImageView * newCustomImageview = [[RSNewCustomImageView alloc]init];
    newCustomImageview.frame = frame;
    newCustomImageview.backgroundColor = color;
    newCustomImageview.image = [UIImage imageNamed:image];
    newCustomImageview.userInteractionEnabled = userInteractionEnabled;
    return newCustomImageview;
}



@end
