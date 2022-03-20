//
//  RSSystemTypeModel.h
//  OAManage
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSystemTypeModel : NSObject
/**
 createTime = "<null>";
               createUser = "<null>";
               id = 1;
               name = "\U65b9\U9488\U3001\U76ee\U6807";
               updateTime = "<null>";
               updateUser = "<null>";*/

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,assign)NSInteger createUser;
@property (nonatomic,assign)NSInteger systemtypeId;

@property (nonatomic,strong)NSString * name;

@property (nonatomic,strong)NSString * updateTime;

@property (nonatomic,assign)NSInteger updateUser;

@end

NS_ASSUME_NONNULL_END
