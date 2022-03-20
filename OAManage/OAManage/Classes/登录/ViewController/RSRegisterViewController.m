//
//  RSRegisterViewController.m
//  OAManage
//
//  Created by mac on 2019/12/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSRegisterViewController.h"

@interface RSRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField * accountTextfield;

@property (nonatomic,strong)UITextField * nicknameTextfield;

@property (nonatomic,strong)UITextField * passwordTextfield;

@property (nonatomic,strong)UITextField * secondPasswordTextfield;
//是否账号重复 false 账号重复 true账号没有重复
@property (nonatomic,assign)BOOL isRepeat;

@end

@implementation RSRegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.emptyView.hidden = YES;
    self.isRepeat = false;
    [self setUI];
}

- (void)setUI{
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(54, 64, SCW - 108, SCH - 128)];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:contentView];
    
//    contentView.sd_layout
//    .centerXEqualToView(self.view)
//    .centerYEqualToView(self.view)
//    .leftSpaceToView(self.view, 54)
//    .rightSpaceToView(self.view, 54)
//    .topSpaceToView(self.view, 64)
//    .bottomSpaceToView(self.view, 64);
        
    //请填写一下注册信息
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 13, contentView.yj_width, 28)];
    titleLabel.text = @"请填写一下注册信息";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:titleLabel];
    
//    titleLabel.sd_layout
//    .leftSpaceToView(contentView, 0)
//    .rightSpaceToView(contentView, 0)
//    .topSpaceToView(contentView, 13)
//    .heightIs(28);
    
    //账号
    UILabel * accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 26, contentView.yj_width, 16.5)];
    accountLabel.text = @"账号";
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.font = [UIFont systemFontOfSize:12];
    accountLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [contentView addSubview:accountLabel];
    
//    accountLabel.sd_layout
//    .leftSpaceToView(contentView, 0)
//    .rightSpaceToView(contentView, 0)
//    .topSpaceToView(titleLabel, 26)
//    .heightIs(16.5);
    
    //账号的输入
    UITextField * accountTextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(accountLabel.frame) + 5, contentView.yj_width, 20)];
    accountTextfield.placeholder = @"请输入账号";
    accountTextfield.delegate = self;
    accountTextfield.font = [UIFont systemFontOfSize:12];
    accountTextfield.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    [contentView addSubview:accountTextfield];
    _accountTextfield = accountTextfield;
    
//    accountTextfield.sd_layout
//    .leftEqualToView(accountLabel)
//    .rightEqualToView(accountLabel)
//    .topSpaceToView(accountLabel, 5)
//    .heightIs(20);
    
    //分隔线
    UIView * accountView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(accountTextfield.frame) + 5, contentView.yj_width, 0.5)];
    accountView.backgroundColor = [UIColor colorWithHexColorStr:@"#D3D3D3"];
    [contentView addSubview:accountView];
    
//    accountView.sd_layout
//    .leftEqualToView(accountTextfield)
//    .rightEqualToView(accountTextfield)
//    .topSpaceToView(accountTextfield, 5)
//    .heightIs(0.5);
    
    //昵称
    UILabel * nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(accountView.frame) + 14.5, contentView.yj_width, 16.5)];
    nicknameLabel.text = @"昵称";
    nicknameLabel.textAlignment = NSTextAlignmentLeft;
    nicknameLabel.font = [UIFont systemFontOfSize:12];
    nicknameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [contentView addSubview:nicknameLabel];
    
//    nicknameLabel.sd_layout
//    .leftEqualToView(accountView)
//    .rightEqualToView(accountView)
//    .topSpaceToView(accountView, 14.5)
//    .heightIs(16.5);
    
    //昵称输入
    UITextField * nicknameTextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nicknameLabel.frame) + 5, contentView.yj_width, 20)];
    nicknameTextfield.placeholder = @"请输入昵称";
    nicknameTextfield.delegate = self;
    nicknameTextfield.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    nicknameTextfield.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:nicknameTextfield];
    _nicknameTextfield = nicknameTextfield;
    
//    nicknameTextfield.sd_layout
//    .leftEqualToView(nicknameLabel)
//    .rightEqualToView(nicknameLabel)
//    .topSpaceToView(nicknameLabel, 5)
//    .heightIs(20);
    
    //分隔线
    UIView * nicknameView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nicknameTextfield.frame) + 5, contentView.yj_width, 0.5)];
    nicknameView.backgroundColor = [UIColor colorWithHexColorStr:@"#D3D3D3"];
    [contentView addSubview:nicknameView];
//
//    nicknameView.sd_layout
//    .leftEqualToView(nicknameTextfield)
//    .rightEqualToView(nicknameTextfield)
//    .topSpaceToView(nicknameTextfield, 5)
//    .heightIs(0.5);
    
    //密码
    UILabel * passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nicknameView.frame) + 14.5, contentView.yj_width, 16.5)];
    passwordLabel.text = @"密码";
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.font = [UIFont systemFontOfSize:12];
    passwordLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [contentView addSubview:passwordLabel];
    
