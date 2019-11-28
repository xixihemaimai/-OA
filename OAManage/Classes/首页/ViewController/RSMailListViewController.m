//
//  RSMailListViewController.m
//  OAManage
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSMailListViewController.h"
#import "RSMailListCell.h"

//通讯录详情
#import "RSMailDetailViewController.h"
//通讯录模型
#import "RSMailModel.h"
#import "RSOALocalDB.h"


@interface RSMailListViewController ()<UITextFieldDelegate>

{
    UITextField *searchField;
}

@property (nonatomic,strong)NSMutableArray * mailArray;

@end

@implementation RSMailListViewController
- (NSMutableArray *)mailArray{
    if (!_mailArray) {
        _mailArray = [NSMutableArray array];
    }
    return _mailArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通讯录";
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    self.emptyView.hidden = YES;
    
    [self inputTextField];
    
    [self notificationCenterAction];
    
    [self hiddenSearchAnimation];
    
    [self reloadMailNewData];
    
    RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"mailList.sqlite"];
    BOOL iscreat = [oaLocalDB createContentTable];
    if (iscreat) {
    }else{
        [SVProgressHUD showErrorWithStatus:@"创建失败"];
    }
}

- (void)reloadMailNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString * const kInitVector = @"16-Bytes--String";
    NSString * kongStr = URL_YIGODATA_WORKFLOWTYPE(@"5");
    NSString * aes2 = [FSAES128 encryptAES:kongStr key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_LOADMAILLIST, canshu);
    NetworkTool * network = [[NetworkTool alloc]init];
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_LOADMAILLIST];
    network.successArrayReload = ^(NSMutableArray *array) {
        RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"mailList.sqlite"];
        if (array.count > 0) {
            [self.mailArray removeAllObjects];
            //这边要把数据放到本地数据库里面
            [oaLocalDB deleteAllContent];
            [oaLocalDB batchAddMutableArray:array];
            [self.mailArray addObjectsFromArray:[self changeArrayRule:array]];
            if (self.mailArray.count < 1) {
                self.emptyView.hidden = NO;
            }else{
                self.emptyView.hidden = YES;
            }
        }else{
            [self.mailArray addObjectsFromArray:[self changeArrayRule:[oaLocalDB getAllContent]]];
            if (self.mailArray.count < 1) {
                self.emptyView.hidden = NO;
            }else{
                self.emptyView.hidden = YES;
            }
        }
        [self.tableview reloadData];
    };
}


-(void) inputTextField
{
    //****************************搜索框*****************************
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, 61)];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 12.5 , SCW - 30, 36.5)];
    //_nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    _nameTextField.placeholder = @"搜索";
    [_nameTextField addTarget:self action:@selector(findMailAction:) forControlEvents:UIControlEventEditingChanged];
    //设置输入框内容的字体样式和大小
    _nameTextField.font = [UIFont fontWithName:@"Arial" size:16.0f];
    _nameTextField.textColor  = [UIColor colorWithHexColorStr:@"#333333"];
    _nameTextField.delegate = self;
    [headerView addSubview:_nameTextField];
    _nameTextField.layer.cornerRadius = 18.25;
    _nameTextField.layer.masksToBounds = YES;
    self.tableview.tableHeaderView = headerView;
    
}

//************************动态事件************************
//显示搜索状态
-(void) searchAnimation
{
    self.inputView = [[UIView alloc] init];
    self.inputView.frame= CGRectMake(0, 0 ,24 , 36.5);
    self.imgSearch = [[UIImageView alloc] init];
    
    self.imgSearch.image = [UIImage imageNamed:@"搜索"];
    CGRect rx = CGRectMake(4.75,10.25, 14.5, 16);
    self.imgSearch.frame = rx;
    
    
    
    [self.inputView addSubview:self.imgSearch];
    // 把leftVw设置给文本框
    _nameTextField.leftView = self.inputView;
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
}


//显示隐藏状态
-(void) hiddenSearchAnimation
{
    self.inputView = [[UIView alloc] init];
    //CGFloat textFieldW = (_nameTextField.frame.size.width) / 2;
    self.inputView.frame= CGRectMake(0, 0 ,SCW/2 - 15, 36.5);
    self.imgSearch = [[UIImageView alloc] init];
    self.imgSearch.image = [UIImage imageNamed:@"搜索"];
    
    
    
    
    self.inputView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShowKeyBoard:)];
    [self.inputView addGestureRecognizer:tap];
    
    
    CGRect rx = CGRectMake(SCW/2 - 35,10.25, 14.5, 16);
    self.imgSearch.frame = rx;
 
    [self.inputView addSubview:self.imgSearch];
    // 把leftVw设置给文本框
    _nameTextField.leftView = self.inputView;
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
}


- (void)tapShowKeyBoard:(UITapGestureRecognizer *)tap{
    [_nameTextField becomeFirstResponder];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}


- (void)findMailAction:(UITextField *)textfiled{
    NSString * temp = [textfiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"mailList.sqlite"];
    if ([temp length] > 0) {
        self.mailArray = [self changeArrayRule:[oaLocalDB serachContent:temp]];
    }else{
        self.mailArray = [self changeArrayRule:[oaLocalDB getAllContent]];
    }
    [self.tableview reloadData];
}

#pragma mark - 监听键盘的事件
-(void) notificationCenterAction
{
    //监听键盘的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

#pragma mark - 屏幕的伸缩
//键盘升起时动画
- (void)keyboardWillShow:(NSNotification*)notif
{
    //动态提起整个屏幕
    [UIView animateWithDuration:4 animations:^{
        
        [self searchAnimation];
        
    } completion:nil];
}

//键盘关闭时动画
- (void)keyboardWillHide:(NSNotification*)notif
{
    
    [UIView animateWithDuration:4 animations:^{
        
      [self hiddenSearchAnimation];
        
    } completion:nil];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mailArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray * array = self.mailArray[section];
    return array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     NSMutableArray * array = self.mailArray[section];
    RSMailModel * mailmodel = array[0];
    NSString * department = mailmodel.department;
    return department;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 33;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * MAILCELLID = @"MAILCELLID";
    RSMailListCell * cell = [tableView dequeueReusableCellWithIdentifier:MAILCELLID];
    if (!cell) {
        cell = [[RSMailListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MAILCELLID];
    }
    NSMutableArray * array = self.mailArray[indexPath.section];
    RSMailModel * mailmodel = array[indexPath.row];
    cell.nameLabel.text = mailmodel.name;
    cell.positionLabel.text = mailmodel.position;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray * array = self.mailArray[indexPath.section];
    RSMailModel * mailmodel = array[indexPath.row];
    RSMailDetailViewController * mailDetailVc = [[RSMailDetailViewController alloc]init];
    mailDetailVc.mailmodel = mailmodel;
    [self.navigationController pushViewController:mailDetailVc animated:YES];
}






@end
