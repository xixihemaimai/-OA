//
//  RSTouchModel.h
//  OAManage
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSTouchModel : NSObject

/**
 billDate = "2019-09-19";
            deaName = "\U53a6\U95e8\U8fc5\U53d1\U77f3\U4e1a";
            msids = HXAE027404;
            no = BMJK20190919001;
            status = 10;
            totalVaQty = "2.254";
 */
@property (nonatomic,strong)NSString * billDate;

@property (nonatomic,strong)NSString * no;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSDecimalNumber * totalVaQty;

@property (nonatomic,strong)NSString * msids;

@property (nonatomic,strong)NSString * deaName;

@property (nonatomic,assign)NSInteger billId;


@end

NS_ASSUME_NONNULL_END