//    passwordLabel.sd_layout
//    .leftEqualToView(nicknameView)
//    .rightEqualToView(nicknameView)
//    .topSpaceToView(nicknameView, 14.5)
//    .heightIs(16.5);
    
    //密码输入
    UITextField * passwordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(passwordLabel.frame) + 5, contentView.yj_width, 20)];
    passwordTextfield.placeholder = @"请输入密码";
    passwordTextfield.delegate = self;
    passwordTextfield.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    passwordTextfield.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:passwordTextfield];
    _passwordTextfield = passwordTextfield;
    
//    passwordTextfield.sd_layout
//    .leftEqualToView(passwordLabel)
//    .rightEqualToView(passwordLabel)
//    .topSpaceToView(passwordLabel, 5)
//    .heightIs(20);
    
    //分隔线
    UIView * passwordView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(passwordTextfield.frame) + 5, contentView.yj_width, 0.5)];
    passwordView.backgroundColor = [UIColor colorWithHexColorStr:@"#D3D3D3"];
    [contentView addSubview:passwordView];
    
//    passwordView.sd_layout
//    .leftEqualToView(passwordTextfield)
//    .rightEqualToView(passwordTextfield)
//    .topSpaceToView(passwordTextfield, 5)
//    .heightIs(0.5);
    
    //再次确认密码
    UILabel * secondPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(passwordView.frame) + 5, contentView.yj_width, 16.5)];
    secondPasswordLabel.text = @"确认密码";
    secondPasswordLabel.textAlignment = NSTextAlignmentLeft;
    secondPasswordLabel.font = [UIFont systemFontOfSize:12];
    secondPasswordLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    [contentView addSubview:secondPasswordLabel];
    
//    secondPasswordLabel.sd_layout
//    .leftEqualToView(passwordView)
//    .rightEqualToView(passwordView)
//    .topSpaceToView(passwordView, 5)
//    .heightIs(16.5);
       
    //确认密码的输入
    UITextField * secondPasswordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondPasswordLabel.frame) + 5, contentView.yj_width, 20)];
    secondPasswordTextfield.delegate = self;
    secondPasswordTextfield.placeholder = @"请再次输入密码";
    secondPasswordTextfield.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    secondPasswordTextfield.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:secondPasswordTextfield];
    _secondPasswordTextfield = secondPasswordTextfield;
    
//    secondPasswordTextfield.sd_layout
//    .leftEqualToView(secondPasswordLabel)
//    .rightEqualToView(secondPasswordLabel)
//    .topSpaceToView(secondPasswordLabel, 5)
//    .heightIs(20);
//
    //分隔线
    UIView * secondPasswordView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondPasswordTextfield.frame) + 5, contentView.yj_width, 0.5)];
    secondPasswordView.backgroundColor = [UIColor colorWithHexColorStr:@"#D3D3D3"];
    [contentView addSubview:secondPasswordView];
    
