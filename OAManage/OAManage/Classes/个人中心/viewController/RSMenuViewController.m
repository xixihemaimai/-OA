//
//  RSMenuViewController.m
//  OAManage
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSMenuViewController.h"
#import "RSCustomMenuCell.h"


#import "AppDelegate.h"
#import "RSLoginViewController.h"

#import "RSMenuHeaderFootView.h"


//个人信息
#import "RSPersonalInformationViewController.h"

#import "RSTouchViewController.h"

//关于我们
#import "RSAboutOurViewController.h"


@interface RSMenuViewController ()

@property (nonatomic,strong)NSMutableArray * menuArray;


@property (nonatomic,copy)NSString * mechanismName;

@end


@implementation RSMenuViewController

- (NSMutableArray *)menuArray{
    if (!_menuArray) {
        _menuArray = [NSMutableArray array];
    }
    return _menuArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}


static NSString * MENUHEADER = @"MENUHEADER";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * mechanismS = [user objectForKey:@"mechanismName"];
    self.mechanismName = mechanismS;
    if ([self.mechanismName isEqualToString:@"HX"]) {
        for (int i = 0; i < 5; i++) {
            NSString * str = [NSString stringWithFormat:@"%d",i];
            [self.menuArray addObject:str];
        }
    }else{
        for (int i = 0; i < 3; i++) {
            NSString * str = [NSString stringWithFormat:@"%d",i];
            [self.menuArray addObject:str];
        }
    }
    if (self.menuArray.count < 1) {
        self.emptyView.hidden = NO;
    }else{
        self.emptyView.hidden = YES;
        [self.tableview reloadData];
    }
    self.tableview.frame = CGRectMake(0, 0, SCW, SCH - Height_TabBar);
   //tableview的头部
    UIView * menuHeaderview = [[UIView alloc]init];
                               //WithFrame:CGRectMake(0, 0, SCW - 50, 200 * KScaleH)];
    menuHeaderview.backgroundColor =[UIColor colorWithHexColorStr:@"#27C79A"];
    
    
    //这边设置界面
    UIImageView * headerImageview = [[UIImageView alloc]init];
    headerImageview.image = [UIImage imageNamed:@"Group 2"];
    headerImageview.contentMode = UIViewContentModeScaleAspectFill;
    [menuHeaderview addSubview:headerImageview];
    
    
    //设置名字
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.text = [NSString stringWithFormat:@"%@",self.usermodel.userName];
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:Textadaptation(18)];
    [menuHeaderview addSubview:nameLabel];
    
    //设置部门
    UILabel * departmentLabel = [[UILabel alloc]init];
    departmentLabel.text = [NSString stringWithFormat:@"%@",self.usermodel.deptName];
    departmentLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    departmentLabel.textAlignment = NSTextAlignmentCenter;
    departmentLabel.font = [UIFont systemFontOfSize:Textadaptation(14)];
    [menuHeaderview addSubview:departmentLabel];
    
    
    //间距
//    UIView * midView = [[UIView alloc]init];
//    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
//    [menuHeaderview addSubview:midView];
    
    menuHeaderview.frame = CGRectMake(0, 0, SCW, 200);
    headerImageview.frame = CGRectMake(SCW/2 - 30, 200/2 - 30, 60, 60);
    nameLabel.frame = CGRectMake(12, CGRectGetMaxY(headerImageview.frame) + 2, SCW - 24, 25);
    departmentLabel.frame = CGRectMake(12, CGRectGetMaxY(nameLabel.frame) + 5, SCW - 24, 20);
//        menuHeaderview.sd_layout
//        .leftSpaceToView(self.tableview, 0)
//        .topSpaceToView(self.tableview, 0)
//        .rightSpaceToView(self.tableview, 0)
//        .heightIs(200);
        
        
//        headerImageview.sd_layout
//        .centerXEqualToView(menuHeaderview)
//        .centerYEqualToView(menuHeaderview)
//        .widthIs(60)
//        .heightEqualToWidth();
        
//        nameLabel.sd_layout
//        .topSpaceToView(headerImageview, 2)
//        .leftSpaceToView(menuHeaderview, 12)
//        .rightSpaceToView(menuHeaderview, 12)
//        .heightIs(25);
//
//        departmentLabel.sd_layout
//        .leftSpaceToView(menuHeaderview, 12)
//        .rightSpaceToView(menuHeaderview, 12)
//        .topSpaceToView(nameLabel, 5)
//        .heightIs(20);
//
     
        
    

    headerImageview.layer.cornerRadius = headerImageview.yj_width * 0.5;
//    headerImageview.layer.masksToBounds = YES;
    
