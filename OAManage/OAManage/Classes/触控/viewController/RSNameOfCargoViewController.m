//
//  RSNameOfCargoViewController.m
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSNameOfCargoViewController.h"
#import "RSNameOfCargoCell.h"
#import "RSOALocalDB.h"
@interface RSNameOfCargoViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)NSMutableArray * nameArray;

@end

@implementation RSNameOfCargoViewController
- (NSMutableArray *)nameArray{
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyView.hidden = YES;
    
    [self setNameOfCargoCustomHeaderView];
    
    [self reloadNameOfCargoNewData];
    
    if ([self.type isEqualToString:@"dealer"]) {
        self.title = @"货主名";
        RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"shipper.sqlite"];
        BOOL iscreat = [oaLocalDB createContentTable];
        if (iscreat) {
        }else{
            [SVProgressHUD showErrorWithStatus:@"创建失败"];
        }
    }else if ([self.type isEqualToString:@"warehouse"]){
        self.title = @"仓库";
        RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"warehouse.sqlite"];
        BOOL iscreat = [oaLocalDB createContentTable];
        if (iscreat) {
        }else{
            [SVProgressHUD showErrorWithStatus:@"创建失败"];
        }
    }else if ([self.type isEqualToString:@"storeArea"]){
        self.title = @"库区";
        RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"storeArea.sqlite"];
        BOOL iscreat = [oaLocalDB createContentTable];
        if (iscreat) {
        }else{
            [SVProgressHUD showErrorWithStatus:@"创建失败"];
        }
    }else if ([self.type isEqualToString:@"fee"]){
        self.title = @"费用";
        RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"fee.sqlite"];
        BOOL iscreat = [oaLocalDB createContentTable];
        if (iscreat) {
        }else{
            [SVProgressHUD showErrorWithStatus:@"创建失败"];
        }
    }
}

