//
//  RSSystemViewController.m
//  OAManage
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSystemViewController.h"
#import "RSSystemTypeModel.h"
#import "RSSystemModel.h"
#import "RSSystemCell.h"
#import <QuickLook/QuickLook.h>
#import "QLPreviewItemCustom.h"

@interface RSSystemViewController ()<QLPreviewControllerDelegate,QLPreviewControllerDataSource,UITextFieldDelegate>


@property (nonatomic,assign)int pageNum;


@property (nonatomic,strong)NSMutableArray * systemArray;


@property (nonatomic,strong)NSMutableArray * systemTypeArray;


@property (nonatomic,assign)NSInteger selectTypeNum;


@property (nonatomic, copy)NSURL *fileURL; //文件路径


@property (nonatomic , strong) UITextField * fileTextField;//搜索框

@property (nonatomic ,strong ) UIView *inputView; //左边输入视图

@property (nonatomic , strong) UIImageView *imgSearch; //搜索图片


@property (nonatomic , strong) UIButton * allBtn;

@property (nonatomic , strong) UIView * contentView;

@end


@implementation RSSystemViewController

- (NSMutableArray *)systemArray{
    if (!_systemArray) {
        _systemArray = [NSMutableArray array];
    }
    return _systemArray;
}


- (NSMutableArray *)systemTypeArray{
    if (!_systemTypeArray) {
        _systemTypeArray = [NSMutableArray array];
    }
    return _systemTypeArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self notificationCenterAction];
    
    self.selectTypeNum = 0;
    self.title = @"体系文件";
    [self reloadSystem_files_typeNew];
   
    self.pageNum = 1;
     
    self.emptyView.hidden = YES;
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadSystemNewData)];
    self.tableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadSystemMoreNewData)];
    [self.tableview.mj_header beginRefreshing];
 
}


