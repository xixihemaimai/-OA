//
//  RSWorkTypeModel.m
//  OAManage
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSWorkTypeModel.h"

@implementation RSWorkTypeModel

+ (NSDictionary * )mj_replacedKeyFromPropertyName
{
    return @{
        @"workTypeId" : @"id"
        };
}

//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{
//             @"workTypeId" : @"id"
//             };
//}

+ (instancetype)statusWithDict:(id)array andIndex:(NSInteger)index
{
    RSWorkTypeModel * status = [[RSWorkTypeModel alloc] init];
    NSString * content = [array objectForKey:@"content"];
    status.content = [NSString stringWithFormat:@"%02ld %@",index + 1,content];
    status.diaryType =[array objectForKey:@"diaryType"];
    status.level = [NSString stringWithFormat:@"重要层度: %@",[array objectForKey:@"level"]];
    status.diaryId = [[array objectForKey:@"diaryId"] integerValue];
    status.workTypeId = [[array objectForKey:@"id"] integerValue];
    status.result = [NSString stringWithFormat:@"输出结果: %@",[array objectForKey:@"result"]];
    status.open = false;
    return status;
}



- (CGFloat)cellH{
    // 设置具体内容
    CGFloat concreteContentX = 10;
    CGFloat concreteContentY = 5;
    // 根据label文本的内容和字体的大小计算出文本的范围
    CGRect concreteContentRect = [self.content boundingRectWithSize:CGSizeMake(SCW - 100, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _concreteContentFrame = CGRectMake(concreteContentX, concreteContentY, concreteContentRect.size.width, concreteContentRect.size.height);
    _oepnBtnFrame = CGRectMake(SCW - 80, 5, 50, 30);
    CGFloat cellH = 0;
    if (self.open) {
        if (concreteContentRect.size.height <= 30.f) {
            concreteContentRect.size.height = 34.f;
             _concreteContentFrame = CGRectMake(concreteContentX, concreteContentY, concreteContentRect.size.width, concreteContentRect.size.height);
        }
        _midFrame = CGRectMake(9, CGRectGetMaxY(_concreteContentFrame) + 2, SCW - 48, 0.5);
        //重要程度
        CGRect informationRect = [self.level boundingRectWithSize:CGSizeMake(SCW - 50, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        _informationFrame = CGRectMake(10, CGRectGetMaxY(_midFrame) + 2, informationRect.size.width, informationRect.size.height + 10);
        //输出结果
        CGRect outResultRect = [self.result boundingRectWithSize:CGSizeMake(SCW - 50, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin
        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        _outResultFrame =  CGRectMake(10, CGRectGetMaxY(_informationFrame) + 2, outResultRect.size.width, outResultRect.size.height + 10);
        _viewFrame = CGRectMake(15, 5, SCW - 30, CGRectGetMaxY(_outResultFrame));
        CGFloat maxY = CGRectGetMaxY(_viewFrame) + 5;
        cellH = maxY;
    }else{
        if (concreteContentRect.size.height <= 30.f) {
            concreteContentRect.size.height = 34.f;
             _concreteContentFrame = CGRectMake(concreteContentX, concreteContentY, concreteContentRect.size.width, concreteContentRect.size.height);
             _viewFrame = CGRectMake(15, 5, SCW - 30, concreteContentRect.size.height + 5);
        }
        else{
             _viewFrame = CGRectMake(15, 5, SCW - 30, concreteContentRect.size.height + 10);
        }
       
        CGFloat maxY = CGRectGetMaxY(_viewFrame) + 5;
        cellH = maxY;
    }
    return cellH;
}


@end
