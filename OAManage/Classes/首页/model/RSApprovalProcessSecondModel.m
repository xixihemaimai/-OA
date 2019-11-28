//
//  RSApprovalProcessSecondModel.m
//  OAManage
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSApprovalProcessSecondModel.h"

@implementation RSApprovalProcessSecondModel


+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    RSApprovalProcessSecondModel *status = [[RSApprovalProcessSecondModel alloc] init];
    status.concreteContent = @"展会海报设计展会海报设计展会海报设计展会海报设计展会海报设计展会海报设计展会海报设计展会海报设计展会海报设计展会海报设计展会海报设计展会海报设计";
    status.outResult =  @"输出结果:关于海西OA重新升级相关通知关于海西OA重新升级相关通知关于海西OA重新升级相关通知关于海西OA重新升级相关通知关于海西OA重新升级相关通知关于海西OA重新升级相关通知关于海西OA重新升级相关通知关于海西OA重新升级相关通知";
    status.information = @"重要程度:低";
    status.open = false;
    return status;
}

- (CGFloat)cellH{
    // 设置具体内容
    CGFloat concreteContentX = 10;
    CGFloat concreteContentY = 0;
    // 根据label文本的内容和字体的大小计算出文本的范围
    CGRect concreteContentRect = [self.concreteContent boundingRectWithSize:CGSizeMake(SCW - 100, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _concreteContentFrame = CGRectMake(concreteContentX, concreteContentY, concreteContentRect.size.width, concreteContentRect.size.height);
    _oepnBtnFrame = CGRectMake(SCW - 80, 0, 50, 30);
    CGFloat cellH = 0;
    if (self.open) {
        if (concreteContentRect.size.height <= 30.f) {
            concreteContentRect.size.height = 34.f;
             _concreteContentFrame = CGRectMake(concreteContentX, concreteContentY, concreteContentRect.size.width, concreteContentRect.size.height);
        }
        _midFrame = CGRectMake(9, CGRectGetMaxY(_concreteContentFrame) + 6.5, SCW - 48, 0.5);
        //重要程度
        CGRect informationRect = [self.information boundingRectWithSize:CGSizeMake(SCW - 50, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        _informationFrame = CGRectMake(10, CGRectGetMaxY(_midFrame) + 6.5, informationRect.size.width, informationRect.size.height + 10);
        //输出结果
        CGRect outResultRect = [self.outResult boundingRectWithSize:CGSizeMake(SCW - 50, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin
        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        _outResultFrame =  CGRectMake(10, CGRectGetMaxY(_informationFrame) + 6.5, outResultRect.size.width, outResultRect.size.height + 10);
        _viewFrame = CGRectMake(15, 5, SCW - 30, CGRectGetMaxY(_outResultFrame));
        CGFloat maxY = CGRectGetMaxY(_viewFrame) + 10;
        cellH = maxY;
    }else{
        if (concreteContentRect.size.height <= 30.f) {
            concreteContentRect.size.height = 34.f;
             _concreteContentFrame = CGRectMake(concreteContentX, concreteContentY, concreteContentRect.size.width, concreteContentRect.size.height);
        }
        _viewFrame = CGRectMake(15, 5, SCW - 30, concreteContentRect.size.height);
        CGFloat maxY = CGRectGetMaxY(_viewFrame) + 10;
        cellH = maxY;
    }
    return cellH;
}

@end
