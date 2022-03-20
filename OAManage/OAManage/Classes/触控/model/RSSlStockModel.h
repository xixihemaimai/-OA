//
//  RSSlStockModel.h
//  OAManage
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSlStockModel : NSObject

/**
 area = "59.635";
 blockNo = "HXAG011593/TJM098";
 msid = HXAG011593;
 mtlName = "\U610f\U5927\U5229\U7070";
 */
@property (nonatomic,strong)NSDecimalNumber * area;

@property (nonatomic,strong)NSString * blockNo;

@property (nonatomic,strong)NSString * msid;

@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,strong)NSString * turnsNo;


@property (nonatomic,strong)NSMutableArray * piece;




@end

NS_ASSUME_NONNULL_END
