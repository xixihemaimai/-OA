//
//  RSInformationModel.h
//  OAManage
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSInformationModel : NSObject

@property (nonatomic,strong)NSString * informationID;

@property (nonatomic,strong)NSString * title;


@property (nonatomic,assign)NSInteger pagerank;

@property (nonatomic,strong)NSString * url;



@end

NS_ASSUME_NONNULL_END
