//
//  RSMailModel.h
//  OAManage
//
//  Created by mac on 2019/11/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSMailModel : NSObject
/*
工号    code
姓名    name
性别    sex
部门    department
职位    position
联系电话1    phone1
联系电话2    phone2
联系电话3    phone3
电子邮箱    email
*/

@property (nonatomic,strong)NSString * code;
@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)NSString * sex;
@property (nonatomic,strong)NSString * department;
@property (nonatomic,strong)NSString * position;
@property (nonatomic,strong)NSString * phone1;
@property (nonatomic,strong)NSString * phone2;
@property (nonatomic,strong)NSString * phone3;
@property (nonatomic,strong)NSString * email;


@end

NS_ASSUME_NONNULL_END
