//
//  RSApprovalProcessSecondModel.h
//  OAManage
//
//  Created by mac on 2019/11/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSApprovalProcessSecondModel : NSObject


//具体内容
@property (nonatomic,strong)NSString * concreteContent;

//输出结果
@property (nonatomic,strong)NSString * outResult;
//是否展开
@property (nonatomic,assign)BOOL open;

//重要程度
@property (nonatomic,strong)NSString * information;




/**中间view的frame*/
@property (nonatomic,assign) CGRect viewFrame;

/**展开或者关闭的按键frame*/
@property (nonatomic,assign) CGRect oepnBtnFrame;
/**具体内容frame */
@property (nonatomic,assign) CGRect concreteContentFrame;
//分隔线
@property (nonatomic,assign) CGRect midFrame;
/** 重要程度frame */
@property (nonatomic,assign) CGRect informationFrame;
/** 输出结果的frame */
@property (nonatomic,assign) CGRect outResultFrame;
/** cell的高度 */
@property (nonatomic,assign) CGFloat cellH;




//提供一个模型
+ (instancetype)statusWithDict:(NSDictionary *)dict;



@end

NS_ASSUME_NONNULL_END
