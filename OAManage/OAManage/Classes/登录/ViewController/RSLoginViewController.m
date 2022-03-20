//
//  RSLoginViewController.m
//  OAManage
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSLoginViewController.h"
#import "JJOptionView.h"
#import "RSMenuViewController.h"
#import "AppDelegate.h"
//模型
#import "RSRoleModel.h"
#import "FSAES128.h"
#import "RSAEncryptor.h"
//新版本首界面
#import "RSMainViewController.h"
#import "RSWKOAmanagerViewController.h"
#import "RSRegisterViewController.h"

typedef void(^Obtain)(BOOL isValue);

@interface RSLoginViewController ()<JJOptionViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)JJOptionView * roleView;
/**账号*/
@property (nonatomic,strong)UITextField * userNameField;
/**密码*/
@property (nonatomic,strong)UITextField * passwordField;
/**这边是保存公钥的一个*/
@property (nonatomic,strong)NSString * PublickKeyTemp;
/**设备唯一标识号*/
@property (nonatomic,strong)NSString * udidTemp;
/**保存角色*/
@property (nonatomic,assign)NSInteger roleInt;

@property (nonatomic,strong) UIButton * loginBtn;

@end

@implementation RSLoginViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.emptyView.hidden = YES;
    self.roleInt = 0;
    self.PublickKeyTemp = @"";
    //logo
    //self.view.backgroundColor = uic;
    self.tableview.hidden = YES;
    
    //这边设置成一个view
    UIView * loginView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH)];
    loginView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:loginView];
    loginView.userInteractionEnabled = YES;
    
    
    //logo
    UIImageView * LoginImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCW/2 - 54, SCH/3 - 54, 108, 108)];
    LoginImageView.image =  [UIImage imageNamed:@"logo"];
    [loginView addSubview:LoginImageView];
    
    
    
    /**
     /    userNameField.sd_layout
     //    .centerXEqualToView(loginView)
     //    .topSpaceToView(LoginImageView, 46)
     //    .widthIs(266)
     //    .heightIs(39)
     */
    
    
    UITextField * userNameField = [[UITextField alloc]initWithFrame:CGRectMake(SCW/2 - 133, CGRectGetMaxY(LoginImageView.frame) + 46, 266, 39)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    //[UIColor colorWithHexColorStr:@"#E0E0E0"]
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#E0E0E0"],NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
    userNameField.attributedPlaceholder = attri;
    userNameField.textAlignment = NSTextAlignmentCenter;

    // [userNameField addTarget:self action:@selector(monitoringInputValues:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    userNameField.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    
    
    //userNameField.borderStyle = UITextBorderStyleRoundedRect;
    userNameField.layer.cornerRadius = 20;
    userNameField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D3D3D3"].CGColor;
    userNameField.layer.borderWidth = 1;
    userNameField.delegate = self;
    userNameField.layer.masksToBounds = YES;
    [loginView addSubview:userNameField];
    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 39)];
    userNameField.leftViewMode = UITextFieldViewModeAlways;
    userNameField.leftView = leftview;
    _userNameField = userNameField;
    
    UITextField * passwordField = [[UITextField alloc]initWithFrame:CGRectMake(SCW/2 - 133, CGRectGetMaxY(userNameField.frame) + 18, 266, 39)];
    NSMutableParagraphStyle *passwordstyle = [[NSMutableParagraphStyle alloc] init];
    passwordstyle.alignment = NSTextAlignmentCenter;
    NSAttributedString * passwordattri = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#E0E0E0"],NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:passwordstyle}];
    passwordField.attributedPlaceholder = passwordattri;
    passwordField.textAlignment = NSTextAlignmentCenter;
    
