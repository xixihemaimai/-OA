//
//  RSBaseViewController.h
//  OAManage
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZZQEmptyView,NetworkTool,RSUserModel;
@interface RSBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic,strong) ZZQEmptyView * emptyView;

@property (nonatomic,strong)NetworkTool * network;

/**用户信息模型*/
@property (nonatomic,strong)RSUserModel * usermodel;

//FIXME:去掉空格
- (NSString *)delSpaceAndNewline:(NSString *)string;

-(BOOL)istext:(UITextField *)textf;

-(BOOL)isnstring:(NSString *)textf;
//密码验证
- (BOOL)isValidPassword:(NSString *)pwd;

//手机号验证
-(BOOL)isTrueMobile:(NSString *)mobile;
//6位数字密码
- (BOOL)isPureNumandCharacters:(NSString *)string;

//数字验证
- (BOOL) deptNumInputShouldNumber:(NSString *)str;

//判断中文
- (BOOL)isContrainChineseStr:(NSString *)company;

//昵称
- (BOOL) validateNickname:(NSString *)nickname;

//用户名验证

- (BOOL) validateUserName:(NSString *)name;
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal string:(NSString *)str;

//根据金额内容进行判断，如果是只有整数位，就显示整数金额，如果是有小数位，就取小数位后两位，小数点后若为0则去掉不显示
-(NSString *)cutStr:(double)pNum;

/**密码设置成有字母和数字*/
- (BOOL) validatePassword:(NSString *)passWord;
/**
 *  判断名称是否合法
 *  @param name 名称
 *  @return yes / no
 */
-(BOOL)isNameValid:(NSString *)name;

/*
 * 身份证
 */
-(BOOL)checkUserID:(NSString *)userID;

/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL) validateCarNo:(NSString*) carNo;
/**
 只能是中文和英文
 */
- (BOOL)isEnglishAndChinese:(NSString *)textf;

//获取当前系统时间的时间戳

#pragma mark - 获取当前时间的 时间戳

-(NSInteger)getNowTimestamp;


//将某个时间转化成 时间戳

#pragma mark - 将某个时间转化成 时间戳

-(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;



@end


