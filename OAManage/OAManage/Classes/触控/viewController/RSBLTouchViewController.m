//
//  RSBLTouchViewController.m
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBLTouchViewController.h"
#import "RSBLTouchCell.h"
#import "RSNameOfCargoViewController.h"
#import "RSStockViewController.h"


#import "RSSLTouchCell.h"
#import "RSSLHeaderView.h"
#import "RSSLFootView.h"

//荒料的模型
#import "RSBMStockModel.h"
//大板的模型
#import "RSSlStockModel.h"
#import "RSSLPieceModel.h"



@interface RSBLTouchViewController ()<RSStockViewControllerDelegate>

//货主
@property (nonatomic,strong)UIButton * nameBtn;
//仓库
@property (nonatomic,strong)UIButton * warehouseBtn;
//库存
@property (nonatomic,strong)UIButton * reservoirBtn;
//选择库存
@property (nonatomic,strong)UIButton * selectBtn;

//新建保存
@property (nonatomic,strong)UIButton * savebottomBtn;
//编辑和确认入库，删除view
@property (nonatomic,strong)UIView * editSureView;
//删除
@property (nonatomic,strong)UIButton * deleteBtn;
//编辑
@property (nonatomic,strong)UIButton * editBtn;
//确认入库
@property (nonatomic,strong)UIButton * sureBtn;

//取消编辑，修改保存view
@property (nonatomic,strong)UIView * allView;
//取消编辑
@property (nonatomic,strong)UIButton * cancelEditBtn;
//修改保存
@property (nonatomic,strong)UIButton * saveBtn;
//取消入库
@property (nonatomic,strong)UIButton * cancelBtn;


@property (nonatomic,strong)NSMutableArray * showArray;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)RSShipperMode * shippermodel;

@property (nonatomic,strong)RSWarehouseModel * warehousemodel;

@property (nonatomic,strong)RSStoreAreaModel * storeAreamodel;

//货主名称
@property (nonatomic,strong)UILabel * nameLabel;
//仓库
@property (nonatomic,strong)UILabel * warehouseLabel;
//库区
@property (nonatomic,strong)UILabel * reservoirLabel;

//总体积或者总面积
@property (nonatomic,strong)UILabel * totalLabel;

//保存选择的按键的类型
@property (nonatomic,strong)NSString * btnType;


@end




@implementation RSBLTouchViewController

- (RSShipperMode *)shippermodel{
    if (!_shippermodel) {
        _shippermodel = [[RSShipperMode alloc]init];
    }
    return _shippermodel;
}

- (RSWarehouseModel *)warehousemodel{
    if (!_warehousemodel) {
        _warehousemodel = [[RSWarehouseModel alloc]init];
    }
    return _warehousemodel;
}



- (RSStoreAreaModel *)storeAreamodel{
    if (!_storeAreamodel) {
        _storeAreamodel = [[RSStoreAreaModel alloc]init];
    }
    return _storeAreamodel;
}



- (RSTouchModel *)touchmodel{
    if (!_touchmodel) {
        _touchmodel = [[RSTouchModel alloc]init];
    }
    return _touchmodel;
}


-(NSMutableArray *)showArray{
    if (!_showArray) {
        _showArray = [NSMutableArray array];
    }
    return _showArray;
}





static NSString * SLHEADERVIEWID = @"SLHEADERVIEWID";
static NSString * SLFOOTVIEWID = @"SLFOOTVIEWID";
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.selectType isEqualToString:@"huangliao"]) {
       self.title = @"荒料解控单";
    }else{
       self.title = @"大板解控单";
    }
    self.pageNum = 1;
    self.emptyView.hidden = YES;
    
    self.tableview.frame = CGRectMake(0, navHeight + navY, SCW, SCH - (navHeight + navY));
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [self setCustomNavigaionView];
    [self setBLCustomHeaderView];
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
    [self setBLCustomFootView];
    [self setUIBottomView];
    [self seteditAndSureUI];
    [self setUICancelEditAndAllAndSaveSetUI];
    [self cancelSetUI];
    
    if ([self.showType isEqualToString:@"new"]) {
        
        self.btnType = @"edit";
        //点击新建的界面
        self.nameBtn.enabled = YES;
        if ([self.selectType isEqualToString:@"huangliao"]) {
            self.warehouseBtn.enabled = NO;
            self.reservoirBtn.enabled = NO;
            self.warehouseBtn.hidden = YES;
            self.reservoirBtn.hidden = YES;
        }else{
            self.warehouseBtn.enabled = YES;
            self.reservoirBtn.enabled = YES;
        }
         self.selectBtn.hidden = NO;
        
        //保存
         self.savebottomBtn.hidden = NO;
        //删除,编辑和确认
         self.editSureView.hidden = YES;
         self.editBtn.hidden = YES;
         self.sureBtn.hidden = YES;
         self.deleteBtn.hidden = YES;
        //取消,保存
         self.allView.hidden = YES;
         self.cancelEditBtn.hidden = YES;
         self.saveBtn.hidden = YES;
        //取消
         self.cancelBtn.hidden = YES;
        
        
    }else{
        self.btnType = @"save";
        
        
         self.nameBtn.enabled = NO;
        
        if ([self.selectType isEqualToString:@"huangliao"]) {
             self.warehouseBtn.enabled = NO;
             self.reservoirBtn.enabled = NO;
             self.warehouseBtn.hidden = YES;
             self.reservoirBtn.hidden = YES;
        }else{
             self.warehouseBtn.enabled = NO;
             self.reservoirBtn.enabled = NO;
        }
        
         self.selectBtn.hidden = YES;
        
        
        
        //点击cell跳转过来的值，要去加载数据
        //保存
         self.savebottomBtn.hidden = YES;
        
        //取消，保存
         self.allView.hidden = YES;
         self.cancelEditBtn.hidden = YES;
         self.saveBtn.hidden = YES;
       
        if (self.touchmodel.status == 0) {
            //删除,编辑和确认
             self.editSureView.hidden = NO;
             self.editBtn.hidden = NO;
             self.sureBtn.hidden = NO;
             self.deleteBtn.hidden = NO;
            //取消
             self.cancelBtn.hidden = YES;
           
        }else{
               //删除,编辑和确认
             self.editSureView.hidden = YES;
             self.editBtn.hidden = YES;
             self.sureBtn.hidden = YES;
             self.deleteBtn.hidden = YES;
              //取消
             self.cancelBtn.hidden = NO;
        }
        
        
       [self reloadOldSaveNewData];
        
        
        
    }
    
    
    
    
    
    
}



- (void)setCustomNavigaionView{
    
    CGFloat H = 0.0;
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        H = 88;
        Y = 49;
    }else{
        H = 64;
        Y = 25;
    }
    
    UIView * navigaionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, H)];
    navigaionView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:navigaionView];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(12, Y - 5, 40, 40);
    [leftBtn addTarget:self action:@selector(backOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [navigaionView addSubview:leftBtn];
    
    
    UILabel * contentTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCW/2 - 50, Y + 5, 100, 23)];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        contentTitleLabel.text = @"荒料解控单";
    }else{
        contentTitleLabel.text = @"大板解控单";
    }
    contentTitleLabel.font = [UIFont systemFontOfSize:17];
    contentTitleLabel.textColor = [UIColor blackColor];
    contentTitleLabel.textAlignment = NSTextAlignmentCenter;
    [navigaionView addSubview:contentTitleLabel];
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, H - 1, SCW, 1)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    [navigaionView addSubview:bottomview];
    
}