//    passwordField.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    
    passwordField.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    
    passwordField.layer.cornerRadius = 20;
    passwordField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D3D3D3"].CGColor;
    passwordField.layer.borderWidth = 1;
    passwordField.layer.masksToBounds = YES;
    // [passwordField becomeFirstResponder];
    [loginView addSubview:passwordField];
    _passwordField = passwordField;
    passwordField.delegate = self;
    UIView *leftpasswordview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 39)];
    passwordField.leftViewMode = UITextFieldViewModeAlways;
    passwordField.leftView = leftpasswordview;
    passwordField.secureTextEntry = YES;
    
    
    /**
     roleView.sd_layout
     //    .centerXEqualToView(loginView)
     //    .topSpaceToView(passwordField, 18)
     //    .leftEqualToView(passwordField)
     //    .rightEqualToView(passwordField)
     //    .heightIs(39);
     */
    
    
    JJOptionView * roleView = [[JJOptionView alloc]initWithFrame:CGRectMake(SCW/2 - 133, CGRectGetMaxY(passwordField.frame) + 18, 266, 39)];
    roleView.title = @"用户角色";
    roleView.delegate = self;
    [loginView addSubview:roleView];
    _roleView = roleView;
    
    /**
     .centerXEqualToView(loginView)
    //    .topSpaceToView(roleView, 36)
    //    .leftEqualToView(roleView)
    //    .rightEqualToView(roleView)
    //    .heightIs(39);
     
     */
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"确定" forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(SCW/2 - 133, CGRectGetMaxY(roleView.frame) + 36, 266, 39);
    [loginBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3FE4B1"]];
    [loginBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:Textadaptation(16)];
    [loginView addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(LoginAction:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.enabled = YES;
    _loginBtn = loginBtn;
    
    
    
    //没有账号？注册
    //已有账号，登录
    UILabel * ownLabel = [[UILabel alloc]init];
    ownLabel.text = @"没有账号？";
    CGRect ownRect = [ownLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
    /**
     
     ownLabel.sd_layout
    //    .centerXIs(SCW/2 - 40)
    //    .topSpaceToView(loginBtn, 12.5)
    //    .widthIs(ownRect.size.width)
    //    .heightIs(20);
     */
    
    
    ownLabel.frame = CGRectMake(SCW/2 - ownRect.size.width, CGRectGetMaxY(loginBtn.frame) + 12.5, ownRect.size.width, 20);
    
    ownLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    ownLabel.font = [UIFont systemFontOfSize:12];
    ownLabel.textAlignment = NSTextAlignmentLeft;
    [loginView addSubview:ownLabel];
    
    
        
    //
    //    ownBtn.sd_layout
    //    .leftSpaceToView(ownLabel, 0)
    //    .topEqualToView(ownLabel)
    //    .bottomEqualToView(ownLabel)
    //    .widthIs(userRect.size.width);
    
    //登录
    UIButton * ownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ownBtn setTitle:@"注册" forState:UIControlStateNormal];
    CGRect userRect = [ownBtn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
    ownBtn.frame = CGRectMake(CGRectGetMaxX(ownLabel.frame), CGRectGetMaxY(loginBtn.frame) + 12.5, userRect.size.width, 20);
    
   
    [ownBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
    ownBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [loginView addSubview:ownBtn];
    [ownBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /**
     
     label.sd_layout
    //    .centerXIs(SCW/2 - 90)
    //    //.topSpaceToView(ownLabel, 80)
    //    .bottomSpaceToView(loginView, 10)
    //    .widthIs(disCountrect.size.width)
    //    .heightIs(20);
     */
    UILabel *label = [[UILabel alloc]init];
    label.text = @"登录即代表阅读并同意";
    CGRect disCountrect = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    label.frame = CGRectMake(30, SCH - 30, disCountrect.size.width, 20);
    
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [loginView addSubview:label];
    
    
    
    
    UIButton * userPrivacyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userPrivacyBtn setTitle:@"隐私政策指引" forState:UIControlStateNormal];
    userPrivacyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    CGRect userPrivacy = [userPrivacyBtn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    
    /**
     
     userPrivacyBtn.sd_layout
    //    .topEqualToView(label)
    //    .bottomEqualToView(label)
    //    .leftSpaceToView(label,  0)
    //    .widthIs(userPrivacy.size.width);
     */
    
    userPrivacyBtn.frame = CGRectMake(CGRectGetMaxX(label.frame), SCH - 30, userPrivacy.size.width, 20);
    userPrivacyBtn.tag = 1;
    [userPrivacyBtn addTarget:self action:@selector(jumpInformationAction:) forControlEvents:UIControlEventTouchUpInside];
    [userPrivacyBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
    [loginView addSubview:userPrivacyBtn];
    
    
    /**
     
     andLabel.sd_layout
     //    .topEqualToView(userPrivacyBtn)
     //    .bottomEqualToView(userPrivacyBtn)
     //    .leftSpaceToView(userPrivacyBtn, 0)
     //    .widthIs(15);
     */
    
    UILabel * andLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userPrivacyBtn.frame), SCH - 30, 15, 20)];
    andLabel.text = @"和";
    andLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    andLabel.textAlignment = NSTextAlignmentCenter;
    andLabel.font = [UIFont systemFontOfSize:14];
    [loginView addSubview:andLabel];
    
    UIButton * serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [serviceBtn setTitle:@"用户协议" forState:UIControlStateNormal];
    serviceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    CGRect service = [serviceBtn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    serviceBtn.frame = CGRectMake(CGRectGetMaxX(andLabel.frame), SCH - 30, service.size.width, 20);
    serviceBtn.tag = 2;
    [serviceBtn addTarget:self action:@selector(jumpInformationAction:) forControlEvents:UIControlEventTouchUpInside];
    [serviceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
    [loginView addSubview:serviceBtn];
    
    
//    loginView.sd_layout
//    .centerYEqualToView(self.view)
//    .centerXEqualToView(self.view)
//    .widthIs(SCW)
//    .heightIs(SCH);
    
    
    
//    LoginImageView.sd_layout
//    .centerXIs(SCW/2 - 54)
//    .widthIs(108)
//    .heightEqualToWidth()
//    .topSpaceToView(loginView, 10);
    
    
    
//    userNameField.sd_layout
//    .centerXEqualToView(loginView)
//    .topSpaceToView(LoginImageView, 46)
//    .widthIs(266)
//    .heightIs(39);
//
//    passwordField.sd_layout
//    .centerXEqualToView(loginView)
//    .topSpaceToView(userNameField, 18)
//    .leftEqualToView(userNameField)
//    .rightEqualToView(userNameField)
//    .heightIs(39);
//
//    roleView.sd_layout
//    .centerXEqualToView(loginView)
//    .topSpaceToView(passwordField, 18)
//    .leftEqualToView(passwordField)
//    .rightEqualToView(passwordField)
//    .heightIs(39);
//
//    loginBtn.sd_layout
//    .centerXEqualToView(loginView)
//    .topSpaceToView(roleView, 36)
//    .leftEqualToView(roleView)
//    .rightEqualToView(roleView)
//    .heightIs(39);
//
//    CGRect ownRect = [ownLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
//                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
//    ownLabel.sd_layout
//    .centerXIs(SCW/2 - 40)
//    .topSpaceToView(loginBtn, 12.5)
//    .widthIs(ownRect.size.width)
//    .heightIs(20);
//
//    CGRect userRect = [ownBtn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
//                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
//
//    ownBtn.sd_layout
//    .leftSpaceToView(ownLabel, 0)
//    .topEqualToView(ownLabel)
//    .bottomEqualToView(ownLabel)
//    .widthIs(userRect.size.width);
//
//    label.sd_layout
//    .centerXIs(SCW/2 - 90)
//    //.topSpaceToView(ownLabel, 80)
//    .bottomSpaceToView(loginView, 10)
//    .widthIs(disCountrect.size.width)
//    .heightIs(20);
//
//    userPrivacyBtn.sd_layout
//    .topEqualToView(label)
//    .bottomEqualToView(label)
//    .leftSpaceToView(label,  0)
//    .widthIs(userPrivacy.size.width);
//
//    andLabel.sd_layout
//    .topEqualToView(userPrivacyBtn)
//    .bottomEqualToView(userPrivacyBtn)
//    .leftSpaceToView(userPrivacyBtn, 0)
//    .widthIs(15);
//
//    serviceBtn.sd_layout
//    .leftSpaceToView(andLabel, 0)
//    .topEqualToView(andLabel)
//    .bottomEqualToView(andLabel)
//    .widthIs(service.size.width);
//
    loginBtn.layer.cornerRadius = 20;
    loginBtn.layer.masksToBounds = YES;
    
    
    
    //[loginView layoutSubviews];
    //[loginView setupAutoHeightWithBottomView:label bottomMargin:0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if (textField == _userNameField) {
        if ([temp length] > 0) {
            //这边要对输入的值进行判断有什么角色
            //成功了才可以设置值出来
            _roleView.title = @"用户角色";
            [self reloadRole];
            self.userNameField.text = temp;
        }else{
            _userNameField.text = @"";
            [_userNameField resignFirstResponder];
            _roleView.title = @"用户角色";
            NSMutableArray * array = [NSMutableArray array];
            _roleView.dataSource = array;
        }
    }else{
        if ([temp length] > 0) {
            //密码要加md5
            //加密了
            //temp = [MyMD5 md5:temp];
            _passwordField.text = temp;
        }else{
            [_passwordField resignFirstResponder];
            _passwordField.text = @"";
        }
    }
}


- (void)reloadRole{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSString * canshu = URL_YIGODATA_USERCODE(self.userNameField.text);
    NSString * soapStr = URL_YIGODATA_IOS(URL_LOGINWEBSERVICE, URL_FINDROLE, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:soapStr andURLName:URL_FINDROLE];
//    NSLog(@"===================");
    //NSMutableArray * array = [NSMutableArray arrayWithObjects:@"管理员",@"游客",@"货主",@"超级管理人员",@"服务人员", nil];
    network.successArrayReload = ^(NSMutableArray *array) {
        self.roleView.dataSource = array;
        if (self.roleView.dataSource.count > 0) {
            RSRoleModel * rolemodel = [self.roleView.dataSource objectAtIndex:0];
            self.roleView.title = rolemodel.name;
            self.roleInt = rolemodel.roleID;
        }else{
            self.roleView.title = @"用户角色";
            self.roleInt = 0;
        }
    };
    network.failure = ^(NSDictionary *dict) {
        NSMutableArray * array = [NSMutableArray array];
        self.roleView.dataSource = array;
        self.roleView.title = @"用户角色";
        self.roleInt = 0;
    };
}

- (void)getPublicKeyobtain:(Obtain)obtain{
    //设备的唯一标识号
    NSString * udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    _udidTemp = udid;
    NSString * canshu = URL_YIGODATA_PUBLICKKEY(udid);
    NSString * soapStr = URL_YIGODATA_IOS(URL_LOGINWEBSERVICE, URL_GENPUBLICKEY, canshu);
    NetworkTool * network = [[NetworkTool alloc]init];
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:soapStr andURLName:URL_GENPUBLICKEY];
    //成功
    network.successReload = ^(NSDictionary *dict) {
        self.PublickKeyTemp = dict[@"data"][@"publicKeyStr"];
        if ([self.PublickKeyTemp length] > 1) {
            self.loginBtn.enabled = YES;
            obtain(true);
        }else{
            self.loginBtn.enabled = YES;
            obtain(false);
        }
    };
    //失败
    network.failure = ^(NSDictionary *dict) {
        self.loginBtn.enabled = YES;
        obtain(false);
    };
}


- (void)LoginAction:(UIButton *)logBtn{
    logBtn.enabled = NO;
    NSString *temp = [_userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp length] < 1){
        logBtn.enabled = YES;
        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
        return;
    }
    NSString *passwordtemp = [_passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    passwordtemp = [self delSpaceAndNewline:passwordtemp];
    if ([passwordtemp length] < 1){
        logBtn.enabled = YES;
        [SVProgressHUD showErrorWithStatus:@"请输入登录密码"];
        return;
    }
    if(![self validatePassword:_passwordField.text])
    {
        logBtn.enabled = YES;
        [SVProgressHUD showErrorWithStatus:@"用户名或密码错误,包含了特殊字符"];
        return;
    }
    if (_passwordField.text.length<6)
    {
        logBtn.enabled = YES;
        [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
        return;
    }
    if (_passwordField.text.length>18)
    {
        logBtn.enabled = YES;
        [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
        return;
    }
    if ([_roleView.title isEqualToString:@"用户角色"]) {
        logBtn.enabled = YES;
        [SVProgressHUD showInfoWithStatus:@"请输入正确的用户名，在进行选择角色"];
        return;
    }
    //    if ([self.PublickKeyTemp length] < 1) {
    //self.isValue = [self getPublicKey];
    [self getPublicKeyobtain:^(BOOL success) {
        if (success) {
            jxt_showLoadingHUDTitleMessage(@"正在执行登录中", nil);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.loginBtn.enabled = NO;
                [self loginUserSopaStr];
            });
        }else{
            self.loginBtn.enabled = YES;
            [SVProgressHUD showInfoWithStatus:@"手机网络有问题"];
        }
    }];
    //    }else{
    //        //原来就有值的情况
    //        self.loginBtn.enabled = NO;
    //        [self loginUserSopaStr];
    //    }
}

- (void)loginUserSopaStr{
    //[SVProgressHUD showWithStatus:@"正在登录中......."];
    //[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //账号，密码，角色，AES，唯一标示符，------》公钥加密
    //密码
    NSString * password =[MyMD5 md5:self.passwordField.text];
    //获取当前的时间戳
    NSInteger timeInt = [self getNowTimestamp];
    //NSString * aes = [FSAES128 AES128Encrypt:[NSString stringWithFormat:@"%ld",timeInt] key:@"123456"];
    //保存在本地
    NSString * aes1 = [NSString stringWithFormat:@"%ld",(long)timeInt];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    //拼凑成一个16位的数
    int a = arc4random() % 100000;
    NSString *str = [NSString stringWithFormat:@"%06d", a];
    NSString * const aes2 = [NSString stringWithFormat:@"%@%@",aes1,str];
    [user setObject:aes2 forKey:@"AES"];
    [user synchronize];
    // NSString *const kInitVector = @"16-Bytes--String";
    NSString * data = [NSString stringWithFormat:@"{userCode:'%@',password:'%@',roleId:%ld,aesKey:'%@'}",self.userNameField.text,password,(long)_roleInt,aes2];
    //RSA加密
    NSString * rsaEncryptor = [RSAEncryptor encryptString:data publicKey:self.PublickKeyTemp];
    //网络请求
    NetworkTool * network = [[NetworkTool alloc]init];
    NSString * canshu = URL_YIGODATA_LOGIN(_udidTemp, rsaEncryptor);
    NSString * soapStr = URL_YIGODATA_IOS(URL_LOGINWEBSERVICE, URL_LOGIN, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:soapStr andURLName:URL_LOGIN];
    //获取成功之后的操作
    network.successReload = ^(NSDictionary *dict) {
        
        [SVProgressHUD dismiss];
        self.loginBtn.enabled = NO;
        RSUserModel * usermodel = [[RSUserModel alloc]init];
        usermodel.aesKey = dict[@"aesKey"];
        usermodel.appLoginToken = dict[@"appLoginToken"];
        usermodel.deptName = dict[@"deptName"];
        usermodel.sex = dict[@"sex"];
        usermodel.userCode = dict[@"userCode"];
        usermodel.userId = [dict[@"userId"]integerValue];
        usermodel.userName = dict[@"userName"];
        usermodel.deptId = [dict[@"deptId"] integerValue];
        usermodel.empId = [dict[@"empId"] integerValue];
        usermodel.empName = dict[@"empName"];
        
        usermodel.AM_Requisition = [dict[@"flowAccess"][@"AM_Requisition"]boolValue];
        usermodel.AM_SetlleIn = [dict[@"flowAccess"][@"AM_SetlleIn"]boolValue];
        usermodel.BL_OutNotice = [dict[@"flowAccess"][@"BL_OutNotice"]boolValue];
        usermodel.BM_MtlReturn = [dict[@"flowAccess"][@"BM_MtlReturn"]boolValue];
        usermodel.BM_OutNotice = [dict[@"flowAccess"][@"BM_OutNotice"]boolValue];
        usermodel.BM_Transfer = [dict[@"flowAccess"][@"BM_Transfer"]boolValue];
        usermodel.BS_OutNotice = [dict[@"flowAccess"][@"BS_OutNotice"]boolValue];
        usermodel.ES_OutNotice = [dict[@"flowAccess"][@"ES_OutNotice"]boolValue];
        usermodel.ES_Transfer = [dict[@"flowAccess"][@"ES_Transfer"]boolValue];
        usermodel.FG_EngQuotation = [dict[@"flowAccess"][@"FG_EngQuotation"]boolValue];
        usermodel.FG_ProcessProduct = [dict[@"flowAccess"][@"FG_ProcessProduct"]boolValue];
        usermodel.FG_ProcessProtocol = [dict[@"flowAccess"][@"FG_ProcessProtocol"]boolValue];
        usermodel.FG_ProfitQuote = [dict[@"flowAccess"][@"FG_ProfitQuote"]boolValue];
        usermodel.Flow_Advertising = [dict[@"flowAccess"][@"Flow_Advertising"]boolValue];
        usermodel.Flow_ApplyActivity = [dict[@"flowAccess"][@"Flow_ApplyActivity"]boolValue];
        usermodel.Flow_ApplyLeave = [dict[@"flowAccess"][@"Flow_ApplyLeave"]boolValue];
        usermodel.Flow_Become = [dict[@"flowAccess"][@"Flow_Become"]boolValue];
        usermodel.Flow_BreakDown = [dict[@"flowAccess"][@"Flow_BreakDown"]boolValue];
        usermodel.Flow_Business = [dict[@"flowAccess"][@"Flow_Business"]boolValue];
        usermodel.Flow_Cachet = [dict[@"flowAccess"][@"Flow_Cachet"]boolValue];
        usermodel.Flow_Chapter = [dict[@"flowAccess"][@"Flow_Chapter"]boolValue];
        usermodel.Flow_Contract = [dict[@"flowAccess"][@"Flow_Contract"]boolValue];
        usermodel.Entertain = [dict[@"flowAccess"][@"Entertain"]boolValue];
        usermodel.Flow_Entertain = [dict[@"flowAccess"][@"Flow_Entertain"]boolValue];
        usermodel.Flow_EquipService = [dict[@"flowAccess"][@"Flow_EquipService"]boolValue];
        usermodel.Flow_Equipment = [dict[@"flowAccess"][@"Flow_Equipment"]boolValue];
        usermodel.Flow_FileUpdate = [dict[@"flowAccess"][@"Flow_FileUpdate"]boolValue];
        usermodel.Flow_FixedAssets = [dict[@"flowAccess"][@"Flow_FixedAssets"]boolValue];
        usermodel.Flow_HumanNeed = [dict[@"flowAccess"][@"Flow_HumanNeed"]boolValue];
        usermodel.Flow_InCachet = [dict[@"flowAccess"][@"Flow_InCachet"]boolValue];
        usermodel.Flow_InvestContract = [dict[@"flowAccess"][@"Flow_InvestContract"]boolValue];
        usermodel.Flow_Payment = [dict[@"flowAccess"][@"Flow_Payment"]boolValue];
        usermodel.Flow_PostMove = [dict[@"flowAccess"][@"Flow_PostMove"]boolValue];
        usermodel.Flow_Purchase = [dict[@"flowAccess"][@"Flow_Purchase"]boolValue];
        usermodel.Flow_Quit = [dict[@"flowAccess"][@"Flow_Quit"]boolValue];
        usermodel.Flow_Receptions = [dict[@"flowAccess"][@"Flow_Receptions"]boolValue];
        usermodel.Flow_Restaurant = [dict[@"flowAccess"][@"Flow_Restaurant"]boolValue];
        usermodel.Flow_RsApplyLeave = [dict[@"flowAccess"][@"Flow_RsApplyLeave"]boolValue];
        usermodel.Flow_RsBreakDown = [dict[@"flowAccess"][@"Flow_RsBreakDown"]boolValue];
        usermodel.Flow_RsPayment = [dict[@"flowAccess"][@"Flow_RsPayment"]boolValue];
        usermodel.Flow_SaleContract = [dict[@"flowAccess"][@"Flow_SaleContract"]boolValue];
        usermodel.Flow_SupplierConsume = [dict[@"flowAccess"][@"Flow_SupplierConsume"]boolValue];
        usermodel.Flow_UsedIdle = [dict[@"flowAccess"][@"Flow_UsedIdle"]boolValue];
        usermodel.Flow_VehicleReservation = [dict[@"flowAccess"][@"Flow_VehicleReservation"]boolValue];
        usermodel.Flow_WasteDisposal = [dict[@"flowAccess"][@"Flow_WasteDisposal"]boolValue];
        usermodel.SC_PayIn = [dict[@"flowAccess"][@"SC_PayIn"]boolValue];
        usermodel.SL_OutNotice = [dict[@"flowAccess"][@"SL_OutNotice"]boolValue];
        usermodel.SL_Transfer = [dict[@"flowAccess"][@"SL_Transfer"]boolValue];
        usermodel.SM_SendNotice = [dict[@"flowAccess"][@"SM_SendNotice"]boolValue];
        usermodel.SM_Transfer = [dict[@"flowAccess"][@"SM_Transfer"]boolValue];
        usermodel.UseCar = [dict[@"flowAccess"][@"UseCar"]boolValue];
        
        usermodel.Flow_WorkOvertime =  [dict[@"flowAccess"][@"Flow_WorkOvertime"]boolValue];
                usermodel.Flow_SpecialApplication = [dict[@"flowAccess"][@"Flow_SpecialApplication"]boolValue];
        
        usermodel.OA_Market_Home  = [dict[@"flowAccess"][@"OA_Market_Home"]boolValue];
        usermodel.OA_BM_IO = [dict[@"flowAccess"][@"OA_BM_IO"]boolValue];
        usermodel.OA_SL_IO = [dict[@"flowAccess"][@"OA_SL_IO"]boolValue];
        usermodel.OA_Lease = [dict[@"flowAccess"][@"OA_Lease"]boolValue];
        usermodel.OA_Ledger  = [dict[@"flowAccess"][@"OA_Ledger"]boolValue];
        usermodel.OA_Ledger_Dtl = [dict[@"flowAccess"][@"OA_Ledger_Dtl"]boolValue];
        
        usermodel.OA_Market_Fee = [dict[@"flowAccess"][@"OA_Market_Fee"]boolValue];
               usermodel.OA_Market_Dealer_Fee  = [dict[@"flowAccess"][@"OA_Market_Dealer_Fee"]boolValue];
               usermodel.OA_Market_Pay_In  = [dict[@"flowAccess"][@"OA_Market_Pay_In"]boolValue];
        
        usermodel.OA_Market_Settle_In  = [dict[@"flowAccess"][@"OA_Market_Settle_In"]boolValue];
        
        
        
        
        
        
        [MiPushSDK setAccount:[NSString stringWithFormat:@"%ld",(long)usermodel.userId]];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:usermodel];
        [user setObject:data forKey:@"OAUSERMODEL"];
        [user synchronize];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            jxt_dismissHUD();
            //登录之后要获取用户信息，然后在跳转到下面的界面
            //改变根控制器
            RSMainViewController * mainVc = [[RSMainViewController alloc]init];
            AppDelegate * appdelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
            appdelegate.window.rootViewController = mainVc;
        });
    };
    network.failure = ^(NSDictionary *dict) {
        self.loginBtn.enabled = YES;
        jxt_dismissHUD();
        [user removeObjectForKey:@"AES"];
        [user removeObjectForKey:@"OAUSERMODEL"];
        [user synchronize];
    };
}

- (void)optionView:(JJOptionView *)optionView selectedIndex:(NSInteger)selectedIndex {
    RSRoleModel * rolemodel = [optionView.dataSource objectAtIndex:selectedIndex];
    _roleInt = rolemodel.roleID;
    
}

//用户协议指引或者隐私政策指引
- (void)jumpInformationAction:(UIButton *)btn{
    RSWKOAmanagerViewController * wkOAstr = [[RSWKOAmanagerViewController alloc]init];
    if (btn.tag == 1) {
        wkOAstr.type = @"5";
    }else{
        wkOAstr.type = @"6";
    }
    [self.navigationController pushViewController:wkOAstr animated:YES];
}

- (void)registerAction:(UIButton *)registerBtn{
    RSRegisterViewController * registerVc = [[RSRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVc animated:YES
     ];
    registerVc.registeUser = ^(NSString * _Nonnull userCode) {
        self.userNameField.text = userCode;
        [self.userNameField resignFirstResponder];
        [self reloadRole];
    };
}

@end
