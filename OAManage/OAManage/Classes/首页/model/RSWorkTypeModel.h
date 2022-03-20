//
//  RSWorkTypeModel.h
//  OAManage
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSWorkTypeModel : NSObject

@property (nonatomic,assign)NSInteger workTypeId;

@property (nonatomic,strong)NSString * content;

@property (nonatomic,assign)NSInteger diaryId;

@property (nonatomic,strong)NSString * diaryType;

@property (nonatomic,strong)NSString * level;

@property (nonatomic,strong)NSString * result;

@property (nonatomic,assign)BOOL open;


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
+ (instancetype)statusWithDict:(id)array andIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
