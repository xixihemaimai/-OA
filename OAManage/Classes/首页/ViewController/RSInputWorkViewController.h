//
//  RSInputWorkViewController.h
//  OAManage
//
//  Created by mac on 2019/12/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface RSInputWorkViewController : RSBaseViewController

//是新增还是修改.add为新增,update为修改
@property (nonatomic,strong)NSString * showType;


//是用来获取上一个页面传递过来工作日志的ID的值
@property (nonatomic,assign)NSInteger auditedId;

@end

NS_ASSUME_NONNULL_END
