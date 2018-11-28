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
@interface RSMenuViewController ()

@property (nonatomic,strong)NSMutableArray * menuArray;




@end

static NSString * MENUHEADER = @"MENUHEADER";
@implementation RSMenuViewController

- (NSMutableArray *)menuArray{
    if (!_menuArray) {
        _menuArray = [NSMutableArray array];
    }
    return _menuArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 3; i++) {
        NSString * str = [NSString stringWithFormat:@"%d",i];
        [self.menuArray addObject:str];
    }
    if (self.menuArray.count < 1) {
        self.emptyView.hidden = NO;
    }else{
        self.emptyView.hidden = YES;
        [self.tableview reloadData];
    }
    
  
    
    
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
    
    
    
    
    
    if (IS_IPHONE) {
        
        menuHeaderview.sd_layout
        .leftSpaceToView(self.tableview, 0)
        .topSpaceToView(self.tableview, 0)
        .rightSpaceToView(self.tableview, 0)
        .heightIs(200);
        
        
        headerImageview.sd_layout
        .centerXEqualToView(menuHeaderview)
        .centerYEqualToView(menuHeaderview)
        .widthIs(60)
        .heightEqualToWidth();
        
        nameLabel.sd_layout
        .topSpaceToView(headerImageview, 2)
        .leftSpaceToView(menuHeaderview, 12)
        .rightSpaceToView(menuHeaderview, 12)
        .heightIs(25);
        
        departmentLabel.sd_layout
        .leftSpaceToView(menuHeaderview, 12)
        .rightSpaceToView(menuHeaderview, 12)
        .topSpaceToView(nameLabel, 5)
        .heightIs(20);
        
     
        
    }else{
        
        if (DEVICES_IS_PRO_12_9) {
            
            menuHeaderview.sd_layout
            .leftSpaceToView(self.tableview, 0)
            .topSpaceToView(self.tableview, 0)
            .rightSpaceToView(self.tableview, 0)
            .heightIs(200 * SCALE_TO_PRO);
            
            
            headerImageview.sd_layout
            .centerXEqualToView(menuHeaderview)
            .centerYEqualToView(menuHeaderview)
            .widthIs(60 * SCALE_TO_PRO)
            .heightEqualToWidth();
            
            nameLabel.sd_layout
            .topSpaceToView(headerImageview, 2)
            .leftSpaceToView(menuHeaderview, 12)
            .rightSpaceToView(menuHeaderview, 12)
            .heightIs(25 * SCALE_TO_PRO);
            
            departmentLabel.sd_layout
            .leftSpaceToView(menuHeaderview, 12)
            .rightSpaceToView(menuHeaderview, 12)
            .topSpaceToView(nameLabel, 5)
            .heightIs(20 * SCALE_TO_PRO);
        }else{
            
            menuHeaderview.sd_layout
            .leftSpaceToView(self.tableview, 0)
            .topSpaceToView(self.tableview, 0)
            .rightSpaceToView(self.tableview, 0)
            .heightIs( (200 / SCW) * SCW);
            
            headerImageview.sd_layout
            .centerXEqualToView(menuHeaderview)
            .centerYEqualToView(menuHeaderview)
            .widthIs((60 / SCW) * SCW)
            .heightEqualToWidth();
            
            nameLabel.sd_layout
            .topSpaceToView(headerImageview, 2)
            .leftSpaceToView(menuHeaderview, 12)
            .rightSpaceToView(menuHeaderview, 12)
            .heightIs((25 / SCW) * SCW);
            
            departmentLabel.sd_layout
            .leftSpaceToView(menuHeaderview, 12)
            .rightSpaceToView(menuHeaderview, 12)
            .topSpaceToView(nameLabel, 5)
            .heightIs((20 / SCW) * SCW);
            
           
        }
    }

    headerImageview.layer.cornerRadius = headerImageview.yj_width * 0.5;
    headerImageview.layer.masksToBounds = YES;
    
    [menuHeaderview layoutSubviews];
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
    
    footSignoutBtn.sd_layout
    .topSpaceToView(menuFootView, 40)
    .centerXEqualToView(menuFootView)
    .leftSpaceToView(menuFootView, 54)
    .rightSpaceToView(menuFootView, 54)
    .heightIs(31 * KScaleH);
    
    footSignoutBtn.layer.cornerRadius = 15;
    footSignoutBtn.layer.masksToBounds = YES;
    
    [menuFootView setupAutoHeightWithBottomView:footSignoutBtn bottomMargin:20];
    [menuFootView layoutSubviews];
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
        cell.menuLabel.text = @"个人信息";
    }else if (indexPath.row == 1){
        cell.menuImageView.image = [UIImage imageNamed:@"密码修改"];
        cell.menuLabel.text = @"密码修改";
    }else if (indexPath.row == 2){
        cell.menuImageView.image = [UIImage imageNamed:@"清除缓存"];
        cell.menuLabel.text = @"清除缓存";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IPHONE) {
        return (45 / SCW) * SCW;
    }else{
        if (DEVICES_IS_PRO_12_9) {
            return 60 * SCALE_TO_PRO;
        }else{
             return (60 / SCW) * SCW;
        }
    }
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
    if ([self.delegate respondsToSelector:@selector(didTableViewIndexpath:andViewController:)]) {
        [self.delegate didTableViewIndexpath:indexPath andViewController:self];
    }
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

//FIXME:退出
- (void)signOutAction:(UIButton *)signOutBtn{
    NSString * canshu = URL_YIGODATA_APPLOGINTOKEN(self.usermodel.appLoginToken);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_LOGINWEBSERVICE, URL_LOGOUT, canshu);
    NetworkTool * network = [[NetworkTool alloc]init];
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_LOGOUT];
 
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
