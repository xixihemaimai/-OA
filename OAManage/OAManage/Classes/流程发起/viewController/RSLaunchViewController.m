//
//  RSLaunchViewController.m
//  OAManage
//
//  Created by mac on 2019/11/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSLaunchViewController.h"
#import "RSLaunchCell.h"
#import "RSLaunchReusableView.h"
#import "RSLaunchFootReusableView.h"


#import "RSToBeInitiatedViewController.h"
#import "RSWKOAmanagerViewController.h"


@interface RSLaunchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

 @property (nonatomic,strong)UIView * headerView;

@property (nonatomic,strong) UILabel * headerLabel;


@property (nonatomic,strong)NSMutableArray * array;

@property (nonatomic,strong)UICollectionView * collectview;

@property (nonatomic,copy)NSString * mechanismName;

@end

@implementation RSLaunchViewController


-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

static NSString * COLLECTIONCELLID = @"COLLECTIONCELLID";
static NSString * LAUNCHREUSABLECELLID = @"LAUNCHREUSABLECELLID";
static NSString * LAUNCHREUSABFOOTCELLID = @"LAUNCHREUSABFOOTCELLID";

- (void)viewWillAppear:(BOOL)animated{
    
    [self reloadShenHeNewData];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadNoticationNew) name:@"reLoadCurrentViewData" object:nil];
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableview removeFromSuperview];
    [self.emptyView removeFromSuperview];
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * mechanismS = [user objectForKey:@"mechanismName"];
    self.mechanismName = mechanismS;
    
    self.array = [self changShowStyple];
    
    [self reloadShenHeNewData];
    
    
    [self setCustomHeaderView];
        
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(SCW/2 , 50);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    UICollectionView * collectview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCW,SCH - Height_NavBar - Height_TabBar - 40) collectionViewLayout:flowLayout];
    collectview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [collectview registerClass:[RSLaunchCell class] forCellWithReuseIdentifier:COLLECTIONCELLID];
    [collectview registerClass:[RSLaunchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LAUNCHREUSABLECELLID];
    [collectview registerClass:[RSLaunchFootReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:LAUNCHREUSABFOOTCELLID];
    collectview.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    collectview.delegate = self;
    collectview.dataSource = self;
    [self.view addSubview:collectview];
    self.collectview = collectview;
    
    self.title = @"流程发起";
}


//- (void)reloadNoticationNew{
//    [self reloadShenHeNewData];
//}

- (void)setCustomHeaderView{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIView * headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, SCW, 40);
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#FC8C78"];
    _headerView = headerView;
    
    UIButton * headerBtn = [[UIButton alloc]init];
    [headerView addSubview:headerBtn];
    headerBtn.frame = CGRectMake(0, 0, headerView.yj_width, 40);
//    headerBtn.sd_layout
//    .leftSpaceToView(headerView, 0)
//    .topSpaceToView(headerView, 0)
//    .rightSpaceToView(headerView, 0)
//    .heightIs(40);
    
    UILabel * headerLabel = [[UILabel alloc]init];
    headerLabel.text = @"你有0条待发起流程";
    headerLabel.font = [UIFont systemFontOfSize:15];
    headerLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerBtn addSubview:headerLabel];
    _headerLabel = headerLabel;
    headerLabel.frame = CGRectMake(12, 0, headerBtn.yj_width - 12, 40);
    
//    headerLabel.sd_layout
//    .leftSpaceToView(headerBtn, 12)
//    .topSpaceToView(headerBtn, 0)
//    .bottomSpaceToView(headerBtn, 0)
//    .rightSpaceToView(headerBtn, 0);
    
    [headerBtn addTarget:self action:@selector(showTobeInitianAction:) forControlEvents:UIControlEventTouchUpInside];

    
    
    //方向
    UIImageView * rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"system-backnew copy"];
    [headerBtn addSubview:rightImage];
    
    rightImage.frame = CGRectMake(headerBtn.yj_width - 7.5 - 12, 14, 7.5, 13);
    
//    rightImage.sd_layout
//    .rightSpaceToView(headerBtn, 12)
//    .topSpaceToView(headerBtn, 14)
//    .bottomSpaceToView(headerBtn, 14)
//    .widthIs(7.5)
//    .heightIs(13);
    
   // [headerView setupAutoHeightWithBottomView:headerBtn bottomMargin:0];
    //[headerView layoutSubviews];
    
    [self.view addSubview:headerView];
    
    
    
    //self.collectview.hea = headerView;
    //self.collectview.
}