- (void)reloadNameOfCargoNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString *const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSString * notice = [NSString string];
    if ([self.type isEqualToString:@"dealer"]) {
        notice = URL_YIGODATA_DICTIONARY(@"true");
    }else if ([self.type isEqualToString:@"warehouse"]){
        notice = URL_YIGODATA_DICTIONWAREHOUSEARY(@"true");
    }else if ([self.type isEqualToString:@"storeArea"]){
        notice = URL_YIGODATA_DICTIONSTOREAREAARY(@"true");
    }else if ([self.type isEqualToString:@"fee"]){
        notice = URL_YIGODATA_FEE(@"true");
    }
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_LOADDICTIONNARY, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:self.type];
//    NSLog(@"=============================================================%@",sopaStr);
    network.successArrayReload = ^(NSMutableArray * array) {
        if ([self.type isEqualToString:@"dealer"]) {
            RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"shipper.sqlite"];
            if (array.count > 0) {
                [self.nameArray removeAllObjects];
                [self.nameArray addObjectsFromArray:array];
                //这边要把数据放到本地数据库里面
                [oaLocalDB deleteAllContent];
                [oaLocalDB batchAddMutableArray:array];
                if (self.nameArray.count < 1) {
                    self.emptyView.hidden = NO;
                }else{
                    self.emptyView.hidden = YES;
                }
            }else{
                [self.nameArray addObjectsFromArray:[oaLocalDB getAllContent]];
                if (self.nameArray.count < 1) {
                    self.emptyView.hidden = NO;
                }else{
                    self.emptyView.hidden = YES;
                }
            }
        }else if ([self.type isEqualToString:@"warehouse"]){
            RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"warehouse.sqlite"];
            if (array.count > 0) {
                [self.nameArray removeAllObjects];
                [self.nameArray addObjectsFromArray:array];
                //这边要把数据放到本地数据库里面
                [oaLocalDB deleteAllContent];
                [oaLocalDB batchAddMutableArray:array];
                if (self.nameArray.count < 1) {
                    self.emptyView.hidden = NO;
                }else{
                    self.emptyView.hidden = YES;
                }
            }else{
                [self.nameArray addObjectsFromArray:[oaLocalDB getAllContent]];
                if (self.nameArray.count < 1) {
                    self.emptyView.hidden = NO;
                }else{
                    self.emptyView.hidden = YES;
                }
            }
        }else if ([self.type isEqualToString:@"storeArea"]){
            RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"storeArea.sqlite"];
            if (array.count > 0) {
                [self.nameArray removeAllObjects];
                //这边要把数据放到本地数据库里面
                [oaLocalDB deleteAllContent];
                [oaLocalDB batchAddMutableArray:array];
                NSMutableArray * contentArray = [oaLocalDB serachWhsID:self.warehousemodel.warehouseId];
                [self.nameArray addObjectsFromArray:contentArray];
                if (self.nameArray.count < 1){
                    self.emptyView.hidden = NO;
                }else{
                    self.emptyView.hidden = YES;
                }
            }else{
                NSMutableArray * contentArray = [oaLocalDB serachWhsID:self.warehousemodel.warehouseId];
                [self.nameArray addObjectsFromArray:contentArray];
                if (self.nameArray.count < 1) {
                    self.emptyView.hidden = NO;
                }else{
                    self.emptyView.hidden = YES;
                }
            }
        }else if ([self.type isEqualToString:@"fee"]){
//            NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            
//            NSLog(@"++++++++++++++++23232+++++++++++++++++++++++++++++++++++++++++++++++++++%ld",array.count);
            
            RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"fee.sqlite"];
            if (array.count > 0) {
                [self.nameArray removeAllObjects];
                [self.nameArray addObjectsFromArray:array];
                //这边要把数据放到本地数据库里面
                [oaLocalDB deleteAllContent];
                [oaLocalDB batchAddMutableArray:array];
                if (self.nameArray.count < 1) {
                    self.emptyView.hidden = NO;
                }else{
                    self.emptyView.hidden = YES;
                }
            }else{
                [self.nameArray addObjectsFromArray:[oaLocalDB getAllContent]];
                if (self.nameArray.count < 1) {
                    self.emptyView.hidden = NO;
                }else{
                    self.emptyView.hidden = YES;
                }
            }
        }
        [self.tableview reloadData];
    };
}

- (void)setNameOfCargoCustomHeaderView{
    UIView * headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, SCW, 64);
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UIView * searchView = [[UIView alloc]init];
    searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
    [headerView addSubview:searchView];
    searchView.frame = CGRectMake(12, 12, SCW - 24, 40);
    
    
    
//    searchView.sd_layout
//    .leftSpaceToView(headerView, 12)
//    .rightSpaceToView(headerView, 12)
//    .topSpaceToView(headerView, 12)
//    .heightIs(40);
//
    UIImageView * searchImage = [[UIImageView alloc]init];
    searchImage.image = [UIImage imageNamed:@"搜索"];
    [searchView addSubview:searchImage];
    
    searchImage.frame = CGRectMake(18.5, 40/2 - 13/2, 13, 13);
    
//    searchImage.sd_layout
//    .centerYEqualToView(searchView)
//    .leftSpaceToView(searchView, 18.5)
//    .widthIs(13)
//    .heightEqualToWidth();
    
    
    UITextField * searchTextfield = [[UITextField alloc]init];
    if ([self.type isEqualToString:@"dealer"]) {
        searchTextfield.placeholder = @"货主名";
    }else if ([self.type isEqualToString:@"warehouse"]){
        searchTextfield.placeholder = @"仓库";
    }else if ([self.type isEqualToString:@"storeArea"]){
        searchTextfield.placeholder = @"库区";
    }else if ([self.type isEqualToString:@"fee"]){
        searchTextfield.placeholder = @"费用";
    }
    searchTextfield.delegate = self;
    searchTextfield.font = [UIFont systemFontOfSize:14];
    searchTextfield.textAlignment = NSTextAlignmentLeft;
    [searchTextfield addTarget:self action:@selector(findMailAction:) forControlEvents:UIControlEventEditingChanged];
    [searchView addSubview:searchTextfield];
    
    searchTextfield.frame = CGRectMake(CGRectGetMaxX(searchImage.frame) + 9.5, 40/2 - 20/2, SCW - 24 - CGRectGetMaxX(searchImage.frame) - 9.5 - 12, 20);
    
