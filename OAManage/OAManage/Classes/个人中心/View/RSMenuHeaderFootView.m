//
//  RSMenuHeaderFootView.m
//  OAManage
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSMenuHeaderFootView.h"

@implementation RSMenuHeaderFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
    }
    return self;
}

@end