- (void)setBLCustomHeaderView{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#f3f3f3"];
    
    UIButton * nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nameBtn.frame = CGRectMake(0, 0, SCW, 48.5);
    [nameBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [nameBtn addTarget:self action:@selector(selectNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:nameBtn];
    _nameBtn = nameBtn;
    
    //货主名称
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"货主名称";
    //nameLabel.frame = CGRectMake(12, 15.5, SCW - 80, 21);
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [nameBtn addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    nameLabel.frame = CGRectMake(12, 48.5/2 - 21/2, SCW - 12 - 0.5, 21);
    
//    nameLabel.sd_layout
//    .centerYEqualToView(nameBtn)
//    .leftSpaceToView(nameBtn, 12)
//    .heightIs(21)
//    .rightSpaceToView(nameBtn, 0.5);
    
    
    
    UIImageView * rightImage = [[UIImageView alloc]init];
//    rightImage.frame = CGRectMake(SCW - 23, 15.5, 7.5, 13);
    rightImage.image = [UIImage imageNamed:@"system-backnew copy 5"];
    [nameBtn addSubview:rightImage];
    
    rightImage.frame = CGRectMake(SCW - 12 - 8.5, 48.5/2 - 15/2, 8.5, 15);
    
//    rightImage.sd_layout
//    .rightSpaceToView(nameBtn, 12)
//    .centerYEqualToView(nameBtn)
//    .widthIs(8.5)
//    .heightIs(15);
    
    UIView * inforamtionView = [[UIView alloc]init];
    
    
    if ([self.selectType isEqualToString:@"huangliao"]) {
        
        inforamtionView.frame = CGRectMake(0, CGRectGetMaxY(nameBtn.frame) + 10, SCW, 47);
        
        
    }else{
        
        UIButton * warehouseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        warehouseBtn.frame = CGRectMake(0, CGRectGetMaxY(nameBtn.frame) + 10, SCW, 48.5);
        [warehouseBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [warehouseBtn addTarget:self action:@selector(wareHouseAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:warehouseBtn];
        _warehouseBtn = warehouseBtn;
        
        //仓库
        UILabel * warehouseLabel = [[UILabel alloc]init];
        warehouseLabel.text = @"所属仓库";
        //nameLabel.frame = CGRectMake(12, 15.5, SCW - 80, 21);
        warehouseLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        warehouseLabel.textAlignment = NSTextAlignmentLeft;
        warehouseLabel.font = [UIFont systemFontOfSize:15];
        [warehouseBtn addSubview:warehouseLabel];
        _warehouseLabel = warehouseLabel;
        
        
        
        UIImageView * warehouseImage = [[UIImageView alloc]init];
         // rightImage.frame = CGRectMake(SCW - 23, 15.5, 7.5, 13);
          warehouseImage.image = [UIImage imageNamed:@"system-backnew copy 5"];
          [warehouseBtn addSubview:warehouseImage];
          
          
        
        
//        warehouseLabel.sd_layout
//        .centerYEqualToView(warehouseBtn)
//        .leftSpaceToView(warehouseBtn, 12)
//        .heightIs(21)
//        .rightSpaceToView(warehouseBtn, 0.5);
        warehouseLabel.frame = CGRectMake(12,48.5/2 - 21/2 , SCW - 12 - 0.5, 21);
        
//        warehouseImage.sd_layout
//        .rightSpaceToView(warehouseBtn, 12)
//        .centerYEqualToView(warehouseBtn)
//        .widthIs(8.5)
//        .heightIs(15);
        warehouseImage.frame = CGRectMake(SCW - 12, 48.5/2 - 15/2, 8.5, 15);
        
        UIButton * reservoirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        reservoirBtn.frame = CGRectMake(0, CGRectGetMaxY(warehouseBtn.frame) + 10, SCW, 48.5);
        [reservoirBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
        [reservoirBtn addTarget:self action:@selector(reservoirAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:reservoirBtn];
        _reservoirBtn = reservoirBtn;
        
        //仓库
        UILabel * reservoirLabel = [[UILabel alloc]init];
        reservoirLabel.text = @"所属库区";
        //nameLabel.frame = CGRectMake(12, 15.5, SCW - 80, 21);
        reservoirLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        reservoirLabel.textAlignment = NSTextAlignmentLeft;
        reservoirLabel.font = [UIFont systemFontOfSize:15];
        [reservoirBtn addSubview:reservoirLabel];
        _reservoirLabel = reservoirLabel;
        
        
        UIImageView * reservoirImage = [[UIImageView alloc]init];
        // rightImage.frame = CGRectMake(SCW - 23, 15.5, 7.5, 13);
         reservoirImage.image = [UIImage imageNamed:@"system-backnew copy 5"];
         [reservoirBtn addSubview:reservoirImage];
         
        
        reservoirLabel.frame = CGRectMake(12,48.5/2 - 21/2 , SCW - 12 - 0.5, 21);
        
//        warehouseImage.sd_layout
//        .rightSpaceToView(warehouseBtn, 12)
//        .centerYEqualToView(warehouseBtn)
//        .widthIs(8.5)
//        .heightIs(15);
        reservoirImage.frame = CGRectMake(SCW - 12, 48.5/2 - 15/2, 8.5, 15);
        
//        reservoirLabel.sd_layout
//        .centerYEqualToView(reservoirBtn)
//        .leftSpaceToView(reservoirBtn, 12)
//        .heightIs(21)
//        .rightSpaceToView(reservoirBtn, 0.5);
//
//        reservoirImage.sd_layout
//        .rightSpaceToView(reservoirBtn, 12)
//        .centerYEqualToView(reservoirBtn)
//        .widthIs(8.5)
//        .heightIs(15);
        
        
        inforamtionView.frame = CGRectMake(0, CGRectGetMaxY(reservoirBtn.frame) + 10, SCW, 47);
        
        
    }
    
    inforamtionView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    inforamtionView.userInteractionEnabled = YES;
    [headerView addSubview:inforamtionView];
    
    
    
    
    UILabel * materielLabel = [[UILabel alloc]init];
    materielLabel.text = @"物料信息";
    //materielLabel.frame = CGRectMake(12, 15.5, 70, 21);
    materielLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    materielLabel.textAlignment = NSTextAlignmentLeft;
    materielLabel.font = [UIFont systemFontOfSize:15];
    [inforamtionView addSubview:materielLabel];
    materielLabel.frame = CGRectMake(12, 47/2 - 21/2, 70, 21);
    
//    materielLabel.sd_layout
//    .leftSpaceToView(inforamtionView, 12)
//    .centerYEqualToView(inforamtionView)
//    .heightIs(21)
//    .widthIs(70);
    
    
    UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setTitle:@"选择库存" forState:UIControlStateNormal];
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [selectBtn addTarget:self action:@selector(selecctAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [selectBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#f5a623"]];
    [inforamtionView addSubview:selectBtn];
    _selectBtn = selectBtn;
    
    selectBtn.frame = CGRectMake(SCW - 12 - 85, 47/2 - 28/2, 85, 28);
    
//    selectBtn.sd_layout
//    .centerYEqualToView(inforamtionView)
//    .rightSpaceToView(inforamtionView, 12)
//    .widthIs(85)
//    .heightIs(28);
    
    selectBtn.layer.cornerRadius = 6;
    selectBtn.layer.masksToBounds = YES;
    
    
    if ([self.selectType isEqualToString:@"huangliao"]) {
        headerView.frame = CGRectMake(0, 0, SCW, 106);
    }else{
        headerView.frame = CGRectMake(0, 0, SCW, 48.5 + 48.5 + 48.5 + 80);
    }
    
//    [headerView setupAutoHeightWithBottomView:inforamtionView bottomMargin:0];
//    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}







- (void)setBLCustomFootView{
    
    UIView * footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    footView.frame = CGRectMake(0, SCH - 100, SCW, 50);
    footView.layer.shadowOpacity = 1;
    footView.layer.shadowRadius = 3;
    footView.layer.shadowColor = [UIColor colorWithHexColorStr:@"#E0E0E0"].CGColor;
    [self.view addSubview:footView];
    [footView bringSubviewToFront:self.view];
    
    
    UILabel * totalVolume = [[UILabel alloc]init];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        totalVolume.text = @"总体积(m³)";
    }else{
        totalVolume.text = @"总面积(m²)";
    }
    
    totalVolume.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    totalVolume.font = [UIFont systemFontOfSize:15];
    totalVolume.textAlignment = NSTextAlignmentLeft;
    totalVolume.frame = CGRectMake(12, 13.5, 80, 21);
    [footView addSubview:totalVolume];
    
    UILabel * totalLabel = [[UILabel alloc]init];
    totalLabel.text = @"0";
    totalLabel.textAlignment = NSTextAlignmentRight;
    totalLabel.font = [UIFont systemFontOfSize:15];
    totalLabel.frame = CGRectMake(CGRectGetMaxX(totalVolume.frame) + 10, 13.5, SCW - CGRectGetMaxX(totalVolume.frame) - 30, 21);
    [footView addSubview:totalLabel];
    _totalLabel = totalLabel;
    
}



- (void)setUIBottomView{
    UIButton * savebottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [savebottomBtn setTitle:@"保存" forState:UIControlStateNormal];
    [savebottomBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [savebottomBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27c79a"]];
    [savebottomBtn addTarget:self action:@selector(saveTouchAction:) forControlEvents:UIControlEventTouchUpInside];
    savebottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    savebottomBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    [self.view addSubview:savebottomBtn];
    [savebottomBtn bringSubviewToFront:self.view];
    _savebottomBtn = savebottomBtn;
}


//删除,编辑和确认
- (void)seteditAndSureUI{
    
    UIView * editSureView = [[UIView alloc]init];
    editSureView.frame = CGRectMake(0, SCH - 50, SCW, 50);
    editSureView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:editSureView];
    editSureView.hidden = YES;
    _editSureView = editSureView;
    //删除
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, 0, SCW/3 -1, 50);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27c79a"]];
    [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [editSureView addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteOutAction:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn = deleteBtn;
    deleteBtn.hidden = YES;
    //编辑
    UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(CGRectGetMaxX(deleteBtn.frame) + 1, 0, SCW/3 - 1, 50);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27c79a"]];
    [editBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [editBtn addTarget:self action:@selector(editOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [editSureView addSubview:editBtn];
    _editBtn = editBtn;
    editBtn.hidden = YES;
    //确认
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(CGRectGetMaxX(editBtn.frame) + 1, 0, SCW/3, 50);
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27c79a"]];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn addTarget:self action:@selector(sureOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [editSureView addSubview:sureBtn];
    _sureBtn = sureBtn;
    sureBtn.hidden = YES;
}



//取消  保存
- (void)setUICancelEditAndAllAndSaveSetUI{
    UIView * allView = [[UIView alloc]init];
    allView.frame = CGRectMake(0, SCH - 50, SCW, 50);
    allView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.view addSubview:allView];
    _allView = allView;
    allView.hidden = YES;
    
    UIButton * cancelEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelEditBtn.frame = CGRectMake(0, 0, SCW/2 - 0.5, 50);
    [cancelEditBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelEditBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27c79a"]];
    [cancelEditBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    cancelEditBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelEditBtn addTarget:self action:@selector(cancelOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [allView addSubview:cancelEditBtn];
    _cancelEditBtn = cancelEditBtn;
    cancelEditBtn.hidden = YES;
    
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(SCW/2 + 0.5 , 0, SCW/2 - 0.5, 50);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27c79a"]];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn addTarget:self action:@selector(saveOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [allView addSubview:saveBtn];
    _saveBtn = saveBtn;
    saveBtn.hidden = YES;
}


//取消入库
- (void)cancelSetUI{
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitle:@"取消确认" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27c79a"]];
    [cancelBtn addTarget:self action:@selector(cancelTwoOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    cancelBtn.hidden = YES;
}





- (void)backOutAction:(UIButton *)leftBtn{
    if ([self.showType isEqualToString:@"new"]) {
        if ( [self.btnType isEqualToString:@"edit"] && self.showArray.count > 0) {
            [JHSysAlertUtil presentAlertViewWithTitle:@"你的数据未保存,需要返回吗？" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            } confirm:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if ( [self.btnType isEqualToString:@"edit"] && self.showArray.count > 0) {
            [JHSysAlertUtil presentAlertViewWithTitle:@"你的数据未保存,需要返回吗?" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            } confirm:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


//保存的方法
- (void)saveTouchAction:(UIButton *)saveBtn{
    if ([self.selectType isEqualToString:@"huangliao"]) {
        if (self.showArray.count > 0 && self.shippermodel.shipperId != (long)nil) {
            self.btnType = @"save";
            [self newSaveBillNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有数据"];
        }
    }else{
        
        if (self.showArray.count > 0 && self.shippermodel.shipperId != (long)nil && self.warehousemodel.warehouseId != (long)nil && self.storeAreamodel.storeAreaId != (long)nil) {
                self.btnType = @"save";
                [self newSaveBillNewData];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有数据"];
        }
    }
}


- (void)deleteOutAction:(UIButton *)deleteBtn{
     //跳转到上一个页面
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除该数据" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        
    } confirm:^{
        self.btnType = @"save";
        [self deleteSureStorageBillNewData];
    }];
}

//编辑
- (void)editOutAction:(UIButton *)editBtn{
    self.btnType = @"edit";
    
    
     self.nameBtn.enabled = YES;
    
    if ([self.selectType isEqualToString:@"huangliao"]) {
                self.warehouseBtn.enabled = NO;
                self.reservoirBtn.enabled = NO;
                self.warehouseBtn.hidden = YES;
                self.reservoirBtn.hidden = YES;
    }else{
        self.warehouseBtn.enabled = YES;
         self.reservoirBtn.enabled = YES;
    }

     self.selectBtn.hidden = NO;
    
    
    //保存
     self.savebottomBtn.hidden = YES;
    //删除，编辑,确认
     self.editSureView.hidden = YES;
     self.deleteBtn.hidden = YES;
     self.editBtn.hidden = YES;
     self.sureBtn.hidden = YES;
    //取消，保存
     self.allView.hidden = NO;
     self.cancelEditBtn.hidden = NO;
     self.saveBtn.hidden = NO;
    //取消
     self.cancelBtn.hidden = YES;
    
    [self.tableview reloadData];
    
}

//确认入库
- (void)sureOutAction:(UIButton *)sureBtn{
    
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否确认完成" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
           
       } confirm:^{
            self.btnType = @"save";
             [self sureStorageBillNewData];
       }];
  
}

//取消编辑
- (void)cancelOutAction:(UIButton *)cancelEditBtn{
    self.btnType = @"save";
    
     self.nameBtn.enabled = NO;
    
    
    if ([self.selectType isEqualToString:@"huangliao"]) {
                  self.warehouseBtn.enabled = NO;
                  self.reservoirBtn.enabled = NO;
                  self.warehouseBtn.hidden = YES;
                  self.reservoirBtn.hidden = YES;
      }else{
         self.warehouseBtn.enabled = NO;
            self.reservoirBtn.enabled = NO;
      }
    
   
     self.selectBtn.hidden = YES;
    
    
    //保存
     self.savebottomBtn.hidden = YES;
    //删除，编辑,确认
     self.editSureView.hidden = NO;
     self.deleteBtn.hidden = NO;
     self.editBtn.hidden = NO;
     self.sureBtn.hidden = NO;
    //取消，保存
     self.allView.hidden = YES;
     self.cancelEditBtn.hidden = YES;
     self.saveBtn.hidden = YES;
    //删除
     self.cancelBtn.hidden = YES;
    //[self reloadOldSaveNewData];
    [self.navigationController popViewControllerAnimated:YES];
    
}

//修改保存
- (void)saveOutAction:(UIButton *)saveBtn{
    if (self.showArray.count > 0) {
        self.btnType = @"save";
        [self modifyAndSaveOutNewData];
    }else{
        [SVProgressHUD showInfoWithStatus:@"数据不完整"];
    }
}

//取消
- (void)cancelTwoOutAction:(UIButton *)cancelBtn{
    
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否取消确认完成" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        
    } confirm:^{
        self.btnType = @"save";
        [self cancelStorageBillNewData];
    }];
}



//新建
- (void)newSaveBillNewData{
    
    jxt_showLoadingHUDTitleMessage(@"请求中...", nil);
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
         NSString * aes = [user objectForKey:@"AES"];
         NSString *const kInitVector = @"16-Bytes--String";
         NetworkTool * network = [[NetworkTool alloc]init];
    NSString * type = [NSString string];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        type = @"BM_LiftControl";
    }else{
        type = @"SL_LiftControl";
    }
    
    NSMutableArray * array = [NSMutableArray array];
    NSMutableDictionary * paraDict = [NSMutableDictionary dictionary];
    NSString * jsonStr = [NSString string];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        [paraDict setValue:type forKey:@"billKey"];
        [paraDict setValue:[NSNumber numberWithInteger:self.usermodel.empId] forKey:@"empId"];
        [paraDict setValue:[NSNumber numberWithInteger:self.usermodel.deptId] forKey:@"deptId"];
        [paraDict setValue:[NSNumber numberWithInteger:0] forKey:@"billId"];
        [paraDict setValue:[NSNumber numberWithInteger:self.shippermodel.shipperId] forKey:@"deaId"];
        [paraDict setValue:self.shippermodel.name forKey:@"deaName"];
        [paraDict setValue:[NSNumber numberWithInteger:self.warehousemodel.warehouseId] forKey:@"whsId"];
        [paraDict setValue:self.warehousemodel.name forKey:@"whsName"];
        [paraDict setValue:[NSNumber numberWithInteger:self.storeAreamodel.storeAreaId] forKey:@"storeAreaId"];
        [paraDict setValue:self.storeAreamodel.name forKey:@"storeAreaName"];
        NSMutableArray * secondArray = [NSMutableArray array];
        for (int i = 0 ; i < self.showArray.count; i++) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            RSBMStockModel * bmstockmodel = self.showArray[i];
            [dict setValue:bmstockmodel.mtlName forKey:@"mtlName"];
            [dict setValue:[NSNumber numberWithInteger:bmstockmodel.did] forKey:@"did"];
            [dict setValue:bmstockmodel.volume forKey:@"volume"];
            [dict setValue:@"0" forKey:@"area"];
            [dict setValue:bmstockmodel.blockNo forKey:@"blockNo"];
            [dict setValue:@"" forKey:@"turnsNo"];
            [dict setValue:secondArray forKey:@"piece"];
            [array addObject:dict];
            [paraDict setValue:array forKey:@"turns"];
        }
    }else{
        [paraDict setValue:[NSNumber numberWithInteger:self.usermodel.empId] forKey:@"empId"];
        [paraDict setValue:[NSNumber numberWithInteger:self.usermodel.deptId] forKey:@"deptId"];
          [paraDict setValue:type forKey:@"billKey"];
          [paraDict setValue:[NSNumber numberWithInteger:0] forKey:@"billId"];
          [paraDict setValue:[NSNumber numberWithInteger:self.shippermodel.shipperId] forKey:@"deaId"];
          [paraDict setValue:self.shippermodel.name forKey:@"deaName"];
          [paraDict setValue:[NSNumber numberWithInteger:self.warehousemodel.warehouseId] forKey:@"whsId"];
          [paraDict setValue:self.warehousemodel.name forKey:@"whsName"];
          [paraDict setValue:[NSNumber numberWithInteger:self.storeAreamodel.storeAreaId] forKey:@"storeAreaId"];
          [paraDict setValue:self.storeAreamodel.name forKey:@"storeAreaName"];
        for (int i = 0 ; i < self.showArray.count; i++) {
            NSMutableArray * contentArray = self.showArray[i];
            RSSLPieceModel * slpiecemodel = contentArray[0];
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setValue:slpiecemodel.mtlName forKey:@"mtlName"];
            [paraDict setValue:[NSNumber numberWithInteger:0] forKey:@"did"];
            [dict setValue:[NSNumber numberWithInteger:0] forKey:@"volume"];
            [dict setValue:[NSNumber numberWithInteger:0] forKey:@"area"];
            [dict setValue:slpiecemodel.blockNo forKey:@"blockNo"];
            [dict setValue:slpiecemodel.turnsNo forKey:@"turnsNo"];
            [array addObject:dict];
            [paraDict setValue:array forKey:@"turns"];
            NSMutableArray * secondArray = [NSMutableArray array];
            NSMutableArray * tempArray = self.showArray[i];
            for (int j = 0; j < tempArray.count; j++) {
                NSMutableDictionary * dict1 = [NSMutableDictionary dictionary];
                RSSLPieceModel * slpiecemodel1 = tempArray[j];
                [dict1 setValue:[NSNumber numberWithInteger:slpiecemodel1.slNo] forKey:@"slNo"];
                [dict1 setValue:[NSNumber numberWithInteger:slpiecemodel1.did] forKey:@"did"];
                [dict1 setValue:slpiecemodel1.area forKey:@"area"];
                [secondArray addObject:dict1];
                [dict setValue:secondArray forKey:@"piece"];
            }
       }
    }
    NSData * data = [NSJSONSerialization dataWithJSONObject:paraDict options:NSJSONWritingPrettyPrinted error:nil];
     jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString * aes2 = [FSAES128 encryptAES:jsonStr key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_LIFTSAVE, canshu);
    RSWeakself
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_LIFTSAVE];
    network.successReload = ^(NSDictionary *dict) {
        jxt_dismissHUD();
        weakSelf.touchmodel.msids = dict[@"msids"];
        weakSelf.touchmodel.deaName = dict[@"deaName"];
        weakSelf.touchmodel.billId = [dict[@"billId"] integerValue];
        
         weakSelf.nameBtn.enabled = NO;
        //选择库存
         weakSelf.selectBtn.hidden = YES;
        //保存
         weakSelf.savebottomBtn.hidden = YES;
        
        //删除，编辑,确认
         weakSelf.editSureView.hidden = NO;
         weakSelf.deleteBtn.hidden = NO;
         weakSelf.editBtn.hidden = NO;
         weakSelf.sureBtn.hidden = NO;
        //取消，保存
         weakSelf.allView.hidden = YES;
         weakSelf.cancelEditBtn.hidden = YES;
         weakSelf.saveBtn.hidden = YES;
        //删除
         weakSelf.cancelBtn.hidden = YES;
        
      
        if ([weakSelf.selectType isEqualToString:@"huangliao"]) {
            
             weakSelf.warehouseBtn.hidden = YES;
             weakSelf.reservoirBtn.hidden = YES;
            
            weakSelf.totalLabel.text =  [NSString stringWithFormat:@"%0.3lf",[dict[@"totalVolume"] doubleValue]];
            
            //货主名
            weakSelf.shippermodel.shipperId = [dict[@"deaId"] integerValue];
            weakSelf.shippermodel.name = dict[@"deaName"];
            weakSelf.nameLabel.text = dict[@"deaName"];
            
            NSMutableArray * contentArray = [NSMutableArray array];
            NSMutableArray * tempArray = [NSMutableArray array];
            tempArray = dict[@"turns"];
            for (int i = 0; i < tempArray.count; i++) {
                NSMutableDictionary * dict = tempArray[i];
                RSBMStockModel * bmstockmodel = [[RSBMStockModel alloc]init];
                bmstockmodel.blockNo = dict[@"blockNo"];
                bmstockmodel.did = [dict[@"did"] integerValue];
                bmstockmodel.msid = dict[@"msid"];
                bmstockmodel.mtlName = dict[@"mtlName"];
                bmstockmodel.volume = dict[@"volume"];
                [contentArray addObject:bmstockmodel];
            }
            [weakSelf.showArray removeAllObjects];
            [weakSelf.showArray addObjectsFromArray:contentArray];
            
        }else{
             weakSelf.warehouseBtn.enabled = NO;
             weakSelf.reservoirBtn.enabled = NO;
            weakSelf.warehouseBtn.hidden = NO;
            weakSelf.reservoirBtn.hidden = NO;
            
            //货主名
            weakSelf.shippermodel.shipperId = [dict[@"deaId"] integerValue];
            weakSelf.shippermodel.name = dict[@"deaName"];
            //仓库名
            weakSelf.warehousemodel.warehouseId = [dict[@"whsId"] integerValue];
            weakSelf.warehousemodel.name = dict[@"whsName"];
            //库存名
            weakSelf.storeAreamodel.storeAreaId = [dict[@"storeAreaId"]integerValue];
            weakSelf.storeAreamodel.whsId = [dict[@"whsId"] integerValue];
            weakSelf.storeAreamodel.name = dict[@"storeAreaName"];
            
        
            
            weakSelf.totalLabel.text = [NSString stringWithFormat:@"%0.3lf",[dict[@"totalArea"] doubleValue]];
            
            weakSelf.warehouseLabel.text = dict[@"whsName"];
            weakSelf.reservoirLabel.text = dict[@"storeAreaName"];
            
            
            NSMutableArray * contentArray = [NSMutableArray array];
            
            NSMutableArray * tempArray = [NSMutableArray array];
            tempArray = dict[@"turns"];
            for (int i = 0; i < tempArray.count; i++) {
                NSMutableArray * pieceArray = [NSMutableArray array];
                NSMutableDictionary * dict = tempArray[i];
                pieceArray = dict[@"piece"];
                for (int j = 0; j < pieceArray.count; j++) {
                    NSMutableDictionary * dict = pieceArray[j];
                    RSSLPieceModel * slpiecemodel = [[RSSLPieceModel alloc]init];
                    slpiecemodel.area = dict[@"area"];
                    slpiecemodel.did = [dict[@"did"] integerValue];
                    slpiecemodel.slNo = [dict[@"slNo"] integerValue];
                    slpiecemodel.blockNo = dict[@"blockNo"];
                    slpiecemodel.mtlName = dict[@"mtlName"];
                    slpiecemodel.msid = dict[@"msid"];
                    slpiecemodel.turnsNo = dict[@"turnsNo"];
                    slpiecemodel.isbool = false;
                    slpiecemodel.isSelect = true;
                    [contentArray addObject:slpiecemodel];
                }
            }
            
            NSMutableArray * changeArray = [self changeNewArrayRule:contentArray];
            [weakSelf.showArray removeAllObjects];
            [weakSelf.showArray addObjectsFromArray:changeArray];
            
        }
        if (weakSelf.reload) {
                           weakSelf.reload(true);
                       }
        [weakSelf.tableview reloadData];
    };
    network.failure = ^(NSDictionary *dict) {
        //jxt_dismissHUD();
//         jxt_showToastMessage(dict[@"message"], 0.75);
        //选择库存
        weakSelf.selectBtn.hidden = NO;
        //保存
        weakSelf.savebottomBtn.hidden = NO;
        
        //删除，编辑,确认
        weakSelf.editSureView.hidden = YES;
        weakSelf.deleteBtn.hidden = YES;
        weakSelf.editBtn.hidden = YES;
        weakSelf.sureBtn.hidden = YES;
        //取消，保存
        weakSelf.allView.hidden = YES;
        weakSelf.cancelEditBtn.hidden = YES;
        weakSelf.saveBtn.hidden = YES;
        //删除
        weakSelf.cancelBtn.hidden = YES;
        weakSelf.nameBtn.enabled = YES;
        if ([self.selectType isEqualToString:@"huangliao"]) {
            weakSelf.warehouseBtn.hidden = YES;
            weakSelf.reservoirBtn.hidden = YES;
        }else{
            weakSelf.warehouseBtn.enabled = YES;
            weakSelf.reservoirBtn.enabled = YES;
            weakSelf.warehouseBtn.hidden = NO;
            weakSelf.reservoirBtn.hidden = NO;
        }
    };
}



//修改URL_LIFTUPDATE
- (void)modifyAndSaveOutNewData{
  jxt_showLoadingHUDTitleMessage(@"请求中...", nil);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            NSString * aes = [user objectForKey:@"AES"];
            NSString *const kInitVector = @"16-Bytes--String";
            NetworkTool * network = [[NetworkTool alloc]init];
      NSString * type = [NSString string];
      if ([self.selectType isEqualToString:@"huangliao"]) {
          type = @"BM_LiftControl";
      }else{
          type = @"SL_LiftControl";
      }
      
      NSMutableArray * array = [NSMutableArray array];
      NSMutableDictionary * paraDict = [NSMutableDictionary dictionary];
      NSString * jsonStr = [NSString string];
      if ([self.selectType isEqualToString:@"huangliao"]) {
          [paraDict setValue:type forKey:@"billKey"];
          [paraDict setValue:[NSNumber numberWithInteger:self.usermodel.empId] forKey:@"empId"];
          [paraDict setValue:[NSNumber numberWithInteger:self.usermodel.deptId] forKey:@"deptId"];
          [paraDict setValue:[NSNumber numberWithInteger:self.touchmodel.billId] forKey:@"billId"];
          [paraDict setValue:[NSNumber numberWithInteger:self.shippermodel.shipperId] forKey:@"deaId"];
          [paraDict setValue:self.shippermodel.name forKey:@"deaName"];
          [paraDict setValue:[NSNumber numberWithInteger:self.warehousemodel.warehouseId] forKey:@"whsId"];
          [paraDict setValue:self.warehousemodel.name forKey:@"whsName"];
          [paraDict setValue:[NSNumber numberWithInteger:self.storeAreamodel.storeAreaId] forKey:@"storeAreaId"];
          [paraDict setValue:self.storeAreamodel.name forKey:@"storeAreaName"];
          NSMutableArray * secondArray = [NSMutableArray array];
          for (int i = 0 ; i < self.showArray.count; i++) {
              NSMutableDictionary * dict = [NSMutableDictionary dictionary];
              RSBMStockModel * bmstockmodel = self.showArray[i];
              [dict setValue:bmstockmodel.mtlName forKey:@"mtlName"];
              [dict setValue:[NSNumber numberWithInteger:bmstockmodel.did] forKey:@"did"];
              [dict setValue:bmstockmodel.volume forKey:@"volume"];
              [dict setValue:@"0" forKey:@"area"];
              [dict setValue:bmstockmodel.blockNo forKey:@"blockNo"];
              [dict setValue:@"" forKey:@"turnsNo"];
              [dict setValue:secondArray forKey:@"piece"];
              [array addObject:dict];
              [paraDict setValue:array forKey:@"turns"];
          }
         
      }else{
          [paraDict setValue:[NSNumber numberWithInteger:self.usermodel.empId] forKey:@"empId"];
          [paraDict setValue:[NSNumber numberWithInteger:self.usermodel.deptId] forKey:@"deptId"];
            [paraDict setValue:type forKey:@"billKey"];
            [paraDict setValue:[NSNumber numberWithInteger:self.touchmodel.billId] forKey:@"billId"];
            [paraDict setValue:[NSNumber numberWithInteger:self.shippermodel.shipperId] forKey:@"deaId"];
            [paraDict setValue:self.shippermodel.name forKey:@"deaName"];
            [paraDict setValue:[NSNumber numberWithInteger:self.warehousemodel.warehouseId] forKey:@"whsId"];
            [paraDict setValue:self.warehousemodel.name forKey:@"whsName"];
            [paraDict setValue:[NSNumber numberWithInteger:self.storeAreamodel.storeAreaId] forKey:@"storeAreaId"];
            [paraDict setValue:self.storeAreamodel.name forKey:@"storeAreaName"];
          for (int i = 0 ; i < self.showArray.count; i++) {
              NSMutableArray * contentArray = self.showArray[i];
              RSSLPieceModel * slpiecemodel = contentArray[0];
              NSMutableDictionary * dict = [NSMutableDictionary dictionary];
              [dict setValue:slpiecemodel.mtlName forKey:@"mtlName"];
              [paraDict setValue:[NSNumber numberWithInteger:0] forKey:@"did"];
              [dict setValue:[NSNumber numberWithInteger:0] forKey:@"volume"];
              [dict setValue:[NSNumber numberWithInteger:0] forKey:@"area"];
              [dict setValue:slpiecemodel.blockNo forKey:@"blockNo"];
              [dict setValue:slpiecemodel.turnsNo forKey:@"turnsNo"];
              [array addObject:dict];
              [paraDict setValue:array forKey:@"turns"];
              NSMutableArray * secondArray = [NSMutableArray array];
              NSMutableArray * tempArray = self.showArray[i];
              for (int j = 0; j < tempArray.count; j++) {
                  NSMutableDictionary * dict1 = [NSMutableDictionary dictionary];
                  RSSLPieceModel * slpiecemodel1 = tempArray[j];
                  [dict1 setValue:[NSNumber numberWithInteger:slpiecemodel1.slNo] forKey:@"slNo"];
                  [dict1 setValue:[NSNumber numberWithInteger:slpiecemodel1.did] forKey:@"did"];
                  [dict1 setValue:slpiecemodel1.area forKey:@"area"];
                  [secondArray addObject:dict1];
                  [dict setValue:secondArray forKey:@"piece"];
              }
         }
      }
    RSWeakself
    NSData * data = [NSJSONSerialization dataWithJSONObject:paraDict options:NSJSONWritingPrettyPrinted error:nil];
    jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSString * aes2 = [FSAES128 encryptAES:jsonStr key:aes andKInItVector:kInitVector];
            NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
            NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_LIFTUPDATE, canshu);
            [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_LIFTUPDATE];
    
    
    network.successReload = ^(NSDictionary *dict) {
        jxt_dismissHUD();
        
        weakSelf.touchmodel.msids = dict[@"msids"];
        weakSelf.touchmodel.deaName = dict[@"deaName"];
        weakSelf.touchmodel.billId = [dict[@"billId"] integerValue];
                
        weakSelf.nameBtn.enabled = NO;
        
        
        weakSelf.selectBtn.hidden = YES;
        
        
        
        weakSelf.savebottomBtn.hidden = YES;
        weakSelf.editSureView.hidden = NO;
        weakSelf.deleteBtn.hidden = NO;
        weakSelf.editBtn.hidden = NO;
        weakSelf.sureBtn.hidden = NO;
                
        weakSelf.allView.hidden = YES;
        weakSelf.cancelEditBtn.hidden = YES;
        weakSelf.saveBtn.hidden = YES;
                       
        weakSelf.cancelBtn.hidden = YES;
        
        
        
        
        
        
                if ([weakSelf.selectType isEqualToString:@"huangliao"]) {
                    
                    weakSelf.warehouseBtn.hidden = YES;
                    weakSelf.reservoirBtn.hidden = YES;

                   weakSelf.shippermodel.shipperId = [dict[@"deaId"]integerValue];
                   weakSelf.shippermodel.name = dict[@"deaName"];
                   weakSelf.nameLabel.text = dict[@"deaName"];
                   weakSelf.totalLabel.text = [NSString stringWithFormat:@"%0.3lf",[dict[@"totalVolume"] doubleValue]];
                    
                    
                    NSMutableArray * contentArray = [NSMutableArray array];
                    NSMutableArray * tempArray = [NSMutableArray array];
                    tempArray = dict[@"turns"];
                    for (int i = 0; i < tempArray.count; i++) {
                        NSMutableDictionary * dict = tempArray[i];
                        RSBMStockModel * bmstockmodel = [[RSBMStockModel alloc]init];
                        bmstockmodel.blockNo = dict[@"blockNo"];
                        bmstockmodel.did = [dict[@"did"] integerValue];
                        bmstockmodel.msid = dict[@"msid"];
                        bmstockmodel.mtlName = dict[@"mtlName"];
                        bmstockmodel.volume = dict[@"volume"];
                        [contentArray addObject:bmstockmodel];
                    }
                    [weakSelf.showArray removeAllObjects];
                    [weakSelf.showArray addObjectsFromArray:contentArray];
                    if (weakSelf.reload) {
                                       weakSelf.reload(true);
                                   }
                    [weakSelf.tableview reloadData];
                }else{
                    weakSelf.warehouseBtn.enabled = YES;
                    weakSelf.reservoirBtn.enabled = YES;
                    weakSelf.warehouseBtn.hidden = NO;
                    weakSelf.reservoirBtn.hidden = NO;
                    
                    weakSelf.shippermodel.shipperId = [dict[@"deaId"]integerValue];
                    weakSelf.shippermodel.name = dict[@"deaName"];
                    weakSelf.nameLabel.text = dict[@"deaName"];
                    
                    
                    weakSelf.warehousemodel.warehouseId = [dict[@"whsId"]integerValue];
                    weakSelf.warehousemodel.name =dict[@"whsName"];
                    weakSelf.warehouseLabel.text = dict[@"whsName"];
                    
                    weakSelf.storeAreamodel.storeAreaId = [dict[@"storeAreaId"]integerValue];
                    weakSelf.storeAreamodel.whsId = [dict[@"whsId"]integerValue];
                    weakSelf.storeAreamodel.name = dict[@"storeAreaName"];
                    weakSelf.reservoirLabel.text = dict[@"storeAreaName"];
                    
                    weakSelf.warehouseLabel.text = dict[@"whsName"];
                    weakSelf.reservoirLabel.text = dict[@"storeAreaName"];
                    weakSelf.totalLabel.text = [NSString stringWithFormat:@"%0.3lf",[dict[@"totalArea"] doubleValue]];
                    
                    NSMutableArray * contentArray = [NSMutableArray array];
                               
                               NSMutableArray * tempArray = [NSMutableArray array];
                               tempArray = dict[@"turns"];
                               for (int i = 0; i < tempArray.count; i++) {
                                   NSMutableArray * pieceArray = [NSMutableArray array];
                                   NSMutableDictionary * dict = tempArray[i];
                                   pieceArray = dict[@"piece"];
                                   for (int j = 0; j < pieceArray.count; j++) {
                                       NSMutableDictionary * dict = pieceArray[j];
                                       RSSLPieceModel * slpiecemodel = [[RSSLPieceModel alloc]init];
                                       slpiecemodel.area = dict[@"area"];
                                        slpiecemodel.blockNo = dict[@"blockNo"];
                                       slpiecemodel.did = [dict[@"did"] integerValue];
                                       slpiecemodel.msid = dict[@"msid"];
                                        slpiecemodel.mtlName = dict[@"mtlName"];
                                       slpiecemodel.turnsNo = dict[@"turnsNo"];
                                       slpiecemodel.slNo = [dict[@"slNo"] integerValue];
                                       slpiecemodel.isbool = false;
                                       slpiecemodel.isSelect = true;
                                       [contentArray addObject:slpiecemodel];
                                   }
                               }
                               
                               NSMutableArray * changeArray = [self changeNewArrayRule:contentArray];
                               [weakSelf.showArray removeAllObjects];
                               [weakSelf.showArray addObjectsFromArray:changeArray];
                    if (weakSelf.reload) {
                                       weakSelf.reload(true);
                                   }
                    
                    [weakSelf.tableview reloadData];
                }
        
        
    };
      
    
    network.failure = ^(NSDictionary *dict) {
       
       // jxt_dismissHUD();
       // jxt_showToastMessage(dict[@"message"], 0.75);
        
        weakSelf.nameBtn.enabled = YES;
        weakSelf.selectBtn.hidden = NO;
        
        
        weakSelf.savebottomBtn.hidden = YES;
       
        
           
        weakSelf.editSureView.hidden = YES;
        weakSelf.deleteBtn.hidden = YES;
        weakSelf.editBtn.hidden = YES;
        weakSelf.sureBtn.hidden = YES;
            
        weakSelf.allView.hidden = NO;
        weakSelf.cancelEditBtn.hidden = NO;
        weakSelf.saveBtn.hidden = NO;
                
        weakSelf.cancelBtn.hidden = YES;
        
        
        if ([weakSelf.selectType isEqualToString:@"huangliao"]) {
            
            weakSelf.warehouseBtn.hidden = YES;
            weakSelf.reservoirBtn.hidden = YES;
            
            
        }else{
            
            weakSelf.warehouseBtn.enabled = YES;
            weakSelf.reservoirBtn.enabled = YES;
            weakSelf.warehouseBtn.hidden = NO;
            weakSelf.reservoirBtn.hidden = NO;
            
            
        }
    };
}


//确认
- (void)sureStorageBillNewData{
    
 jxt_showLoadingHUDTitleMessage(@"请求中...", nil);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
         NSString * aes = [user objectForKey:@"AES"];
         NSString *const kInitVector = @"16-Bytes--String";
         NetworkTool * network = [[NetworkTool alloc]init];
    NSString * type = [NSString string];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        type = @"BM_LiftControl";
    }else{
        type = @"SL_LiftControl";
    }
    RSWeakself
    NSMutableDictionary * paraDict = [NSMutableDictionary dictionary];
    [paraDict setValue:type forKey:@"billKey"];
    [paraDict setValue:[NSNumber numberWithInteger:self.touchmodel.billId] forKey:@"billId"];
    NSData * data = [NSJSONSerialization dataWithJSONObject:paraDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString * aes2 = [FSAES128 encryptAES:jsonStr key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_LIFTSTATE, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_LIFTSTATE];
    network.successReload = ^(NSDictionary *dict) {
        jxt_dismissHUD();
        weakSelf.nameBtn.enabled = NO;
        weakSelf.selectBtn.hidden = YES;
        
        weakSelf.savebottomBtn.hidden = YES;
        
        if ([weakSelf.selectType isEqualToString:@"huangliao"]) {
            weakSelf.warehouseBtn.hidden = YES;
            weakSelf.reservoirBtn.hidden = YES;

                           
        }else{
            weakSelf.warehouseBtn.enabled = NO;
            weakSelf.reservoirBtn.enabled = NO;
            weakSelf.warehouseBtn.hidden = NO;
            weakSelf.reservoirBtn.hidden = NO;
        }
        weakSelf.editSureView.hidden = YES;
        weakSelf.deleteBtn.hidden = YES;
        weakSelf.editBtn.hidden = YES;
        weakSelf.sureBtn.hidden = YES;
        
        weakSelf.allView.hidden = YES;
        weakSelf.cancelEditBtn.hidden = YES;
        weakSelf.saveBtn.hidden = YES;
        
        weakSelf.cancelBtn.hidden = NO;
        
        
        if (weakSelf.reload) {
                           weakSelf.reload(true);
                       }
        [weakSelf.tableview reloadData];
        
        
        
    };
      
    
    network.failure = ^(NSDictionary *dict) {
        
        // jxt_showToastMessage(dict[@"message"], 0.75);
        
       // jxt_dismissHUD();
      weakSelf.nameBtn.enabled = NO;
      weakSelf.selectBtn.hidden = YES;
      
      weakSelf.savebottomBtn.hidden = YES;
      if ([weakSelf.selectType isEqualToString:@"huangliao"]) {
          weakSelf.warehouseBtn.hidden = YES;
          weakSelf.reservoirBtn.hidden = YES;

                         
      }else{
          weakSelf.warehouseBtn.enabled = NO;
          weakSelf.reservoirBtn.enabled = NO;
          weakSelf.warehouseBtn.hidden = NO;
          weakSelf.reservoirBtn.hidden = NO;
      }
     weakSelf.editSureView.hidden = NO;
      weakSelf.deleteBtn.hidden = NO;
      weakSelf.editBtn.hidden = NO;
      weakSelf.sureBtn.hidden = NO;
      
       weakSelf.allView.hidden = YES;
       weakSelf.cancelEditBtn.hidden = YES;
       weakSelf.saveBtn.hidden = YES;
        weakSelf.cancelBtn.hidden = YES;
    };
}

//取消确认解控单
- (void)cancelStorageBillNewData{
    jxt_showLoadingHUDTitleMessage(@"请求中...", nil);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            NSString * aes = [user objectForKey:@"AES"];
            NSString *const kInitVector = @"16-Bytes--String";
        NetworkTool * network = [[NetworkTool alloc]init];
       NSString * type = [NSString string];
       if ([self.selectType isEqualToString:@"huangliao"]) {
           type = @"BM_LiftControl";
       }else{
           type = @"SL_LiftControl";
       }
    RSWeakself
      NSMutableDictionary * paraDict = [NSMutableDictionary dictionary];
         [paraDict setValue:type forKey:@"billKey"];
         [paraDict setValue:[NSNumber numberWithInteger:self.touchmodel.billId] forKey:@"billId"];
         NSData * data = [NSJSONSerialization dataWithJSONObject:paraDict options:NSJSONWritingPrettyPrinted error:nil];
         NSString * jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         
            NSString * aes2 = [FSAES128 encryptAES:jsonStr key:aes andKInItVector:kInitVector];
            NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
            NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_LIFTSTATE, canshu);
            [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_LIFTSTATE];
    network.successReload = ^(NSDictionary *dict) {
        jxt_dismissHUD();
        weakSelf.nameBtn.enabled = NO;
        weakSelf.selectBtn.hidden = YES;
        
        weakSelf.savebottomBtn.hidden = YES;
        
        if ([weakSelf.selectType isEqualToString:@"huangliao"]) {
            weakSelf.warehouseBtn.hidden = YES;
            weakSelf.reservoirBtn.hidden = YES;

                           
        }else{
            weakSelf.warehouseBtn.enabled = NO;
            weakSelf.reservoirBtn.enabled = NO;
            weakSelf.warehouseBtn.hidden = NO;
            weakSelf.reservoirBtn.hidden = NO;
        }
        weakSelf.editSureView.hidden = NO;
        weakSelf.deleteBtn.hidden = NO;
        weakSelf.editBtn.hidden = NO;
        weakSelf.sureBtn.hidden = NO;
                       
        weakSelf.allView.hidden = YES;
        weakSelf.cancelEditBtn.hidden = YES;
        weakSelf.saveBtn.hidden = YES;
                       
        weakSelf.cancelBtn.hidden = YES;
        
        if (weakSelf.reload) {
          weakSelf.reload(true);
        }
        
        
        [weakSelf.tableview reloadData];
    };
      
    
    network.failure = ^(NSDictionary *dict) {
       //  jxt_showToastMessage(dict[@"message"], 0.75);
        //jxt_dismissHUD();
      
        weakSelf.nameBtn.enabled = NO;
        weakSelf.selectBtn.hidden = YES;
        
        weakSelf.savebottomBtn.hidden = YES;
        if ([weakSelf.selectType isEqualToString:@"huangliao"]) {
            weakSelf.warehouseBtn.hidden = YES;
            weakSelf.reservoirBtn.hidden = YES;

                           
        }else{
            weakSelf.warehouseBtn.enabled = NO;
            weakSelf.reservoirBtn.enabled = NO;
            weakSelf.warehouseBtn.hidden = NO;
            weakSelf.reservoirBtn.hidden = NO;
        }
        weakSelf.editSureView.hidden = YES;
        weakSelf.deleteBtn.hidden = YES;
        weakSelf.editBtn.hidden = YES;
        weakSelf.sureBtn.hidden = YES;
        
        weakSelf.allView.hidden = YES;
        weakSelf.cancelEditBtn.hidden = YES;
        weakSelf.saveBtn.hidden = YES;
        
        weakSelf.cancelBtn.hidden = NO;
        
        
    };
    
    
    
}



//删除解控单 URL_LIFTDELETE 1
- (void)deleteSureStorageBillNewData{
    jxt_showLoadingHUDTitleMessage(@"请求中...", nil);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
         NSString * aes = [user objectForKey:@"AES"];
         NSString *const kInitVector = @"16-Bytes--String";
         NetworkTool * network = [[NetworkTool alloc]init];
    NSString * type = [NSString string];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        type = @"BM_LiftControl";
    }else{
        type = @"SL_LiftControl";
    }
    NSMutableDictionary * paraDict = [NSMutableDictionary dictionary];
    [paraDict setValue:type forKey:@"billKey"];
    [paraDict setValue:[NSNumber numberWithInteger:self.touchmodel.billId] forKey:@"billId"];
    NSData * data = [NSJSONSerialization dataWithJSONObject:paraDict options:NSJSONWritingPrettyPrinted error:nil];
    RSWeakself
    NSString * jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString * aes2 = [FSAES128 encryptAES:jsonStr key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_LIFTDELETE, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_LIFTDELETE];
    network.successReload = ^(NSDictionary *dict) {
        jxt_dismissHUD();
        weakSelf.savebottomBtn.hidden = YES;
        weakSelf.nameBtn.hidden = YES;
        weakSelf.warehouseBtn.hidden = YES;
        weakSelf.reservoirBtn.hidden = YES;
        weakSelf.selectBtn.hidden = YES;
        weakSelf.editSureView.hidden = YES;
        weakSelf.deleteBtn.hidden = NO;
        weakSelf.editBtn.hidden = NO;
        weakSelf.sureBtn.hidden = NO;
        weakSelf.allView.hidden = YES;
        weakSelf.cancelEditBtn.hidden = YES;
        weakSelf.saveBtn.hidden = YES;
        weakSelf.cancelBtn.hidden = YES;
        
        if (weakSelf.reload) {
                           weakSelf.reload(true);
                       }
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    network.failure = ^(NSDictionary *dict) {
       // jxt_dismissHUD();
//         jxt_showToastMessage(dict[@"message"], 0.75);
        weakSelf.savebottomBtn.hidden = YES;
        weakSelf.nameBtn.enabled = NO;
        weakSelf.selectBtn.hidden = YES;
        
        if ([weakSelf.selectType isEqualToString:@"huangliao"]) {
            weakSelf.warehouseBtn.hidden = YES;
            weakSelf.reservoirBtn.hidden = YES;
            
            
            
        }else{
            
            weakSelf.warehouseBtn.enabled = NO;
              weakSelf.reservoirBtn.enabled = NO;
            weakSelf.warehouseBtn.hidden = NO;
            weakSelf.reservoirBtn.hidden = NO;
        }
        
        weakSelf.editSureView.hidden = NO;
        weakSelf.deleteBtn.hidden = NO;
        weakSelf.editBtn.hidden = NO;
        weakSelf.sureBtn.hidden = NO;
                     
        weakSelf.allView.hidden = YES;
        weakSelf.cancelEditBtn.hidden = YES;
        weakSelf.saveBtn.hidden = YES;
                     
        weakSelf.cancelBtn.hidden = YES;
        
    };
}



//加载解控单 URL_LIFTLOAD 1
- (void)reloadOldSaveNewData{
    jxt_showLoadingHUDTitleMessage(@"请求中...", nil);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
         NSString * aes = [user objectForKey:@"AES"];
         NSString *const kInitVector = @"16-Bytes--String";
         NetworkTool * network = [[NetworkTool alloc]init];
    NSString * type = [NSString string];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        type = @"BM_LiftControl";
    }else{
        type = @"SL_LiftControl";
    }
    RSWeakself
    NSMutableDictionary * paraDict = [NSMutableDictionary dictionary];
    [paraDict setValue:type forKey:@"billKey"];
    [paraDict setValue:[NSNumber numberWithInteger:self.touchmodel.billId] forKey:@"billId"];
   
    NSData * data = [NSJSONSerialization dataWithJSONObject:paraDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
     
    NSString * aes2 = [FSAES128 encryptAES:jsonStr key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_LIFTLOAD, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_LIFTLOAD];
      
    weakSelf.nameBtn.enabled = NO;
    weakSelf.selectBtn.hidden = YES;
    network.successReload = ^(NSDictionary *dict) {
        
        jxt_dismissHUD();
        weakSelf.touchmodel.msids = dict[@"msids"];
        weakSelf.touchmodel.deaName = dict[@"deaName"];
        weakSelf.touchmodel.billId = [dict[@"billId"] integerValue];
        
        
        if ([weakSelf.selectType isEqualToString:@"huangliao"]) {
            
            weakSelf.warehouseBtn.hidden = YES;
            weakSelf.reservoirBtn.hidden = YES;

           weakSelf.shippermodel.shipperId = [dict[@"deaId"]integerValue];
           weakSelf.shippermodel.name = dict[@"deaName"];
           weakSelf.nameLabel.text = dict[@"deaName"];
           weakSelf.totalLabel.text = [NSString stringWithFormat:@"%0.3lf",[dict[@"totalVolume"] doubleValue]];
            /**
             @property (nonatomic,strong)NSString * billDate;
             @property (nonatomic,strong)NSString * no;
             @property (nonatomic,assign)NSInteger status;
             @property (nonatomic,strong)NSDecimalNumber * totalVaQty;
             @property (nonatomic,strong)NSString * msids;
             @property (nonatomic,strong)NSString * deaName;
             @property (nonatomic,assign)NSInteger billId;
             */
            
            NSMutableArray * contentArray = [NSMutableArray array];
            NSMutableArray * tempArray = [NSMutableArray array];
            tempArray = dict[@"turns"];
            for (int i = 0; i < tempArray.count; i++) {
                NSMutableDictionary * dict = tempArray[i];
                RSBMStockModel * bmstockmodel = [[RSBMStockModel alloc]init];
                bmstockmodel.blockNo = dict[@"blockNo"];
                bmstockmodel.did = [dict[@"did"] integerValue];
                bmstockmodel.msid = dict[@"msid"];
                bmstockmodel.mtlName = dict[@"mtlName"];
                bmstockmodel.volume = dict[@"volume"];
                [contentArray addObject:bmstockmodel];
            }
            [weakSelf.showArray removeAllObjects];
            [weakSelf.showArray addObjectsFromArray:contentArray];
            [weakSelf.tableview reloadData];
        }else{
            weakSelf.warehouseBtn.enabled = YES;
            weakSelf.reservoirBtn.enabled = YES;
            
//            self.touchmodel.msids = dict[@"msids"];
//            self.touchmodel.deaName = dict[@"deaName"];
//            self.touchmodel.billId = [dict[@"billId"] integerValue];
            
            weakSelf.shippermodel.shipperId = [dict[@"deaId"]integerValue];
            
            weakSelf.shippermodel.name = dict[@"deaName"];
            weakSelf.nameLabel.text = dict[@"deaName"];
            weakSelf.totalLabel.text = [NSString stringWithFormat:@"%0.3lf",[dict[@"totalArea"] doubleValue]];
            
            weakSelf.warehousemodel.warehouseId = [dict[@"whsId"]integerValue];
            weakSelf.warehousemodel.name =dict[@"whsName"];
            weakSelf.warehouseLabel.text = dict[@"whsName"];
            
            weakSelf.storeAreamodel.storeAreaId = [dict[@"storeAreaId"]integerValue];
            weakSelf.storeAreamodel.whsId = [dict[@"whsId"]integerValue];
            weakSelf.storeAreamodel.name = dict[@"storeAreaName"];
            weakSelf.reservoirLabel.text = dict[@"storeAreaName"];
            
            
            NSMutableArray * contentArray = [NSMutableArray array];
                       
                       NSMutableArray * tempArray = [NSMutableArray array];
                       tempArray = dict[@"turns"];
                       for (int i = 0; i < tempArray.count; i++) {
                           NSMutableArray * pieceArray = [NSMutableArray array];
                           NSMutableDictionary * dict = tempArray[i];
                           pieceArray = dict[@"piece"];
                           for (int j = 0; j < pieceArray.count; j++) {
                               NSMutableDictionary * dict = pieceArray[j];
                               RSSLPieceModel * slpiecemodel = [[RSSLPieceModel alloc]init];
                               slpiecemodel.area = dict[@"area"];
                                slpiecemodel.blockNo = dict[@"blockNo"];
                               slpiecemodel.did = [dict[@"did"] integerValue];
                               slpiecemodel.msid = dict[@"msid"];
                                slpiecemodel.mtlName = dict[@"mtlName"];
                               slpiecemodel.turnsNo = dict[@"turnsNo"];
                               slpiecemodel.slNo = [dict[@"slNo"] integerValue];
                               slpiecemodel.isbool = false;
                               slpiecemodel.isSelect = true;
                               [contentArray addObject:slpiecemodel];
                           }
                       }
                       
                       NSMutableArray * changeArray = [self changeNewArrayRule:contentArray];
                       [weakSelf.showArray removeAllObjects];
                       [weakSelf.showArray addObjectsFromArray:changeArray];
            
            [weakSelf.tableview reloadData];
        }
        
    };
    network.failure = ^(NSDictionary *dict) {
        
         //jxt_dismissHUD();
//        jxt_showToastMessage(dict[@"message"], 0.75);
        
        weakSelf.nameBtn.enabled = NO;
        weakSelf.selectBtn.hidden = YES;
        if ([weakSelf.selectType isEqualToString:@"huangliao"]) {
            weakSelf.warehouseBtn.hidden = YES;
            weakSelf.reservoirBtn.hidden = YES;
        }else{
            weakSelf.warehouseBtn.enabled = YES;
            weakSelf.reservoirBtn.enabled = YES;
            
        }
    };
}




//货主名
- (void)selectNameAction:(UIButton *)nameBtn{
    RSNameOfCargoViewController * nameOfCargoVc = [[RSNameOfCargoViewController alloc]init];
    nameOfCargoVc.title = @"货主名称";
    nameOfCargoVc.type = @"dealer";
    if (self.showArray.count > 0) {
        [JHSysAlertUtil presentAlertViewWithTitle:@"是否要去选择新的货主" message:@"选择新的货主成功之后会清除之前选择的物料" cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        } confirm:^{
            [self.navigationController pushViewController:nameOfCargoVc animated:YES];
                nameOfCargoVc.block = ^(RSShipperMode * _Nonnull shippermodel, NSString * _Nonnull type) {
                self.shippermodel = shippermodel;
                self.nameLabel.text = shippermodel.name;
                [self.showArray removeAllObjects];
                [self.tableview reloadData];
            };
        }];
    }else{

        [self.navigationController pushViewController:nameOfCargoVc animated:YES];
        nameOfCargoVc.block = ^(RSShipperMode * _Nonnull shippermodel, NSString * _Nonnull type) {
            self.shippermodel = shippermodel;
            self.nameLabel.text = shippermodel.name;
        };
    }
}



//仓库
- (void)wareHouseAction:(UIButton *)warehouseBtn{
    RSNameOfCargoViewController * nameOfCargoVc = [[RSNameOfCargoViewController alloc]init];
    nameOfCargoVc.title = @"仓库";
    nameOfCargoVc.type = @"warehouse";
    if (self.showArray.count > 0) {
           [JHSysAlertUtil presentAlertViewWithTitle:@"是否要去选择仓库" message:@"选择新的仓库成功之后会清除之前选择的物料" cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
           } confirm:^{
              [self.navigationController pushViewController:nameOfCargoVc animated:YES];
                  nameOfCargoVc.warehouseblock = ^(RSWarehouseModel * _Nonnull warehousemodel, NSString * _Nonnull type) {
                      self.warehousemodel = warehousemodel;
                      self.warehouseLabel.text = warehousemodel.name;
                      [self.showArray removeAllObjects];
                      self.reservoirLabel.text = @"所选库区";
                      self.storeAreamodel = nil;
                      [self.tableview reloadData];
                      
                      
                  };
           }];
       }else{
            [self.navigationController pushViewController:nameOfCargoVc animated:YES];
              nameOfCargoVc.warehouseblock = ^(RSWarehouseModel * _Nonnull warehousemodel, NSString * _Nonnull type) {
                  self.warehousemodel = warehousemodel;
                  self.warehouseLabel.text = warehousemodel.name;
                  self.reservoirLabel.text = @"所选库区";
                  self.storeAreamodel = nil;
              };
       }
}
//库区
- (void)reservoirAction:(UIButton *)reservoirAction{
    if (self.warehousemodel.warehouseId == (long)nil) {
        jxt_showToastTitle(@"请先选择仓库", 0.75);
    }else{
        RSNameOfCargoViewController * nameOfCargoVc = [[RSNameOfCargoViewController alloc]init];
               nameOfCargoVc.title = @"库区";
               nameOfCargoVc.type = @"storeArea";
               nameOfCargoVc.warehousemodel = self.warehousemodel;
        
        if (self.showArray.count > 0) {
            [JHSysAlertUtil presentAlertViewWithTitle:@"是否要去选择仓库" message:@"选择新的仓库成功之后会清除之前选择的物料" cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            } confirm:^{
                 [self.navigationController pushViewController:nameOfCargoVc animated:YES];
                     nameOfCargoVc.storeAreablock = ^(RSStoreAreaModel * _Nonnull storeAreamodel, NSString * _Nonnull type) {
                         self.storeAreamodel = storeAreamodel;
                         self.reservoirLabel.text = storeAreamodel.name;
                         [self.showArray removeAllObjects];
                         [self.tableview reloadData];
                     };
            }];
        }else{
              [self.navigationController pushViewController:nameOfCargoVc animated:YES];
                   nameOfCargoVc.storeAreablock = ^(RSStoreAreaModel * _Nonnull storeAreamodel, NSString * _Nonnull type) {
                       self.storeAreamodel = storeAreamodel;
                       self.reservoirLabel.text = storeAreamodel.name;
             };
        }
    }
}

//选择库存
- (void)selecctAction:(UIButton *)selectBtn{
    //这里要判断下有没有选择货主名称
    if ([self.selectType isEqualToString:@"huangliao"]) {
         if (self.shippermodel.shipperId !=(long)nil) {
             RSStockViewController * stockVc = [[RSStockViewController alloc]init];
             stockVc.selectType = self.selectType;
             stockVc.delegate = self;
             stockVc.title = @"荒料库存";
             if ([self.btnType isEqualToString:@"edit"]) {
                 if (self.showArray.count > 0) {
                                //这边是已经选择过了
                                NSMutableArray * array = [NSMutableArray array];
                                for (int i = 0; i < self.showArray.count; i++) {
                                 RSBMStockModel * bmstockmodel = self.showArray[i];
                                 [array addObject:bmstockmodel];
                                }
                                // selectiveInvenroryVc.selectionArray = self.dataArray;
                                stockVc.selectionArray = array;
                             }
             }
             stockVc.shippermodel = self.shippermodel;
            [self.navigationController pushViewController:stockVc animated:YES];
             
         }else{
             jxt_showToastTitle(@"请先选择货主", 0.75);
         }
    }else{
        //&& ![self.warehouseLabel.text isEqualToString:@"所属仓库"] && ![self.reservoirLabel.text isEqualToString:@"所属库区"]
        if (self.shippermodel.shipperId != (long)nil && self.warehousemodel.warehouseId != (long)nil && self.storeAreamodel.storeAreaId != (long)nil) {
            RSStockViewController * stockVc = [[RSStockViewController alloc]init];
            stockVc.selectType = self.selectType;
            stockVc.delegate = self;
            stockVc.title = @"大板库存";
            if ([self.btnType isEqualToString:@"edit"]) {
                if (self.showArray.count > 0) {
                    //这边是已经选择过了
                   NSMutableArray * array = [NSMutableArray array];
                   for (int i = 0; i < self.showArray.count; i++) {
                      NSMutableArray * contentArray = self.showArray[i];
                       for (int j = 0; j < contentArray.count; j++) {
                        RSSLPieceModel * slpiecemodel = contentArray[j];
                        [array addObject:slpiecemodel];
                       }
                    }
                    stockVc.selectdeContentArray = array;
                }
            }
            stockVc.shippermodel = self.shippermodel;
            stockVc.warehousemodel = self.warehousemodel;
            stockVc.storeAreamodel = self.storeAreamodel;
            [self.navigationController pushViewController:stockVc animated:YES];
        }else{
              jxt_showToastTitle(@"请先选择货主,仓库,库区", 0.75);
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return 1;
    if ([self.selectType isEqualToString:@"huangliao"]) {
        return 1;
    }else{
        return self.showArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.selectType isEqualToString:@"huangliao"]) {
        return self.showArray.count;
    }else{
        
        NSMutableArray * array = self.showArray[section];
        RSSLPieceModel * slpiecemodel = array[0];
        if (slpiecemodel.isbool) {
            return array.count;
        }else{
             return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectType isEqualToString:@"huangliao"]) {
         return 126;
       }else{
           return 70.5;
       }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.selectType isEqualToString:@"huangliao"]) {
         return 0.001;
       }else{
           return 108;
       }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([self.selectType isEqualToString:@"huangliao"]) {
        
      return 0.001;
    }else{
        
        NSMutableArray * array = self.showArray[section];
        RSSLPieceModel * slpiecemodel = array[0];
        if (slpiecemodel.isbool) {
            return 10;
        }else{
            return 0.001;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self.selectType isEqualToString:@"daban"]) {
        RSSLHeaderView * slHeaderview = [[RSSLHeaderView alloc]initWithReuseIdentifier:SLHEADERVIEWID];
        slHeaderview.downBtn.tag = section;
        slHeaderview.productDeleteBtn.tag = section;
        NSMutableArray * array = self.showArray[section];
        RSSLPieceModel * slpiecemodel = array[0];
        slHeaderview.slpiecemodel = slpiecemodel;
        [slHeaderview.downBtn addTarget:self action:@selector(dabanDownAction:) forControlEvents:UIControlEventTouchUpInside];
        [slHeaderview.productDeleteBtn addTarget:self action:@selector(dabanDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        return slHeaderview;
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self.selectType isEqualToString:@"daban"]) {
        NSMutableArray * array = self.showArray[section];
        RSSLPieceModel * slpiecemodel = array[0];
        if (slpiecemodel.isbool) {
            RSSLFootView * slFootview = [[RSSLFootView alloc]initWithReuseIdentifier:SLFOOTVIEWID];
            return slFootview;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectType isEqualToString:@"huangliao"]) {
        static NSString * BLCELLID = @"BLCELLID";
        RSBLTouchCell * cell = [tableView dequeueReusableCellWithIdentifier:BLCELLID];
        if (!cell) {
            cell = [[RSBLTouchCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:BLCELLID];
        }
        if ([self.btnType isEqualToString:@"edit"] || [self.btnType isEqualToString:@"new"]) {
            cell.productDeleteBtn.hidden = NO;
        }else{
             cell.productDeleteBtn.hidden = YES;
        }
        cell.productDeleteBtn.tag = indexPath.row;
        [cell.productDeleteBtn addTarget:self action:@selector(huangliaoDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.bmstockmodel = self.showArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString * SLCELLID = @"SLCELLID";
//        NSString * SLCELLID = [NSString stringWithFormat:@"SLCELLID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        RSSLTouchCell * cell = [tableView dequeueReusableCellWithIdentifier:SLCELLID];
        if (!cell) {
            cell = [[RSSLTouchCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SLCELLID];
        }
        if ([self.btnType isEqualToString:@"edit"] || [self.btnType isEqualToString:@"new"]) {
            cell.mainScrollView.userInteractionEnabled = YES;
        }else{
            cell.mainScrollView.userInteractionEnabled = NO;
        }
        
        NSMutableArray * array = self.showArray[indexPath.section];
        RSSLPieceModel * slpiecemodel = array[indexPath.row];
        cell.filmNumberLabel.text = [NSString stringWithFormat:@"片号%ld",(long)indexPath.row + 1];
        cell.longDetailLabel.text = [NSString stringWithFormat:@"%@",slpiecemodel.area];
        cell.indexPath = indexPath;
        RSWeakself
        cell.deleteAction = ^(NSIndexPath * indexPath) {

            [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除该大板内容" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
                     //取消
                 } confirm:^{
                 //确定
                     NSMutableArray * array = weakSelf.showArray[indexPath.section];
                     [array removeObjectAtIndex:indexPath.row];
                     if (array.count < 1) {
                        [weakSelf.showArray removeObjectAtIndex:indexPath.section];
                      }
                      RSSLTouchCell * cell1 = [weakSelf.tableview cellForRowAtIndexPath:indexPath];
                      [cell1.mainScrollView setContentOffset:CGPointMake(0, 0)];
                      self.totalLabel.text = [self totalCountArea];
                      [weakSelf.tableview reloadData];
                 }];
        };
        cell.scrollAction = ^{
            for (RSSLTouchCell * tableViewCell in weakSelf.tableview.visibleCells) {
                /// 当屏幕滑动时，关闭不是当前滑动的cell
                if (tableViewCell.isOpen == YES && tableViewCell != cell) {
                    [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                }
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.selectType isEqualToString:@"daban"]) {
        for (RSSLTouchCell * tableViewCell in self.tableview.visibleCells) {
               /// 当屏幕滑动时，关闭被打开的cell
               if (tableViewCell.isOpen == YES) {
                   [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
               }
           }
    }
}

//荒料cell删除的方法
- (void)huangliaoDeleteAction:(UIButton *)deleteBtn{
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除该荒料内容" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
        //取消
        
    } confirm:^{
    //确定
        [self.showArray removeObjectAtIndex:deleteBtn.tag];
        self.totalLabel.text = [self totalCountVomlue];
        [self.tableview reloadData];
    }];
    
}
//大板头部的
//大板展开和关闭
- (void)dabanDownAction:(UIButton *)downBtn{
    NSMutableArray * array = self.showArray[downBtn.tag];
    downBtn.selected = !downBtn.selected;
    for (int i = 0 ; i < array.count; i++) {
        RSSLPieceModel * slpiecemodel = array[i];
        slpiecemodel.isbool = !slpiecemodel.isbool;
    }
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:downBtn.tag];
    [self.tableview reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
}

//大板删除----大板头部视图
- (void)dabanDeleteAction:(UIButton *)deleteBtn{
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除该大板内容" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
          //取消
      } confirm:^{
      //确定
          [self.showArray removeObjectAtIndex:deleteBtn.tag];
          self.totalLabel.text = [self totalCountArea];
          [self.tableview reloadData];
      }];
}

//荒料--------代理的方法
- (void)huangliaoSelectContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray{

   
    
    if (self.showArray.count < 1) {
        [self.showArray addObjectsFromArray:selectArray];
    }else{
        //这边要判断下
//        [self.showArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            RSBMStockModel * bmstockmodel = obj;
//
//            [cancelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger dx, BOOL * _Nonnull stop) {
//                NSInteger did = [obj integerValue];

//                if ([@(bmstockmodel.did) isEqual:@(did)]) {
//                    [self.showArray removeObjectAtIndex:idx];
//

//
//                    for (int i = 0; i < self.showArray.count; i++) {
//
//                        RSBMStockModel * bmstockmodel = self.showArray[i];
//

//                    }
//                }
//            }];
//        }];
        
        
        for (int i = 0; i < self.showArray.count; i++) {
            RSBMStockModel * bmstockmodel = self.showArray[i];
            for (int j = 0; j < cancelArray.count; j++) {
                NSInteger did = [cancelArray[j] integerValue];
                if ([@(bmstockmodel.did) isEqualToNumber:@(did)]) {
                    [self.showArray removeObjectAtIndex:i];
                    i--;
                }
            }
        }
        
        NSMutableArray * array = [NSMutableArray array];
               //找到arr1中有,arr2中没有的数据
         [selectArray enumerateObjectsUsingBlock:^(RSBMStockModel * bmstockmodel, NSUInteger idx, BOOL * _Nonnull stop) {
            __block BOOL isHave = NO;
           [self.showArray enumerateObjectsUsingBlock:^(RSBMStockModel * bmstockmodel1, NSUInteger dx, BOOL * _Nonnull stop) {
                if ([@(bmstockmodel.did) isEqual:@(bmstockmodel1.did)]) {
                    isHave = YES;
                    *stop = YES;
                }
            }];
            if (!isHave) {
                [array addObject:bmstockmodel];
            }
        }];
      [self.showArray addObjectsFromArray:array];
    }
    self.totalLabel.text = [self totalCountVomlue];
    [self.tableview reloadData];
}
//大板代理
- (void)dabanChoosingContentArray:(NSMutableArray *)selectArray andCancelArray:(NSMutableArray *)cancelArray{
    NSMutableArray * tempArray = [NSMutableArray array];
    for (int i = 0; i < self.showArray.count; i++){
        NSMutableArray * array = self.showArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLPieceModel * slpiecemodel = array[j];
            [tempArray addObject:slpiecemodel];
        }
    }
    for (int i = 0; i < tempArray.count; i++) {
        RSSLPieceModel * slpiecemodel = tempArray[i];
        for (int j = 0; j < cancelArray.count; j++) {
            NSInteger did = [cancelArray[j] integerValue];
            if (slpiecemodel.did == did) {
                [cancelArray removeObject:@(did)];
                [tempArray removeObject:slpiecemodel];
                i -= 1;
            }
        }
    }
    NSMutableArray * array = [NSMutableArray array];
    //找到arr1中有,arr2中没有的数据
    [selectArray enumerateObjectsUsingBlock:^(RSSLPieceModel * slpiecemodel, NSUInteger idx, BOOL * _Nonnull stop) {
        __block BOOL isHave = NO;
            [tempArray enumerateObjectsUsingBlock:^(RSSLPieceModel * slpiecemodel1, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([@(slpiecemodel.did) isEqual:@(slpiecemodel1.did)]) {
                    isHave = YES;
                    *stop = YES;
                }
            }];
            if (!isHave) {
                [array addObject:slpiecemodel];
            }
    }];
    //NSMutableArray * changeArray = [self changeArrayRule:array];
    for (int i = 0; i < array.count; i++) {
        RSSLPieceModel * slpiecemodel = array[i];
        [tempArray addObject:slpiecemodel];
    }
    NSMutableArray * changeArray = [self changeNewArrayRule:tempArray];
    [self.showArray removeAllObjects];
    [self.showArray addObjectsFromArray:changeArray];
    self.totalLabel.text = [self totalCountArea];
    [self.tableview reloadData];
}
//大板的总面积
- (NSString *)totalCountArea{
    CGFloat total = 0.0;
    for (int i = 0; i < self.showArray.count; i++) {
        NSMutableArray * array = self.showArray[i];
        for (int j = 0; j < array.count; j++) {
            RSSLPieceModel * slpiecemodel = array[j];
            total += [slpiecemodel.area doubleValue];
        }
    }
    return [NSString stringWithFormat:@"%0.3lf",total];
}
//荒料的体积
- (NSString *)totalCountVomlue{
    CGFloat total = 0.0;
        for (int i = 0; i < self.showArray.count; i++) {
            RSBMStockModel * bmstockmodel = self.showArray[i];
            total += [bmstockmodel.volume doubleValue];
        }
   return [NSString stringWithFormat:@"%0.3lf",total];
}




@end
