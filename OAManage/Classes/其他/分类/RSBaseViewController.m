//
//  RSBaseViewController.m
//  OAManage
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSBaseViewController.h"
#import "RSHomeViewController.h"
#import "RSShenHeViewController.h"
#import "RSMenuViewController.h"

#import "RSLoginViewController.h"
@interface RSBaseViewController ()

@end

@implementation RSBaseViewController

- (UITableView *)tableview{
    if (!_tableview) {
       // CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
        //CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight))
       // CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}


- (NetworkTool *)network{
    if (!_network) {
        _network = [[NetworkTool alloc]init];
    }
    return _network;
}




- (ZZQEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[ZZQEmptyView alloc] initWithView:self.view];
        _emptyView.emptyMode = ZZQEmptyViewModeNoData;
        _emptyView.label.text = @"暂无数据";
        [_emptyView.button setTitle:@"点击重新加载" forState:UIControlStateNormal];
        _emptyView.hidden = NO;
        _emptyView.button.hidden = YES;
        _emptyView.showtype = @"0";
        [_emptyView.button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    return _emptyView;
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[IQKeyboardManager sharedManager].enable = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
      self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
      self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    if ([self isKindOfClass:[RSHomeViewController class]]) {
        self.frostedViewController.panGestureEnabled = YES;
    }else{
        self.frostedViewController.panGestureEnabled = NO;
    }
    
    
    
    
    //这边要获取用户信息
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    //已经登录
    NSData * data = [user objectForKey:@"OAUSERMODEL"];
    RSUserModel * usermodel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (![self isKindOfClass:[RSLoginViewController class]]) {
        if (usermodel.appLoginToken.length > 0) {
            self.usermodel = usermodel;
        }else{
            //没有登录中
            [user removeObjectForKey:@"OAUSERMODEL"];
            [user synchronize];
        }
    }
        [self.view addSubview:self.tableview];
        self.tableview.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .topSpaceToView(self.navigationController.navigationBar, 0)
        .bottomSpaceToView(self.view, 0);
    [self.view addSubview:self.emptyView];
}







- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLID = @"CELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}


//FIXME:去掉空格
- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

//公司名称
- (BOOL)isContrainChineseStr:(NSString *)company
{
    NSString *regex = @"^[\u4e00-\u9fa5]{0,19}$";
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate1 evaluateWithObject:company];
    
}




- (BOOL)isEnglishAndChinese:(NSString *)textf{
    //@"^[\u4e00-\u9fa5a-zA-Z]*$" [a-zA-Z\u4e00-\u9fa5]+
    NSString *regex = @"^[a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:textf];
}

-(BOOL)istext:(UITextField *)textf
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    if (textf.text.length<=0||textf.text==nil||[textf.text isEqualToString:@""]||[textf.text isKindOfClass:[NSNull class]]||[[textf.text stringByTrimmingCharactersInSet:set]length]==0)
    {
        return YES;
    }
    else{
        return NO;
    }
}

-(BOOL)isnstring:(NSString *)textf;
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    if (textf.length<=0||textf==nil||[textf isEqualToString:@""]||[textf isKindOfClass:[NSNull class]]||[[textf stringByTrimmingCharactersInSet:set]length]==0)
    {
        return YES;
    }
    else
        return NO;
}
//密码验证
- (BOOL)isValidPassword:(NSString *)pwd {
    //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
    NSString *regex = @"^(""[a-zA-Z]|[0-9]){6,20}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:pwd];
}

//手机号验证
- (BOOL)isTrueMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^1(3|5|7|8|4)\\d{9}";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:mobile];
    
    // NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSString * MOBILE = @"^((13[0-9])|(15[^4])|(18[0,1,2,3,5-9])|(17[0-8])|(19[8,9])|(166)|(147))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
    
}


/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL) validateCarNo:(NSString*) carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    //NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}




/**密码设置有大小写字母和数字*/
- (BOOL)validatePassword:(NSString *)passWord
{
    //NSString *passWordRegex = @"^[a-zA-Z0-9]{6,18}+$";
    //NSString * passWordRegex = @"[0-9a-zA-Z\u4e00-\u9fa5\\.\\*\\)\\(\\+\\$\\[\\?\\\\\\^\\{\\|\\]\\}%%%@\'\",。‘、-【】·！_——=:;；<>《》‘’“”!#~]+";
    
    NSString *passWordRegex = @"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


/* 身份证
 *
 *
 */
-(BOOL)checkUserID:(NSString *)userID
{
    //长度不为18的都排除掉
    if (userID.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}




/**
 *  判断名称是否合法
 *  @param name 名称
 *  @return yes / no
 */
-(BOOL)isNameValid:(NSString *)name
{
    BOOL isValid = NO;
    
    if (name.length > 0)
    {
        for (NSInteger i=0; i<name.length; i++)
        {
            unichar chr = [name characterAtIndex:i];
            
            if (chr < 0x80)
            { //字符
                if (chr >= 'a' && chr <= 'z')
                {
                    isValid = YES;
                }
                else if (chr >= 'A' && chr <= 'Z')
                {
                    isValid = YES;
                }
                else if (chr >= '0' && chr <= '9')
                {
                    isValid = YES;
                }
                else if (chr == '-' || chr == '_')
                {
                    isValid = YES;
                }
                else
                {
                    isValid = NO;
                }
            }
            else if (chr >= 0x4e00 && chr < 0x9fa5)
            { //中文
                isValid = YES;
            }
            else
            { //无效字符
                isValid = NO;
            }
            
            if (!isValid)
            {
                break;
            }
        }
    }
    
    return isValid;
}


// 昵称
- (BOOL) validateNickname:(NSString *)nickname

{
    
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:nickname];
    
}



- (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{2,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//用户名验证 失效
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal string:(NSString *)str;
{
    NSString *hanzi = containChinese ? @"\\u4e00-\\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [phoneTest evaluateWithObject:str];
}


//根据金额内容进行判断，如果是只有整数位，就显示整数金额，如果是有小数位，就取小数位后两位，小数点后若为0则去掉不显示
-(NSString *)cutStr:(double)pNum
{
    
    NSString *res=[NSString stringWithFormat:@"%.2f",pNum];
    if(([res intValue]-pNum)==0.0)
    {
        res=[NSString stringWithFormat:@"%d",(int)pNum];
    }
    return res;
    
}

- (BOOL)isPureNumandCharacters:(NSString *)string
{
    if(string.length!=6)
    {
        return NO;
    }
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}





//获取当前系统时间的时间戳
#pragma mark - 获取当前时间的 时间戳
- (NSInteger)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    //NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    //NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}



//将某个时间转化成 时间戳
#pragma mark - 将某个时间转化成 时间戳
- (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    //NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}


//获取文件的大小
-(float)sizeOfDirectory:(NSString *)dir{
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:dir];
    NSString *pname;
    int64_t s=0;
    while (pname = [direnum nextObject]){
        //NSLog(@"pname   %@",pname);
        NSDictionary *currentdict=[direnum fileAttributes];
        NSString *filesize=[NSString stringWithFormat:@"%@",[currentdict objectForKey:NSFileSize]];
        NSString *filetype=[currentdict objectForKey:NSFileType];
        
        if([filetype isEqualToString:NSFileTypeDirectory]) continue;
        s=s+[filesize longLongValue];
    }
    return s*1.0;
}


//根据路径删除文件
-(BOOL)deleteFileByPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL res=[fileManager removeItemAtPath:path error:nil];
    return res;
   // NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:path]?@"YES":@"NO");
}




- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
  //  [IQKeyboardManager sharedManager].enable = YES;
}



@end