//    [menuHeaderview layoutSubviews];
    self.tableview.tableHeaderView = menuHeaderview;
    
    //尾部视图
    UIView * menuFootView = [[UIView alloc]init];
    menuFootView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UIButton * footSignoutBtn = [[UIButton alloc]init];
    [footSignoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [footSignoutBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3FE4B1"]];
    [footSignoutBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    [footSignoutBtn addTarget:self action:@selector(signOutAction:) forControlEvents:UIControlEventTouchUpInside];
    footSignoutBtn.titleLabel.font = [UIFont systemFontOfSize:Textadaptation(15)];
    [menuFootView addSubview:footSignoutBtn];
    
//    footSignoutBtn.sd_layout
//    .topSpaceToView(menuFootView, 40)
//    .centerXEqualToView(menuFootView)
//    .leftSpaceToView(menuFootView, 54)
//    .rightSpaceToView(menuFootView, 54)
//    .heightIs(31 * KScaleH);
    
    menuFootView.frame = CGRectMake(0, 0, SCW, 40 + 31 * KScaleH + 20);
    footSignoutBtn.frame = CGRectMake(54, 40, SCW - 108, 31 * KScaleH);
    
    footSignoutBtn.layer.cornerRadius = 15;
//    footSignoutBtn.layer.masksToBounds = YES;
    
//    [menuFootView setupAutoHeightWithBottomView:footSignoutBtn bottomMargin:20];
//    [menuFootView layoutSubviews];
    self.tableview.tableFooterView = menuFootView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLMENUID = @"CELLMENUID";
    RSCustomMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLMENUID];
    if (!cell) {
        cell = [[RSCustomMenuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLMENUID];
    }
    if (indexPath.row == 0) {
        cell.menuImageView.image = [UIImage imageNamed:@"个人信息"];
        cell.menuLabel.text = @"账号与安全";
    }else if (indexPath.row == 1){
        cell.menuImageView.image = [UIImage imageNamed:@"清除缓存"];
        cell.menuLabel.text = @"清除缓存";
    }else if (indexPath.row == 2){
//        self.usermodel.OA_BM_IO 荒料
        if ([self.mechanismName isEqualToString:@"HX"]) {
            cell.menuImageView.image = [UIImage imageNamed:@"图标"];
            cell.menuLabel.text = @"荒料解控";
        }else{
            cell.menuImageView.image = [UIImage imageNamed:@"图标复制备份"];
             cell.menuLabel.text = @"关于我们";
        }
    }else if (indexPath.row == 3){
//        self.usermodel.OA_SL_IO  大板
        if ([self.mechanismName isEqualToString:@"HX"]) {
            cell.menuImageView.image = [UIImage imageNamed:@"图标复制"];
            cell.menuLabel.text = @"大板解控";
        }
    }else if (indexPath.row == 4){
        if ([self.mechanismName isEqualToString:@"HX"]) {
            cell.menuImageView.image = [UIImage imageNamed:@"图标复制备份"];
             cell.menuLabel.text = @"关于我们";
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (45 / SCW) * SCW;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSMenuHeaderFootView * menuHeaderView = [[RSMenuHeaderFootView alloc]initWithReuseIdentifier:MENUHEADER];
    //menuHeaderView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    return menuHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    [self didTableViewIndexpath:indexPath];
}

- (void)didTableViewIndexpath:(NSIndexPath *)indexpath{
    //[self.frostedViewController hideMenuViewController];
    if (indexpath.row == 0) {
        RSPersonalInformationViewController * personalInformationVc = [[RSPersonalInformationViewController alloc]init];
        [self.navigationController pushViewController:personalInformationVc animated:YES];
    }else if(indexpath.row == 1){
     //清除缓存
        //这句话是解决，清除缓存之后，在去点击视频，没有办法播放视频的问题
        [KTVHTTPCache cacheDeleteAllCaches];
       // NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        float MBCache = [self sizeOfDirectory:path];
        //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
         MBCache = MBCache/1000/1000;
        NSString * text = [NSString stringWithFormat:@"已清理:%0.3lfM",MBCache];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:text message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //这边是清理缓存
            //异步清除图片缓存 （磁盘中的）
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //[[SDImageCache sharedImageCache] clearMemory];
                [self deleteFileByPath:path];
            });
//            [KTVHTTPCache cacheDeleteAllCache];
        }];
        [alert addAction:actionConfirm];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alert.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexpath.row == 2){
        if ([self.mechanismName isEqualToString:@"HX"]) {
            RSTouchViewController * touchVc = [[RSTouchViewController alloc]init];
            touchVc.selectType = @"huangliao";
            [self.navigationController pushViewController:touchVc animated:YES];
        }else{
            RSAboutOurViewController * abountVc = [[RSAboutOurViewController alloc]init];
            [self.navigationController pushViewController:abountVc animated:YES];
        }
    }else if (indexpath.row == 3){
        if ([self.mechanismName isEqualToString:@"HX"]) {
            RSTouchViewController * touchVc = [[RSTouchViewController alloc]init];
            touchVc.selectType = @"daban";
            [self.navigationController pushViewController:touchVc animated:YES];
        }
    }else if (indexpath.row == 4){
        if ([self.mechanismName isEqualToString:@"HX"]) {
            RSAboutOurViewController * abountVc = [[RSAboutOurViewController alloc]init];
            [self.navigationController pushViewController:abountVc animated:YES];
        }
    }
}

//FIXME:退出
- (void)signOutAction:(UIButton *)signOutBtn{
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否退出App" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:true cancel:^{
        
        } confirm:^{
            NSString * canshu = URL_YIGODATA_APPLOGINTOKEN(self.usermodel.appLoginToken);
            NSString * sopaStr = URL_YIGODATA_IOS(URL_LOGINWEBSERVICE, URL_LOGOUT, canshu);
            NetworkTool * network = [[NetworkTool alloc]init];
            [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_LOGOUT];
        }];
   
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