//    searchTextfield.sd_layout
//    .centerYEqualToView(searchView)
//    .leftSpaceToView(searchImage, 9.5)
//    .rightSpaceToView(searchView, 12)
//    .heightIs(20);

//    [headerView setupAutoHeightWithBottomView:searchView bottomMargin:12];
//    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    searchView.layer.cornerRadius = 20;
    searchView.layer.masksToBounds = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * NAMEOFCARGOCELLID = @"NAMEOFCARGOCELLID";
    RSNameOfCargoCell * cell = [tableView dequeueReusableCellWithIdentifier:NAMEOFCARGOCELLID];
    if (!cell) {
        cell = [[RSNameOfCargoCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NAMEOFCARGOCELLID];
    }
    if ([self.type isEqualToString:@"dealer"]) {
        cell.shippermodel = self.nameArray[indexPath.row];
    }else if ([self.type isEqualToString:@"warehouse"]){
        cell.warehousemodel = self.nameArray[indexPath.row];
    }else if ([self.type isEqualToString:@"storeArea"]){
        cell.storeAreamodel = self.nameArray[indexPath.row];
    }else if ([self.type isEqualToString:@"fee"]){
        cell.feemodel = self.nameArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.type isEqualToString:@"dealer"]) {
        RSShipperMode * shippermodel = self.nameArray[indexPath.row];
        if (self.block) {
            self.block(shippermodel, self.type);
        }
    }else if ([self.type isEqualToString:@"warehouse"]){
        RSWarehouseModel * warehousemodel = self.nameArray[indexPath.row];
        if (self.warehouseblock) {
            self.warehouseblock(warehousemodel, self.type);
        }
    }else if ([self.type isEqualToString:@"storeArea"]){
        RSStoreAreaModel * storeAreamodel = self.nameArray[indexPath.row];
        if (self.storeAreablock) {
            self.storeAreablock(storeAreamodel, self.type);
        }
    }else if ([self.type isEqualToString:@"fee"]){
        RSFeeModel * feemodel = self.nameArray[indexPath.row];
        if (self.feeblock) {
            self.feeblock(feemodel, self.type);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

- (void)findMailAction:(UITextField *)textfiled{
    NSString * temp = [textfiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([self.type isEqualToString:@"dealer"]) {
        RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"shipper.sqlite"];
        if ([temp length] > 0) {
            self.nameArray = [oaLocalDB serachContent:temp];
        }else{
            self.nameArray = [oaLocalDB getAllContent];
        }
    }else if ([self.type isEqualToString:@"warehouse"]){
        RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"warehouse.sqlite"];
        if ([temp length] > 0) {
            self.nameArray = [oaLocalDB serachContent:temp];
        }else{
            self.nameArray = [oaLocalDB getAllContent];
        }
        
    }else if ([self.type isEqualToString:@"storeArea"]){
        RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"storeArea.sqlite"];
        if ([temp length] > 0) {
            //self.nameArray = [oaLocalDB serachContent:temp];
            self.nameArray = [oaLocalDB serachNewContent:self.warehousemodel.warehouseId andName:temp];
        }else{
            self.nameArray = [oaLocalDB serachWhsID:self.warehousemodel.warehouseId];
        }
    }else if ([self.type isEqualToString:@"fee"]){
        RSOALocalDB * oaLocalDB = [[RSOALocalDB alloc]initWithCreatTypeList:@"fee.sqlite"];
       if ([temp length] > 0) {
           self.nameArray = [oaLocalDB serachContent:temp];
       }else{
           self.nameArray = [oaLocalDB getAllContent];
       }
    }
    [self.tableview reloadData];
}








@end