- (void)CustomTableViewHeaderView{
    
    UIView * headerView = [[UIView alloc]init];
 
    headerView.backgroundColor =[UIColor colorWithHexColorStr:@"#ffffff"];
    
    
    
    _fileTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 13 , SCW - 30, 34)];
    //_nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _fileTextField.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    _fileTextField.placeholder = @"搜索";
    _fileTextField.text = @"";
    [_fileTextField addTarget:self action:@selector(findMailAction:) forControlEvents:UIControlEventEditingDidEnd];
    //设置输入框内容的字体样式和大小
    _fileTextField.font = [UIFont fontWithName:@"Arial" size:16.0f];
    _fileTextField.textColor  = [UIColor colorWithHexColorStr:@"#333333"];
    _fileTextField.delegate = self;
    [headerView addSubview:_fileTextField];
    _fileTextField.layer.cornerRadius = 18.25;
    _fileTextField.layer.masksToBounds = YES;
    
    [self hiddenSearchAnimation];
    
    //全部
    UIButton * allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
    [allBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    allBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    allBtn.frame = CGRectMake(15, CGRectGetMaxY(_fileTextField.frame) + 15, 100, 35);
    [headerView addSubview:allBtn];
    allBtn.layer.cornerRadius = 1.5;
    allBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#27C79A"].CGColor;
    allBtn.layer.borderWidth = 0.5;
    allBtn.layer.masksToBounds = YES;
    _allBtn = allBtn;
    
    [allBtn addTarget:self action:@selector(allBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * contentView = [[UIView alloc]init];
    NSInteger cols = 3;
    //图片所在列
    NSInteger a = self.systemTypeArray.count % cols;
    NSInteger col = 0;
    if (a == 0) {
        col = self.systemTypeArray.count / cols;
    }else{
        col = self.systemTypeArray.count / cols + 1;
    }

    contentView.frame = CGRectMake(8, CGRectGetMaxY(allBtn.frame) , SCW - 30, 45 * col);
    [headerView addSubview:contentView];
    for (int i = 0; i < self.systemTypeArray.count; i++) {
        [self showImageView:contentView withImageIndex:i];
    }
    _contentView = contentView;
    
    
    UIView * bottomview = [[UIView alloc]init];
    bottomview.frame = CGRectMake(0, CGRectGetMaxY(contentView.frame) + 10, SCW , 7.5);
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    [headerView addSubview:bottomview];
    
    headerView.frame = CGRectMake(0, 0, SCW, 97 + 45 * col + 10 + 7.5);
//    [headerView setupAutoHeightWithBottomView:bottomview bottomMargin:0];
//    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}

- (void)showImageView:(UIView *)bgView withImageIndex:(NSInteger)index{
    //一行的列数
    NSInteger cols = 3;
    //每一列的间距
    CGFloat margin = 8;
    //图片大小
    //NSInteger imageW = (SCW  - ((cols + 1)*margin))/cols;
    NSInteger imageW = 100;
    NSInteger imageH = 35;
    //图片所在列
    NSInteger col = index % cols;
    //图片所在行
    NSInteger row = index / cols;
    
    CGFloat shopX = col * (imageW + margin) + margin;
    CGFloat shopY = row * (imageH + margin) + margin;
    UIButton * titleBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.tag = 1000000 + index;
    titleBtn.frame = CGRectMake(shopX, shopY, imageW, imageH);
    RSSystemTypeModel * systemTypemodel = self.systemTypeArray[index];
    
    if (systemTypemodel.name.length > 5) {
        NSMutableString * string = [[NSMutableString alloc]initWithString:systemTypemodel.name];
        [string insertString:@"\n" atIndex:5];
        [titleBtn setTitle:string forState:UIControlStateNormal];
    }else{
         [titleBtn setTitle:systemTypemodel.name forState:UIControlStateNormal];
    }
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    titleBtn.titleLabel.numberOfLines = 2;
    [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    [titleBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F6F7"]];
    [titleBtn addTarget:self action:@selector(selecteSystemTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:titleBtn];
    titleBtn.layer.cornerRadius = 1.5;
    titleBtn.layer.masksToBounds = YES;
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
    _fileTextField.leftView = self.inputView;
    _fileTextField.leftViewMode = UITextFieldViewModeAlways;
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
    _fileTextField.leftView = self.inputView;
    _fileTextField.leftViewMode = UITextFieldViewModeAlways;
}


- (void)tapShowKeyBoard:(UITapGestureRecognizer *)tap{
    [_fileTextField becomeFirstResponder];
}


- (void)findMailAction:(UITextField *)textfiled{
    NSString * temp = [textfiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
//  RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"mailList.sqlite"];
    if ([temp length] > 0) {
        self.pageNum = 1;
        [self reloadSystemNew];
    }else{
        self.pageNum = 1;
        [self reloadSystemNew];
       // self.mailArray = [self changeArrayRule:[oaLocalDB getAllContent]];
    }
    [self.tableview reloadData];
}


- (NSMutableArray *)searchContent:(NSString *)temp{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.systemArray.count; i++) {
        RSSystemModel * systemmodel = self.systemArray[i];
        if ([systemmodel.fileName rangeOfString:temp].location != NSNotFound) {
            [result addObject:systemmodel];
        }
    }
    //[self.systemArray removeAllObjects];
    return result;
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
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



- (void)reloadSystem_files_typeNew{
    //URL_SYS_FILES_TYPE_IOS
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    [network newReloadWebServiceNoDataURL:URL_SYS_FILES_TYPE_IOS andParameters:dict andURLName:URL_SYS_FILES_TYPE_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
        [self.systemTypeArray removeAllObjects];
        //self.systemTypeArray = array;
        [self.systemTypeArray addObjectsFromArray:array];
        [self CustomTableViewHeaderView];
    };
}



- (void)selecteSystemTypeAction:(UIButton *)titleBtn{
    RSSystemTypeModel * systemTypemodel = self.systemTypeArray[titleBtn.tag - 1000000];
    
    self.allBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#27C79A"].CGColor;
    self.allBtn.layer.borderWidth = 0;
    [self.allBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    [self.allBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F6F7"]];
    for (UIButton * btn in self.contentView.subviews) {
        btn.layer.borderColor = [UIColor colorWithHexColorStr:@"#27C79A"].CGColor;
        btn.layer.borderWidth = 0;
        [btn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F6F7"]];
    }
    titleBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#27C79A"].CGColor;
    titleBtn.layer.borderWidth = 0.5;
    [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
    [titleBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    
    self.pageNum = 1;
    self.selectTypeNum = systemTypemodel.systemtypeId;
    [self reloadSystemNew];
}

//全部
- (void)allBtnAction:(UIButton *)allBtn{
    self.pageNum = 1;
    self.selectTypeNum = 0;
    [self reloadSystemNew];
    self.allBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#27C79A"].CGColor;
    self.allBtn.layer.borderWidth = 0.5;
    [self.allBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
    [self.allBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    
    for (UIButton * btn in self.contentView.subviews) {
        [btn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor colorWithHexColorStr:@"#27C79A"].CGColor;
        btn.layer.borderWidth = 0;
        [btn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F6F7"]];
    }
}



- (void)reloadSystemNewData{
    self.pageNum = 1;
    [self reloadSystemNew];
}


- (void)reloadSystemMoreNewData{
    [self reloadSystemNew];
}



- (void)reloadSystemNew{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    //[NSNumber numberWithInteger:self.pageNum]
    [dict setValue:URL_NEWSYS_FILES_IOS(self.pageNum, 10,(long)self.selectTypeNum,_fileTextField.text) forKey:@"data"];
    [network newReloadWebServiceNoDataURL:URL_SYS_FILES_IOS andParameters:dict andURLName:URL_SYS_FILES_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
        if (self.pageNum == 1) {
            [self.systemArray removeAllObjects];
            self.systemArray = array;
            self.pageNum = 2;
            [self.tableview.mj_header endRefreshing];
        }else{
            NSArray * array1 = array;
            [self.systemArray addObjectsFromArray:array1];
            self.pageNum++;
            [self.tableview.mj_footer endRefreshing];
        }
//        if (self.systemArray.count > 0 ) {
//            self.emptyView.hidden = YES;
//        }else{
//            self.emptyView.hidden = NO;
//        }
          [self.tableview reloadData];
          
        };

   network.failure = ^(NSDictionary *dict) {
//        if (self.systemArray.count > 0 ) {
//            self.emptyView.hidden = YES;
//        }else{
//            self.emptyView.hidden = NO;
//        }
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
   };
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.systemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * NOTICECELLID = @"NOTICECELLID";
    RSSystemCell * cell = [tableView dequeueReusableCellWithIdentifier:NOTICECELLID];
    if (!cell) {
        cell = [[RSSystemCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NOTICECELLID];
    }
    RSSystemModel * systemmodel = self.systemArray[indexPath.row];
    cell.systemmodel = systemmodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSSystemModel * systemmodel = self.systemArray[indexPath.row];
    [self jumpEnclosureTempStr:[NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,systemmodel.url] andTitle:systemmodel.fileName];
}






- (void)jumpEnclosureTempStr:(NSString *)tempStr andTitle:(NSString *)title{
    QLPreviewController *previewController =[[QLPreviewController alloc]init];
    previewController.delegate=self;
    previewController.dataSource=self;
    previewController.title = title;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString * urlStr = tempStr;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [NSCharacterSet URLQueryAllowedCharacterSet];
    }else{
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    NSString *fileName = [urlStr lastPathComponent]; //获取文件名称
    NSURL * URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    //        判断是否存在
    if([self isFileExist:fileName]) {
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
        self.fileURL = url;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            previewController.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:previewController animated:YES completion:nil];
        //刷新界面,如果不刷新的话，不重新走一遍代理方法，返回的url还是上一次的url
        [previewController refreshCurrentPreviewItem];
    }else {
        [SVProgressHUD showWithStatus:@"下载中"];
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
            return url;
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            [SVProgressHUD dismiss];
            self.fileURL = filePath;
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                previewController.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:previewController animated:YES completion:nil];
            //刷新界面,如果不刷新的话，不重新走一遍代理方法，返回的url还是上一次的url
            [previewController refreshCurrentPreviewItem];
        }];
        [downloadTask resume];
    }
}


-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}
//QuickLook代理
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
    QLPreviewItemCustom * previewItem = [QLPreviewItemCustom new];
    RSSystemModel * systemmodel = self.systemArray[index];
    previewItem.previewItemTitle = systemmodel.fileName;
    previewItem.previewItemURL = self.fileURL;
    return previewItem;
    
    
    //return self.fileURL;
}

@end
