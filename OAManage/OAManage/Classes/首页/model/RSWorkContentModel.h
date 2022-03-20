//
//  RSWorkContentModel.h
//  OAManage
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface RSWorkContentModel : NSObject

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,assign)NSInteger createUser;

@property (nonatomic,strong)NSString * diaryDate;

@property (nonatomic,assign)NSInteger workId;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)NSString * summary;

@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,assign)NSInteger updateUser;

@property (nonatomic,strong)NSMutableArray * inCompleteArray;

@property (nonatomic,strong)NSMutableArray * todayPlanArray;

@property (nonatomic,strong)NSMutableArray * tomorrowPlanArray;


@end

NS_ASSUME_NONNULL_END
