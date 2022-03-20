//
//  RSSLPieceModel.h
//  OAManage
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSLPieceModel : NSObject

/**
 area = "4.412";
                   did = 49261507;
                   slNo = 1;
 */

@property (nonatomic,strong)NSDecimalNumber * area;

@property (nonatomic,assign)NSInteger did;

@property (nonatomic,assign)NSInteger slNo;

@property (nonatomic,assign)BOOL isbool;

@property (nonatomic,assign)BOOL isSelect;


@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,strong)NSString * turnsNo;


@property (nonatomic,strong)NSString * msid;


@end

NS_ASSUME_NONNULL_END
