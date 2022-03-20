//
//  RSUserModel.h
//  OAManage
//
//  Created by mac on 2018/11/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//NSCoding
@interface RSUserModel : NSObject<NSCopying>

/**
aesKey AES2的值
userId  用户ID
userName 用户名称
userCode 用户代码
appLoginToken 登录标识(相当于之前的LoginKey)
deptName 部门名称
sex 性别
 部门ID    deptId
 

 
 
 
 
 
 "Flow_Purchase"                      行政采购审批            行政流程
 "Flow_Restaurant"                    自助餐厅报餐           行政流程
 "UseCar"                                   用车申请                  行政流程
 "Flow_Receptions"                   招待用品申购单        行政流程
 "Flow_SupplierConsume"        用品领用                   行政流程
 "Flow_VehicleReservation"      车辆预约登记            行政流程
 "Flow_ApplyActivity"                员工活动申请            行政流程
 "Entertain"                      招待住宿申请            行政流程
 "Flow_Entertain"                    招待申请                   行政流程
 

 "Flow_ApplyLeave"                 请假申请                   人事流程
 "Flow_BreakDown"                 调休申请单                人事流程
 "Flow_HumanNeed"               人力需求申请            人事流程
 "Flow_Quit"                             离职申请                   人事流程
 "Flow_PostMove"                    岗位异动                   人事流程
 "Flow_Become"                       转正申请                   人事流程
 "Flow_Business"                      出差审批流程           人事流程
 "Flow_WorkOvertime"              加班申请流程           人事流程
 
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
 "Flow_SpecialApplication"特殊申请审批流程         其他流程
 
 
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
 
 
 OA_Market_Home     市场模块首页
OA_BM_IO            荒料出入库情况
OA_SL_IO            大板出入库情况
OA_Lease            招商业务租赁情况
OA_Ledger           招商总账单
OA_Ledger_Dtl      招商商户账单明细
OA_Market_Fee      园区费用应收余额表
OA_Market_Dealer_Fee      园区商户费用应收
OA_Market_Pay_In   园区收款明细表
OA_Market_Settle_In  园区应收明细表
 

*/
@property (nonatomic,assign)NSInteger userId;

@property (nonatomic,strong)NSString * userName;

@property (nonatomic,strong)NSString * userCode;

@property (nonatomic,strong)NSString * appLoginToken;
//申请部门
@property (nonatomic,strong)NSString * deptName;

@property (nonatomic,strong)NSString * sex;

@property (nonatomic,strong)NSString * aesKey;
//申请部门ID
@property (nonatomic,assign)NSInteger deptId;
//申请人
@property (nonatomic,strong)NSString * empName;
//申请人ID
@property (nonatomic,assign)NSInteger empId;



@property (nonatomic,assign)BOOL  Flow_Purchase;
@property (nonatomic,assign)BOOL  Flow_Restaurant;
@property (nonatomic,assign)BOOL  UseCar;
@property (nonatomic,assign)BOOL  Flow_Receptions;
@property (nonatomic,assign)BOOL  Flow_SupplierConsume;
@property (nonatomic,assign)BOOL  Flow_VehicleReservation;
@property (nonatomic,assign)BOOL  Flow_ApplyActivity;
@property (nonatomic,assign)BOOL  Entertain;
@property (nonatomic,assign)BOOL  Flow_Entertain;


@property (nonatomic,assign)BOOL  Flow_ApplyLeave;
@property (nonatomic,assign)BOOL  Flow_BreakDown;
@property (nonatomic,assign)BOOL  Flow_HumanNeed;
@property (nonatomic,assign)BOOL  Flow_Quit;
@property (nonatomic,assign)BOOL  Flow_PostMove;
@property (nonatomic,assign)BOOL  Flow_Become;
@property (nonatomic,assign)BOOL  Flow_Business;
@property (nonatomic,assign)BOOL  Flow_WorkOvertime;


@property (nonatomic,assign)BOOL  Flow_InvestContract;
@property (nonatomic,assign)BOOL  Flow_Contract;
@property (nonatomic,assign)BOOL  Flow_Cachet;
@property (nonatomic,assign)BOOL  Flow_InCachet;
@property (nonatomic,assign)BOOL  Flow_FileUpdate;
@property (nonatomic,assign)BOOL  Flow_Chapter;
@property (nonatomic,assign)BOOL  Flow_SaleContract;


@property (nonatomic,assign)BOOL  Flow_RsPayment;
@property (nonatomic,assign)BOOL  Flow_RsApplyLeave;
@property (nonatomic,assign)BOOL  Flow_RsBreakDown;



@property (nonatomic,assign)BOOL  Flow_Equipment;
@property (nonatomic,assign)BOOL  Flow_EquipService;


@property (nonatomic,assign)BOOL  Flow_Payment;
@property (nonatomic,assign)BOOL  Flow_FixedAssets;
@property (nonatomic,assign)BOOL  Flow_Advertising;
@property (nonatomic,assign)BOOL  Flow_UsedIdle;
@property (nonatomic,assign)BOOL  Flow_WasteDisposal;
@property (nonatomic,assign)BOOL  AM_Requisition;
@property (nonatomic,assign)BOOL  AM_SetlleIn;
@property (nonatomic,assign)BOOL  Flow_SpecialApplication;


@property (nonatomic,assign)BOOL  BM_OutNotice;
@property (nonatomic,assign)BOOL  BS_OutNotice;
@property (nonatomic,assign)BOOL  SL_OutNotice;
@property (nonatomic,assign)BOOL  SM_Transfer;
@property (nonatomic,assign)BOOL  ES_Transfer;
@property (nonatomic,assign)BOOL  SL_Transfer;
@property (nonatomic,assign)BOOL  BM_Transfer;
@property (nonatomic,assign)BOOL  BL_OutNotice;
@property (nonatomic,assign)BOOL  SM_SendNotice;
@property (nonatomic,assign)BOOL  ES_OutNotice;

@property (nonatomic,assign)BOOL  SC_PayIn;


@property (nonatomic,assign)BOOL  BM_MtlReturn;
@property (nonatomic,assign)BOOL  FG_EngQuotation;
@property (nonatomic,assign)BOOL  FG_ProcessProduct;
@property (nonatomic,assign)BOOL  FG_ProcessProtocol;
@property (nonatomic,assign)BOOL  FG_ProfitQuote;



@property (nonatomic,assign)BOOL  OA_Market_Home;
@property (nonatomic,assign)BOOL  OA_BM_IO;
@property (nonatomic,assign)BOOL  OA_SL_IO;
@property (nonatomic,assign)BOOL  OA_Lease;
@property (nonatomic,assign)BOOL  OA_Ledger;


@property (nonatomic,assign)BOOL  OA_Ledger_Dtl;
@property (nonatomic,assign)BOOL  OA_Market_Fee;

@property (nonatomic,assign)BOOL  OA_Market_Dealer_Fee;
@property (nonatomic,assign)BOOL  OA_Market_Pay_In;
@property (nonatomic,assign)BOOL  OA_Market_Settle_In;

@end

NS_ASSUME_NONNULL_END