//    secondPasswordView.sd_layout
//    .leftEqualToView(secondPasswordTextfield)
//    .rightEqualToView(secondPasswordTextfield)
//    .topSpaceToView(secondPasswordTextfield, 5)
//    .heightIs(0.5);

    //注册
    UIButton * submissionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submissionBtn setTitle:@"注册" forState:UIControlStateNormal];
    submissionBtn.frame = CGRectMake(0, CGRectGetMaxY(secondPasswordView.frame) + 40, contentView.yj_width, 40);
    [submissionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    submissionBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submissionBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3FE4B1"]];
    [contentView addSubview:submissionBtn];
    [submissionBtn addTarget:self action:@selector(submissionAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    submissionBtn.sd_layout
//    .topSpaceToView(secondPasswordView, 40)
//    .leftSpaceToView(contentView, 0)
//    .rightSpaceToView(contentView, 0)
//    .heightIs(40);
    
    submissionBtn.layer.cornerRadius = 19.25;
    submissionBtn.layer.masksToBounds = YES;
    
    
    
    //已有账号，登录
    UILabel * ownLabel = [[UILabel alloc]init];
    ownLabel.text = @"已有账号?";
    
    CGRect disCountrect = [ownLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
    ownLabel.frame = CGRectMake(80, CGRectGetMaxY(submissionBtn.frame) + 12.5, disCountrect.size.width, 20);
    
    ownLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    ownLabel.font = [UIFont systemFontOfSize:12];
    ownLabel.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:ownLabel];
    
    //登录
    UIButton * ownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ownBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    CGRect userPrivacy = [ownBtn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin
    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
    
    ownBtn.frame = CGRectMake(CGRectGetMaxX(ownLabel.frame), CGRectGetMaxY(submissionBtn.frame) + 12.5, userPrivacy.size.width, 20);
    
    [ownBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
    ownBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:ownBtn];
    [ownBtn addTarget:self action:@selector(backUpViewController:) forControlEvents:UIControlEventTouchUpInside];
    
   
//    ownLabel.sd_layout
//    .centerXIs(SCW/2 - 70)
//    .topSpaceToView(submissionBtn, 12.5)
//    .widthIs(disCountrect.size.width)
//    .heightIs(20);
    
    
    
//    ownBtn.sd_layout
//    .leftSpaceToView(ownLabel, 0)
//    .topEqualToView(ownLabel)
//    .bottomEqualToView(ownLabel)
//    .widthIs(userPrivacy.size.width);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if (textField == _accountTextfield) {
        if ([temp length] > 0) {
            _accountTextfield.text = temp;
            //这边还需要去验证是否账号重复性
            NetworkTool * network = [[NetworkTool alloc]init];
            NSString * canshu = URL_YIGODATA_USERCODE(temp);
            NSString * soapStr = URL_YIGODATA_IOS(URL_LOGINWEBSERVICE, URL_VALIDUSERCODE, canshu);
            [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:soapStr andURLName:URL_VALIDUSERCODE];
            network.successReload = ^(NSDictionary *dict) {
                self.isRepeat = true;
            };
            network.failure = ^(NSDictionary *dict) {
                self.isRepeat = false;
            };
        }else{
            [_accountTextfield resignFirstResponder];
            _accountTextfield.text = @"";
        }
    }else if (textField == _nicknameTextfield){
         if ([temp length] > 0) {
             _nicknameTextfield.text = temp;
         }else{
             _nicknameTextfield.text = @"";
             [_nicknameTextfield resignFirstResponder];
         }
    }else if (textField == _nicknameTextfield){
         if ([temp length] > 0) {
             _passwordTextfield.text = temp;
         }else{
             _passwordTextfield.text = @"";
             [_passwordTextfield resignFirstResponder];
         }
    }else if (textField == _nicknameTextfield){
         if ([temp length] > 0) {
             _secondPasswordTextfield.text = temp;
         }else{
             _secondPasswordTextfield.text = @"";
             [_secondPasswordTextfield resignFirstResponder];
         }
    }
}

- (void)backUpViewController:(UIButton *)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submissionAction:(UIButton *)submissionBtn{
    [self setEditing:YES];
    if ([_accountTextfield.text length] < 1) {
        jxt_showToastMessage(@"账号没有填写", 0.75);
        return;
    }
    //账号
    if (self.isRepeat == false) {
        jxt_showToastMessage(@"账号重复了", 0.75);
        return;
    }
    //昵称
    if ([_nicknameTextfield.text length] < 1) {
        jxt_showToastMessage(@"请输入昵称", 0.75);
        return;
    }
    //    if(![self isEnglishAndChinese:_nicknameTextfield.text])
    //    {
    //        jxt_showToastMessage(@"请输入昵称", 0.75);
    //           return;
    //    }
    //密码
    if(![self validatePassword:_passwordTextfield.text])
    {
        jxt_showToastMessage(@"请设置注册密码", 0.75);
        return;
    }
    if (_passwordTextfield.text.length<6)
    {
        jxt_showToastMessage(@"请设置6-18位密码", 0.75);
        return;
    }
    if (_passwordTextfield.text.length>18)
    {
        jxt_showToastMessage(@"请设置6-18位密码", 0.75);
        return;
    }
    //    if ([self isValidPassword:_passwordTextField.text]) {
    //
    //        //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
    //        [SVProgressHUD showErrorWithStatus:@"密码包含无效字符"];
    //        return;
    //    }
    //确认密码
    if(![self validatePassword:_secondPasswordTextfield.text])
    {
        jxt_showToastMessage(@"请设置确认注册密码", 0.75);
        return;
    }
    if (_secondPasswordTextfield.text.length<6)
    {
        jxt_showToastMessage(@"请设置6-18位密码", 0.75);
        return;
    }
    if (_secondPasswordTextfield.text.length>20)
    {
        jxt_showToastMessage(@"请设置6-18位密码", 0.75);
        return;
    }
    //    if(![self isValidPassword:_againpasswordTextField.text])
    //    {
    //        //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
    //        [SVProgressHUD showErrorWithStatus:@"密码包含无效字符"];
    //        return;
    //    }
    if(![_passwordTextfield.text isEqualToString:_secondPasswordTextfield.text])
    {
        jxt_showToastMessage(@"密码不一致", 0.75);
        return;
    }
    //注册的请求方式
    NetworkTool * network = [[NetworkTool alloc]init];
    NSString * password = [MyMD5 md5:_passwordTextfield.text];
    NSString * canshu = URL_YIGODATA_REGISTEUSER(_accountTextfield.text, password, _nicknameTextfield.text);
    NSString * soapStr = URL_YIGODATA_IOS(URL_LOGINWEBSERVICE, URL_REGISTERUSER, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:soapStr andURLName:URL_REGISTERUSER];
    network.successReload = ^(NSDictionary *dict) {
        jxt_showToastMessage(@"注册成功,需要你重新去登录", 0.75);
        //返回上一个页面
        if (self.registeUser) {
            self.registeUser(self.accountTextfield.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
    
}

@end
