//
//  RSPersonalInformationViewController.m
//  OAManage
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPersonalInformationViewController.h"
#import "RSPersonFirstCell.h"
#import "RSPersonSecondCell.h"
#import "AppDelegate.h"
#import "RSLoginViewController.h"
#import "RSLoginOffView.h"
//密码修改
#import "RSPasswordModificationViewController.h"

@interface RSPersonalInformationViewController ()


@property (nonatomic,strong)NSArray * fristArray;

@property (nonatomic,strong)NSArray * secondArray;



@end

@implementation RSPersonalInformationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.frostedViewController.panGestureEnabled = NO;
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    self.emptyView.hidden = YES;
    self.fristArray = @[@"昵称",@"性别"];
    self.secondArray = @[@"所在部门",@"所在职位",@"密码修改",@"注销账号"];
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PERSIONID = @"personid";
    if (indexPath.section == 0) {
        RSPersonFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSIONID];
        if (!cell) {
            cell = [[RSPersonFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSIONID];
        }
       // [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.userModel.userHead]] placeholderImage:[UIImage imageNamed:@"求真像"]];
        cell.headerview.image = [UIImage imageNamed:@"logo"];
//        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        cell.imageView.clipsToBounds = YES;
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        RSPersonSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSIONID];
        if (!cell) {
            cell = [[RSPersonSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSIONID];
        }
        if (indexPath.section == 1) {
            cell.nameLabel.text = self.fristArray[indexPath.row];
            cell.rightImageView.hidden = true;
            if (indexPath.row == 0) {
                cell.phoneLabel.text = [NSString stringWithFormat:@"%@",self.usermodel.userName];
            }
            else{
                cell.phoneLabel.text = [NSString stringWithFormat:@"%@",self.usermodel.sex];
            }
        }else if (indexPath.section == 2){
            cell.nameLabel.text = self.secondArray[indexPath.row];
            cell.rightImageView.hidden = true;
            if (indexPath.row == 0) {
                 cell.phoneLabel.text = [NSString stringWithFormat:@"%@",self.usermodel.deptName];
            }else if (indexPath.row == 1){
                cell.phoneLabel.text = @"UI设计";
            }else if (indexPath.row == 2 || indexPath.row == 3){
                cell.rightImageView.hidden = false;
            }
        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section == 0) {
            return 101;
        }else{
            return 48;
        }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2){
        if (indexPath.row == 2){
            RSPasswordModificationViewController * passwordModificationVc = [[RSPasswordModificationViewController alloc]init];
            [self.navigationController pushViewController:passwordModificationVc animated:YES];
        }if (indexPath.row == 3){
//            NSLog(@"================注销账号");
            [JHSysAlertUtil presentAlertViewWithTitle:@"是否注销账号" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:true cancel:^{
            } confirm:^{
                RSLoginOffView * loginOffView = [[RSLoginOffView alloc]initWithFrame:self.view.bounds];
                loginOffView.inputPassword = ^(NSString * _Nonnull password, BOOL isSure) {
                    if (isSure){
                        NetworkTool * network = [[NetworkTool alloc]init];
                        NSString * oldPassword = [MyMD5 md5:password];
                        NSString * newPassword = [MyMD5 md5:@""];
                        NSString * password = URL_YIGODATA_PASSWORD(oldPassword, newPassword);
                        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                        NSString * aes = [user objectForKey:@"AES"];
                        NSString *const kInitVector = @"16-Bytes--String";
                        NSString * aes2 = [FSAES128 encryptAES:password key:aes andKInItVector:kInitVector];
                        NSString * canshu = URL_YIGODATA_CHANGPWD(self.usermodel.appLoginToken, aes2);
                        NSString * soapStr = URL_YIGODATA_IOS(URL_LOGINWEBSERVICE, URL_LOGINOFF, canshu);
                        [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:soapStr andURLName:URL_LOGINOFF];
                        network.successReload = ^(NSDictionary *dict) {
                            [user removeObjectForKey:@"OAUSERMODEL"];
                            [user removeObjectForKey:@"AES"];
                            [user synchronize];
                            AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                            RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
                                   RSMyNavigationViewController * mayNa = [[RSMyNavigationViewController alloc]initWithRootViewController:loginVc];
                            appdelegate.window.rootViewController = mayNa;
                        };
                    }
                };
                [self.view addSubview:loginOffView];
            }];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
        if (section == 0 || section == 2) {
            return 0;
        }else{
            return 10;
        }
}



@end
