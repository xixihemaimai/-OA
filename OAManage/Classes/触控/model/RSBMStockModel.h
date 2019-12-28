//
//  RSBMStockModel.h
//  OAManage
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSBMStockModel : NSObject

/**
 blockNo = "HXAC005546/2";
            did = 15292502;
            msid = HXAC005546;
            mtlName = "\U7389\U6d1e\U77f3";
            volume = "6.177";
 
 */

@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,assign)NSInteger  did;

@property (nonatomic,strong)NSString * msid;

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,strong)NSDecimalNumber * volume;
@end

NS_ASSUME_NONNULL_END