- (void)reloadShenHeNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString *const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSNumber * number = [NSNumber numberWithInt:1];
    //NSString * notice = URL_YIGODATA_DATA(number,@(100));
    NSString * notice = URL_YIGODDATA_FLOWLIST(number, @(100), @"5", @"");
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_MYAUDIT, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_MYAUDIT];
    network.successArrayReload = ^(NSMutableArray *array) {
        if ((long)array.count < 1) {
            self.headerView.hidden = YES;
            self.headerView.yj_height = 0;
            self.collectview.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCW, SCH -  self.headerView.yj_height - Height_TabBar - Height_NavBar);
        }else{
            self.headerView.yj_height = 40;
            self.headerView.hidden = NO;
            self.collectview.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCW, SCH - self.headerView.yj_height - Height_TabBar - Height_NavBar);
            self.headerLabel.text = [NSString stringWithFormat:@"你有%ld条待发起流程",(long)array.count];
        }
    };
}


- (void)showTobeInitianAction:(UIButton *)headerBtn{
    RSToBeInitiatedViewController * tobeVc = [[RSToBeInitiatedViewController alloc]init];
    tobeVc.title = @"待发起流程";
    [self.navigationController pushViewController:tobeVc animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.array.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray * array = self.array[section];
    return array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RSLaunchCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLLECTIONCELLID forIndexPath:indexPath];
    NSMutableArray * array = self.array[indexPath.section];
    NSDictionary * dict = array[indexPath.row];
    cell.funtionImage.image = [UIImage imageNamed:dict[@"img"]];
    cell.funtionLabel.text = dict[@"title"];
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    NSMutableArray * array = self.array[section];
    if (array.count < 1) {
        return CGSizeMake(SCW, 0);
    }else{
        return CGSizeMake(SCW, 41);
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(SCW, 30);
    NSMutableArray * array = self.array[section];
    if (array.count < 1) {
        return CGSizeMake(SCW, 0);
    }else{
        return CGSizeMake(SCW, 30);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
       RSLaunchReusableView * header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LAUNCHREUSABLECELLID forIndexPath:indexPath];
        if (indexPath.section == 0) {
            header.launchLabel.text = @"行政流程";
        }else if (indexPath.section == 1){
             header.launchLabel.text = @"人事流程";
        }else if (indexPath.section == 2){
             header.launchLabel.text = @"印章管理流程";
        }else if (indexPath.section == 3){
            header.launchLabel.text = @"瑞石信息";
        }else if (indexPath.section == 4){
            header.launchLabel.text = @"设备采购";
        }else if (indexPath.section == 5){
            if ([self.mechanismName isEqualToString:@"HX"]) {
                header.launchLabel.text = @"其他";
            }else{
                header.launchLabel.text = @"费用流程";
            }
        }
        //header.launchLabel.text = @"好";
        return header;
    }else{
        RSLaunchFootReusableView * foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:LAUNCHREUSABFOOTCELLID forIndexPath:indexPath];
        //foot.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        return foot;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray * array = self.array[indexPath.section];
    NSDictionary * dict = array[indexPath.row];
    NSString * billkey = [dict objectForKey:@"key"];
    RSWKOAmanagerViewController * wkOaManagerVc = [[RSWKOAmanagerViewController alloc]init];
    wkOaManagerVc.type = @"2";
    wkOaManagerVc.title = [dict objectForKey:@"title"];
    wkOaManagerVc.billId = -1;
    wkOaManagerVc.isaddProcess = @"0";
    wkOaManagerVc.billKey = billkey;
    [self.navigationController pushViewController:wkOaManagerVc animated:YES];
    RSWeakself
    wkOaManagerVc.UpdateView = ^{
        [weakSelf reloadShenHeNewData];
    };
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 20;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"类型";
//}
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * CELLID = @"CELLID";
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = @"1";
//    cell.detailTextLabel.text = @"2";
//    return cell;
//}







//这边是变化有什么权限
- (NSMutableArray *)changShowStyple{
    
    //1.这边要判断有什么权限----大的统筹的地方，大的统筹的地方必须有小的权限
    //2.只要有一个小的权限就有大的统筹的地方
    NSMutableArray * array = [NSMutableArray array];
    //行政流程
    NSMutableArray * array1 = [NSMutableArray array];
    //人事流程
    NSMutableArray * array2 = [NSMutableArray array];
    //印章管理流程
    NSMutableArray * array3 = [NSMutableArray array];
    //瑞石信息
    NSMutableArray * array4 = [NSMutableArray array];
    //设备采购
    NSMutableArray * array5 = [NSMutableArray array];
    //其他
    NSMutableArray * array6 = [NSMutableArray array];
   
    
    /**部门ID    deptId
    "Flow_Purchase"                      行政采购审批            行政流程
    "Flow_Restaurant"                    自助餐厅报餐           行政流程
    "UseCar"                                   用车申请                  行政流程
    "Flow_Receptions"                   招待用品申购单        行政流程
    "Flow_SupplierConsume"        用品领用                   行政流程
    "Flow_VehicleReservation"      车辆预约登记            行政流程
    "Flow_ApplyActivity"                员工活动申请            行政流程
    "Entertain"                      招待住宿申请            行政流程
    "Flow_Entertain"                    招待申请                   行政流程
     
     
     Flow_ProcessChange            流程变更申请           行政流程
    

    "Flow_ApplyLeave"                 请假申请                   人事流程
    "Flow_BreakDown"                 调休申请单                人事流程
    "Flow_HumanNeed"               人力需求申请            人事流程
    "Flow_Quit"                             离职申请                   人事流程
    "Flow_PostMove"                    岗位异动                   人事流程
    "Flow_Become"                       转正申请                   人事流程
    "Flow_Business"                      出差审批流程           人事流程
    “Flow_WorkOvertime"             加班申请流程           人事流程
     
     
     
     Flow_Confirmation                   录用确认申请           人事流程
     Flow_GoOut                            外出申请                   人事流程
     Flow_ReplaceCard                  补卡申请                   人事流程
    
     
    "Flow_InvestContract"            招商合同审批表         印章管理流程
    "Flow_Contract"                     合同审批表                 印章管理流程
    "Flow_Cachet"                       印章外借使用申请      印章管理流程
    "Flow_InCachet"                    公章使用申请             印章管理流程
    "Flow_FileUpdate"                 文件编制修订废止申请单  印章管理流程
    "Flow_Chapter"                     海西股份刻章申请表  印章管理流程
    "Flow_SaleContract"             销售合同审批表         印章管理流程

    "Flow_RsPayment"               一般付款申请(瑞石)   瑞石信息
    "Flow_RsApplyLeave"          请假申请(瑞石)           瑞石信息
    "Flow_RsBreakDown"          调休申请(瑞石)           瑞石信息
    
    "Flow_Equipment"               设备采购申请单          设备采购
    "Flow_EquipService"           设备外协维修流程       设备采购
    
    
    "Flow_Payment"                 一般付款申请流程        其他流程
    "Flow_FixedAssets"           固定资产申购单            其他流程
    "Flow_Advertising"             广告制作申请单            其他流程
    "Flow_UsedIdle"                二手闲置处理申请单     其他流程
    "Flow_WasteDisposal"      废料处理申请单            其他流程
    "AM_Requisition"              辅料采购申购单            其他流程
    "AM_SetlleIn"                    辅料应付结算单            其他流程
    
    "Flow_SpecialApplication" 特殊申请审批流程    其他流程
     
     “Flow_Litigation”               诉讼需求申请表            其他流程
     Flow_Loan                         借款申请                      其他流程
     Flow_Promotion                 推广费用申请               其他流程
     
     
     
    
    
    "BM_OutNotice"  荒料发货通知  物流流程
    "BS_OutNotice"  荒料保税发货通知  物流流程
    "SL_OutNotice"   大板发货通知  物流流程
    "SM_Transfer"    条板调拨单      物流流程
    "ES_Transfer"     工程板调拨单  物流流程
    "SL_Transfer"     大板调拨单     物流流程
    "BM_Transfer"      荒料调拨单    物流流程
    "BL_OutNotice"  大板保税发货通知  物流流程
    "SM_SendNotice" 条板发货通知  物流流程
    "ES_OutNotice"  工程板发货通知流程  物流流程

    "BM_MtlReturn"    采购退货流程    销售流程
    "FG_EngQuotation" 工程项目报价表流程 销售流程
    "FG_ProcessProduct" 生产任务书流程 销售流程
    "FG_ProcessProtocol"销售确认书流程 销售流程
    "FG_ProfitQuote"利润分析报价表流程 销售流程
        
    "SC_PayIn"         收款单            财务流程
     */
    
    
    
    
    //行政流程  用品领用  发起流程复制 6
    //行政采购审批 自助餐厅报餐 用车申请 招待用品申购单   车辆预约登记 招待住宿申请 员工活动申请 招待申请
    //发起流程复制 发起流程复制 3 发起流程复制 2 发起流程复制 4 发起流程复制 5 发起流程复制 8 发起流程复制 7 发起流程复制 10 发起流程复制 9
    if (self.usermodel.Flow_Purchase == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制",@"title":@"行政采购审批",@"key":@"Flow_Purchase"};
        [array1 addObject:dict];
    }
    if (self.usermodel.Flow_Restaurant == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 3",@"title":@"自助餐厅报餐",@"key":@"Flow_Restaurant"};
        [array1 addObject:dict];
    }
    if (self.usermodel.Flow_UseCar == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 2",@"title":@"用车申请",@"key":@"Flow_UseCar"};
        [array1 addObject:dict];
    }
    if (self.usermodel.Flow_Receptions == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 4",@"title":@"招待用品申购单",@"key":@"Flow_Receptions"};
        [array1 addObject:dict];
    }
//    if (self.usermodel.Flow_SupplierConsume == true) {
//        NSDictionary * dict = @{@"img":@"发起流程复制 5",@"title":@"用品领用",@"key":@"Flow_SupplierConsume"};
//        [array1 addObject:dict];
//    }
    if (self.usermodel.Flow_VehicleReservation == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 8",@"title":@"车辆预约登记",@"key":@"Flow_VehicleReservation"};
        [array1 addObject:dict];
    }
    if (self.usermodel.Flow_ApplyActivity == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 7",@"title":@"员工活动申请",@"key":@"Flow_ApplyActivity"};
        [array1 addObject:dict];
    }
//    if (self.usermodel.Entertain == true) {
//        NSDictionary * dict = @{@"img":@"发起流程复制 10",@"title":@"招待住宿申请",@"key":@"Entertain"};
//        [array1 addObject:dict];
//    }
    if (self.usermodel.Flow_Entertain == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 10",@"title":@"招待住宿申请",@"key":@"Flow_Entertain"};
        [array1 addObject:dict];
    }
    if (self.usermodel.Flow_ProcessChange == true){
        NSDictionary * dict = @{@"img":@"发起流程复制 9",@"title":@" 流程变更申请",@"key":@"Flow_ProcessChange"};
        [array1 addObject:dict];
    }
    
    
    //泉州合成这边合同审批表 固定资产申购单 出差申请
    if ([self.mechanismName isEqualToString:@"HC"]) {
        
        if (self.usermodel.Flow_Contract == true) {
            NSDictionary * dict = @{@"img":@"发起流程复制 18",@"title":@"合同审批表",@"key":@"Flow_Contract"};
            [array1 addObject:dict];
        }
        
        if (self.usermodel.Flow_FixedAssets == true) {
            NSDictionary * dict = @{@"img":@"发起流程复制 30",@"title":@"固定资产申购单",@"key":@"Flow_FixedAssets"};
            [array1 addObject:dict];
        }
        
        if (self.usermodel.Flow_Business == true) {
            NSDictionary * dict = @{@"img":@"发起流程复制 17",@"title":@"出差审批流程",@"key":@"Flow_Business"};
            [array1 addObject:dict];
        }
        
        
    }
    
    
    
    
    [array addObject:array1];
   
   
              
    //人事流程
    //请假申请 调休申请 人力需求申请 离职申请 岗位异动 转正申请 出差审批流程
    //发起流程复制 12 发起流程复制 11 发起流程复制 14 发起流程复制 13 发起流程复制 16 发起流程复制 15 发起流程复制 17
    if (self.usermodel.Flow_ApplyLeave == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 12",@"title":@"请假申请",@"key":@"Flow_ApplyLeave"};
        [array2 addObject:dict];
    }
    if (self.usermodel.Flow_BreakDown == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 11",@"title":@"调休申请单",@"key":@"Flow_BreakDown"};
        [array2 addObject:dict];
    }
    if (self.usermodel.Flow_HumanNeed == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 14",@"title":@"人力需求申请",@"key":@"Flow_HumanNeed"};
        [array2 addObject:dict];
    }
    if (self.usermodel.Flow_Quit == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 13",@"title":@"离职申请",@"key":@"Flow_Quit"};
        [array2 addObject:dict];
    }
    if (self.usermodel.Flow_PostMove == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 16",@"title":@"岗位异动",@"key":@"Flow_PostMove"};
        [array2 addObject:dict];
    }
    if (self.usermodel.Flow_Become == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 15",@"title":@"转正申请",@"key":@"Flow_Become"};
        [array2 addObject:dict];
    }
    
    if ([self.mechanismName isEqualToString:@"HX"]) {
        if (self.usermodel.Flow_Business == true) {
            NSDictionary * dict = @{@"img":@"发起流程复制 17",@"title":@"出差审批流程",@"key":@"Flow_Business"};
            [array2 addObject:dict];
        }
    }
    
    if (self.usermodel.Flow_WorkOvertime == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 17",@"title":@"加班申请流程",@"key":@"Flow_WorkOvertime"};
        [array2 addObject:dict];
    }
    
    if (self.usermodel.Flow_Confirmation == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 17",@"title":@"录用确认申请",@"key":@"Flow_Confirmation"};
        [array2 addObject:dict];
    }
    
    if (self.usermodel.Flow_GoOut == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 17",@"title":@"外出申请",@"key":@"Flow_GoOut"};
        [array2 addObject:dict];
    }
    
    if (self.usermodel.Flow_ReplaceCard == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 17",@"title":@"补卡申请 ",@"key":@"Flow_ReplaceCard"};
        [array2 addObject:dict];
    }
    
    
    
      [array addObject:array2];
    
  
    
    //印章管理流程
    //招商合同审批表 合同审批表 印章外接使用申请 公章使用申请 文件编制修订废止 海西股份刻章申请 销售合同审批表
    //发起流程复制 19 发起流程复制 18 发起流程复制 21 发起流程复制 20 发起流程复制 23 发起流程复制 22 发起流程复制 24

//    if (self.usermodel.Flow_InvestContract == true) {
//        NSDictionary * dict = @{@"img":@"发起流程复制 19",@"title":@"招商合同审批表",@"key":@"Flow_InvestContract"};
//        [array3 addObject:dict];
//    }
    
    if ([self.mechanismName isEqualToString:@"HX"]) {
        if (self.usermodel.Flow_Contract == true) {
            NSDictionary * dict = @{@"img":@"发起流程复制 18",@"title":@"合同审批表",@"key":@"Flow_Contract"};
            [array3 addObject:dict];
        }
    }
    
    if (self.usermodel.Flow_Cachet == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 21",@"title":@"印章外借使用申请",@"key":@"Flow_Cachet"};
        [array3 addObject:dict];
    }
    if (self.usermodel.Flow_InCachet == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 20",@"title":@"公章使用申请",@"key":@"Flow_InCachet"};
        [array3 addObject:dict];
    }
//    if (self.usermodel.Flow_FileUpdate == true) {
//        NSDictionary * dict = @{@"img":@"发起流程复制 23",@"title":@"文件编制修订废止申请单",@"key":@"Flow_FileUpdate"};
//        [array3 addObject:dict];
//    }
    if (self.usermodel.Flow_Chapter == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 22",@"title":@"海西股份刻章申请表",@"key":@"Flow_Chapter"};
        [array3 addObject:dict];
    }
    if (self.usermodel.Flow_SaleContract == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 24",@"title":@"销售合同审批表",@"key":@"Flow_SaleContract"};
        [array3 addObject:dict];
    }
    
      [array addObject:array3];
    
    //瑞石信息
    //一般付款申请 调休申请 请假申请
    //发起流程复制 26 发起流程复制 25 发起流程复制 27
    if (self.usermodel.Flow_RsPayment == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 26",@"title":@"一般付款申请(瑞石)",@"key":@"Flow_RsPayment"};
        [array4 addObject:dict];
    }
    if (self.usermodel.Flow_RsApplyLeave == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 25",@"title":@"请假申请(瑞石)",@"key":@"Flow_RsApplyLeave"};
        [array4 addObject:dict];
    }
    if (self.usermodel.Flow_RsBreakDown == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 27",@"title":@"调休申请(瑞石)",@"key":@"Flow_RsBreakDown"};
        [array4 addObject:dict];
    }
      [array addObject:array4];
    
    
    
    //设备采购
    //设备采购申请单 设备外协维修流程
    //发起流程复制 29 发起流程复制 28
    if (self.usermodel.Flow_Equipment == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 29",@"title":@"设备采购申请单",@"key":@"Flow_Equipment"};
        [array5 addObject:dict];
    }
    if (self.usermodel.Flow_EquipService == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 28",@"title":@"设备外协维修流程",@"key":@"Flow_EquipService"};
        [array5 addObject:dict];
    }
    
      [array addObject:array5];
    
    
    //其他    可以在泉州合成为费用流程
    //一般付款申请流程 固定资产申请单 广告制作申请单 二手闲置处理申请单 辅料应付结算单 辅料采购申请单 废料处理申请单 物业服务审批 培训费用申请
    //发起流程复制 31 发起流程复制 30 发起流程复制 33 发起流程复制 32 发起流程复制 35 发起流程复制 34 发起流程复制 36
    if (self.usermodel.Flow_Payment == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 31",@"title":@"一般付款申请流程",@"key":@"Flow_Payment"};
        [array6 addObject:dict];
    }
    if ([self.mechanismName isEqualToString:@"HX"]) {
    
        if (self.usermodel.Flow_FixedAssets == true) {
            NSDictionary * dict = @{@"img":@"发起流程复制 30",@"title":@"固定资产申购单",@"key":@"Flow_FixedAssets"};
            [array6 addObject:dict];
        }
    }
    
    if (self.usermodel.Flow_Advertising == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 33",@"title":@"广告制作申请单",@"key":@"Flow_Advertising"};
        [array6 addObject:dict];
    }
    if (self.usermodel.Flow_UsedIdle == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 32",@"title":@"二手闲置处理申请单",@"key":@"Flow_UsedIdle"};
        [array6 addObject:dict];
    }
    if (self.usermodel.Flow_WasteDisposal == true) {
        NSDictionary * dict = @{@"img":@"发起流程复制 36",@"title":@"废料处理申请单",@"key":@"Flow_WasteDisposal"};
        [array6 addObject:dict];
    }
    
    if (self.usermodel.Flow_SpecialApplication == true) {
        NSDictionary * dict = @{@"img":@"特殊申请审批流程",@"title":@"特殊申请审批流程",@"key":@"Flow_SpecialApplication"};
        [array6 addObject:dict];
    }
    
    if (self.usermodel.Flow_PropertyServices == true) {
        NSDictionary * dict = @{@"img":@"物业服务审批",@"title":@"物业服务审批",@"key":@"Flow_PropertyServices"};
        [array6 addObject:dict];
    }
    
    if (self.usermodel.Flow_TrainingCosts == true) {
        NSDictionary * dict = @{@"img":@"培训费用申请",@"title":@"培训费用申请",@"key":@"Flow_TrainingCosts"};
        [array6 addObject:dict];
    }
    
    if (self.usermodel.Flow_Litigation == true){
        NSDictionary * dict = @{@"img":@"诉讼申请表",@"title":@"诉讼需求申请表",@"key":@"Flow_Litigation"};
        [array6 addObject:dict];
    }
    
    
    
    if (self.usermodel.Flow_Loan == true){
        NSDictionary * dict = @{@"img":@"诉讼申请表",@"title":@"借款申请",@"key":@"“Flow_Loan”"};
        [array6 addObject:dict];
    }
    
    if (self.usermodel.Flow_Promotion == true){
        NSDictionary * dict = @{@"img":@"诉讼申请表",@"title":@"推广费用申请",@"key":@"Flow_Promotion"};
        [array6 addObject:dict];
    }
    
    
    
//    if (self.usermodel.AM_Requisition == true) {
//        NSDictionary * dict = @{@"img":@"发起流程复制 34",@"title":@"辅料采购申购单",@"key":@"AM_Requisition"};
//        [array6 addObject:dict];
//    }
//    if (self.usermodel.AM_SetlleIn == true) {
//        NSDictionary * dict = @{@"img":@"发起流程复制 35",@"title":@"辅料应付结算单",@"key":@"AM_SetlleIn"};
//        [array6 addObject:dict];
//    }
      [array addObject:array6];
    
    
    
       
//    for (int i = 0; i < array.count; i++) {
//        NSMutableArray * array0 = array[i];
//        if (array0.count == 0) {
//            [array removeObjectAtIndex:i];
//        }
//    }
    [self.collectview reloadData];
    return array;
}


//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}





@end
