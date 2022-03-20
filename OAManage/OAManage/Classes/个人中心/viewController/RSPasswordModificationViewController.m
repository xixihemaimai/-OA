//
//  RSPasswordModificationViewController.m
//  OAManage
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPasswordModificationViewController.h"
#import "AppDelegate.h"
#import "RSLoginViewController.h"

@interface RSPasswordModificationViewController ()

/**旧密码*/
@property (nonatomic,strong)UITextField * oldCipherField;
/**新密码*/
@property (nonatomic,strong)UITextField * renewCipherField;
/**确认密码*/
@property (nonatomic,strong)UITextField * sureCipherField;

@end

@implementation RSPasswordModificationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    //self.frostedViewController.panGestureEnabled = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.emptyView.hidden = YES;
    
    //这边设置成一个view
    UIView * rePasswordView = [[UIView alloc]init];
    rePasswordView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rePasswordView];
    
    rePasswordView.frame = CGRectMake(0, 120, SCW, SCH);
    
//    rePasswordView.sd_layout
//    .topSpaceToView(self.view, 120)
//    .centerXEqualToView(self.view)
//    .widthRatioToView(self.view, 0.9)
//    .autoHeightRatio(0);
   
    UITextField * oldCipherField = [[UITextField alloc]init];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSAttributedString * attri = [[NSAttributedString alloc] initWithString:@"原密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#E0E0E0"],NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
    oldCipherField.secureTextEntry = YES;
    oldCipherField.attributedPlaceholder = attri;
    oldCipherField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    oldCipherField.textAlignment = NSTextAlignmentCenter;
    oldCipherField.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    oldCipherField.layer.cornerRadius = 20;
    oldCipherField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D3D3D3"].CGColor;
    oldCipherField.layer.borderWidth = 1;
    oldCipherField.layer.masksToBounds = YES;
    [rePasswordView addSubview:oldCipherField];
    [_oldCipherField addTarget:self action:@selector(changeTextfieldContent:) forControlEvents:UIControlEventEditingChanged];
    _oldCipherField = oldCipherField;
    
    UITextField * renewCipherField = [[UITextField alloc]init];
    NSMutableParagraphStyle *passwordstyle = [[NSMutableParagraphStyle alloc] init];
    passwordstyle.alignment = NSTextAlignmentCenter;
    NSAttributedString * passwordattri = [[NSAttributedString alloc] initWithString:@"新密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#E0E0E0"],NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:passwordstyle}];
    renewCipherField.attributedPlaceholder = passwordattri;
    renewCipherField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    renewCipherField.secureTextEntry = YES;
    renewCipherField.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    renewCipherField.layer.cornerRadius = 20;
    renewCipherField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D3D3D3"].CGColor;
    renewCipherField.layer.borderWidth = 1;
    renewCipherField.layer.masksToBounds = YES;
    renewCipherField.textAlignment = NSTextAlignmentCenter;
    [rePasswordView addSubview:renewCipherField];
    _renewCipherField = renewCipherField;
    [_renewCipherField addTarget:self action:@selector(changeTextfieldContent:) forControlEvents:UIControlEventEditingChanged];
    
    UITextField * sureCipherField = [[UITextField alloc]init];
    NSMutableParagraphStyle *surepasswordstyle = [[NSMutableParagraphStyle alloc] init];
    surepasswordstyle.alignment = NSTextAlignmentCenter;
    NSAttributedString * surepasswordattri = [[NSAttributedString alloc] initWithString:@"确认密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexColorStr:@"#E0E0E0"],NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:surepasswordstyle}];
    sureCipherField.attributedPlaceholder = surepasswordattri;
    sureCipherField.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    sureCipherField.layer.cornerRadius = 20;
    sureCipherField.layer.borderColor = [UIColor colorWithHexColorStr:@"#D3D3D3"].CGColor;
    sureCipherField.layer.borderWidth = 1;
    sureCipherField.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    sureCipherField.secureTextEntry = YES;
    sureCipherField.layer.masksToBounds = YES;
    sureCipherField.textAlignment = NSTextAlignmentCenter;
    [rePasswordView addSubview:sureCipherField];
    _sureCipherField = sureCipherField;
    [_sureCipherField addTarget:self action:@selector(changeTextfieldContent:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton * sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3FE4B1"]];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:Textadaptation(16)];
    [rePasswordView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    oldCipherField.frame = CGRectMake(SCW/2 - 266/2, 18, 266, 39);
//        oldCipherField.sd_layout
//        .centerXEqualToView(rePasswordView)
//        .topSpaceToView(rePasswordView, 18)
//        .widthIs(266)
//        .heightIs(39);
        
//        renewCipherField.sd_layout
//        .centerXEqualToView(rePasswordView)
//        .topSpaceToView(oldCipherField, 18)
//        .leftEqualToView(oldCipherField)
//        .rightEqualToView(oldCipherField)
//        .heightIs(39);
    
    renewCipherField.frame = CGRectMake(SCW/2 - 266/2, CGRectGetMaxY(oldCipherField.frame) + 18, 266, 39);
        
//        sureCipherField.sd_layout
//        .centerXEqualToView(rePasswordView)
//        .topSpaceToView(renewCipherField, 18)
//        .leftEqualToView(renewCipherField)
//        .rightEqualToView(renewCipherField)
//        .heightIs(39);
    sureCipherField.frame = CGRectMake(SCW/2 - 266/2, CGRectGetMaxY(renewCipherField.frame) + 18, 266, 39);
//
//        sureBtn.sd_layout
//        .centerXEqualToView(rePasswordView)
//        .topSpaceToView(sureCipherField, 18)
//        .leftEqualToView(sureCipherField)
//        .rightEqualToView(sureCipherField)
//        .heightIs(39);

    sureBtn.frame = CGRectMake(SCW/2 - 266/2, CGRectGetMaxY(sureCipherField.frame) + 18, 266, 39);
    sureBtn.layer.cornerRadius = 20;
//    sureBtn.layer.masksToBounds = YES;
//    [rePasswordView layoutSubviews];
//    [rePasswordView setupAutoHeightWithBottomView:sureBtn bottomMargin:0];
}

- (void)changeTextfieldContent:(UITextField *)textfield{
    NSString *temp = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if (textfield == _oldCipherField) {
        if ([temp length] > 0) {
            _oldCipherField.text = temp;
        }else{
            _oldCipherField.text = @"";
            [_oldCipherField resignFirstResponder];
        }
    }else if(textfield == _renewCipherField){
        if ([temp length] > 0) {
            _renewCipherField.text = temp;
        }else{
            _renewCipherField.text = @"";
            [_renewCipherField resignFirstResponder];
        }
    }else{
        if ([temp length] > 0) {
            _sureCipherField.text = temp;
        }else{
            _sureCipherField.text = @"";
            [_sureCipherField resignFirstResponder];
        }
    }
}

- (void)sureAction:(UIButton *)sureBtn{
    if([self istext:_oldCipherField])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入原密码"];
        return;
    }
    if([self istext:_renewCipherField])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    if([self istext:_sureCipherField])
    {
        [SVProgressHUD showErrorWithStatus:@"请确认密码"];
        return;
    }
    if(![self validatePassword:_oldCipherField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"密码只允许数字和大小字母组成"];
        return;
    }
    if(![self validatePassword:_renewCipherField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"密码只允许数字和大小字母组成"];
        return;
    }
    if(![self validatePassword:_sureCipherField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"密码只允许数字和大小字母组成"];
        return;
    }
    if (_oldCipherField.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"原密码错误"];
        return;
    }
    if (_renewCipherField.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
    if (_sureCipherField.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
    if (_oldCipherField.text.length>18)
    {
        [SVProgressHUD showErrorWithStatus:@"原密码错误"];
        return;
    }
    if (_renewCipherField.text.length>18)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
    if (_sureCipherField.text.length>18)
    {
        [SVProgressHUD showErrorWithStatus:@"请设置6-18位密码"];
        return;
    }
    if(![_renewCipherField.text isEqualToString:_sureCipherField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"密码不一致"];
        return;
    }
    if([_oldCipherField.text isEqualToString:_renewCipherField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"原密码和新密码相同"];
        return;
    }
    if([_oldCipherField.text isEqualToString:_sureCipherField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"原密码和新密码相同"];
        return;
    }
    NetworkTool * network = [[NetworkTool alloc]init];
    NSString * oldPassword = [MyMD5 md5:_oldCipherField.text];
    NSString * newPassword = [MyMD5 md5:_renewCipherField.text];
    NSString * password = URL_YIGODATA_PASSWORD(oldPassword, newPassword);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString *const kInitVector = @"16-Bytes--String";
    NSString * aes2 = [FSAES128 encryptAES:password key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_CHANGPWD(self.usermodel.appLoginToken, aes2);
    NSString * soapStr = URL_YIGODATA_IOS(URL_LOGINWEBSERVICE, URL_CHANGPWD, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:soapStr andURLName:URL_CHANGPWD];
    network.successReload = ^(NSDictionary *dict) {
        [user removeObjectForKey:@"OAUSERMODEL"];
        [user removeObjectForKey:@"AES"];
        [user synchronize];
        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
               RSMyNavigationViewController * mayNa = [[RSMyNavigationViewController alloc]initWithRootViewController:loginVc];
               
        
//        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        appdelegate.window.rootViewController = mayNa;
    };
}




@end
