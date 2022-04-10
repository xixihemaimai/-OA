//
//  RSUserModel.m
//  OAManage
//
//  Created by mac on 2018/11/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSUserModel.h"

@implementation RSUserModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    /**
     userId  用户ID
     userName 用户名称
     userCode 用户代码
     appLoginToken 登录标识(相当于之前的LoginKey)
     deptName 部门名称
     sex 性别
     @property (nonatomic,assign)BOOL  Flow_Purchase;
     @property (nonatomic,assign)BOOL  Flow_Restaurant;
     @property (nonatomic,assign)BOOL  UseCar;
     @property (nonatomic,assign)BOOL  Flow_Receptions;
     @property (nonatomic,assign)BOOL  Flow_SupplierConsume;
     @property (nonatomic,assign)BOOL  Flow_VehicleReservation;
     @property (nonatomic,assign)BOOL  Flow_ApplyActivity;
     @property (nonatomic,assign)BOOL  Flow_Entertain;
     @property (nonatomic,assign)BOOL  Flow_Entertain2;
     
     
     @property (nonatomic,assign)BOOL  Flow_ApplyLeave;
     @property (nonatomic,assign)BOOL  Flow_BreakDown;
     @property (nonatomic,assign)BOOL  Flow_HumanNeed;
     @property (nonatomic,assign)BOOL  Flow_Quit;
     @property (nonatomic,assign)BOOL  Flow_PostMove;
     @property (nonatomic,assign)BOOL  Flow_Become;
     @property (nonatomic,assign)BOOL  Flow_Business;
     
     
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
    //[aCoder encodeObject:self.userId forKey:@"userID"];
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userCode forKey:@"userCode"];
    [aCoder encodeObject:self.appLoginToken forKey:@"appLoginToken"];
    [aCoder encodeObject:self.deptName forKey:@"deptName"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.aesKey forKey:@"aesKey"];
    [aCoder encodeInteger:self.deptId forKey:@"deptId"];
    
    [aCoder encodeInteger:self.empId forKey:@"empId"];
     [aCoder encodeObject:self.empName forKey:@"empName"];
    
    
    
    [aCoder encodeBool:self.Flow_Purchase forKey:@"Flow_Purchase"];
    [aCoder encodeBool:self.Flow_Restaurant forKey:@"Flow_Restaurant"];
    [aCoder encodeBool:self.UseCar forKey:@"UseCar"];
    [aCoder encodeBool:self.Flow_Receptions forKey:@"Flow_Receptions"];
    [aCoder encodeBool:self.Flow_SupplierConsume forKey:@"Flow_SupplierConsume"];
    [aCoder encodeBool:self.Flow_VehicleReservation forKey:@"Flow_VehicleReservation"];
    [aCoder encodeBool:self.Flow_ApplyActivity forKey:@"Flow_ApplyActivity"];
    [aCoder encodeBool:self.Entertain forKey:@"Entertain"];
    [aCoder encodeBool:self.Flow_Entertain forKey:@"Flow_Entertain"];
    
    
    [aCoder encodeBool:self.Flow_ApplyLeave forKey:@"Flow_ApplyLeave"];
    [aCoder encodeBool:self.Flow_BreakDown forKey:@"Flow_BreakDown"];
    [aCoder encodeBool:self.Flow_HumanNeed forKey:@"Flow_HumanNeed"];
    [aCoder encodeBool:self.Flow_Quit forKey:@"Flow_Quit"];
    [aCoder encodeBool:self.Flow_PostMove forKey:@"Flow_PostMove"];
    [aCoder encodeBool:self.Flow_Become forKey:@"Flow_Become"];
    [aCoder encodeBool:self.Flow_Business forKey:@"Flow_Business"];
    [aCoder encodeBool:self.Flow_WorkOvertime forKey:@"Flow_WorkOvertime"];
    
    
    [aCoder encodeBool:self.Flow_InvestContract forKey:@"Flow_InvestContract"];
    [aCoder encodeBool:self.Flow_Contract forKey:@"Flow_Contract"];
    [aCoder encodeBool:self.Flow_Cachet forKey:@"Flow_Cachet"];
    [aCoder encodeBool:self.Flow_InCachet forKey:@"Flow_InCachet"];
    [aCoder encodeBool:self.Flow_FileUpdate forKey:@"Flow_FileUpdate"];
    [aCoder encodeBool:self.Flow_Chapter forKey:@"Flow_Chapter"];
    [aCoder encodeBool:self.Flow_SaleContract forKey:@"Flow_SaleContract"];
    
    
    [aCoder encodeBool:self.Flow_RsPayment forKey:@"Flow_RsPayment"];
    [aCoder encodeBool:self.Flow_RsApplyLeave forKey:@"Flow_RsApplyLeave"];
    [aCoder encodeBool:self.Flow_RsBreakDown forKey:@"Flow_RsBreakDown"];
    
    [aCoder encodeBool:self.Flow_Equipment forKey:@"Flow_Equipment"];
    [aCoder encodeBool:self.Flow_EquipService forKey:@"Flow_EquipService"];
    
    
    [aCoder encodeBool:self.Flow_Payment forKey:@"Flow_Payment"];
    [aCoder encodeBool:self.Flow_FixedAssets forKey:@"Flow_FixedAssets"];
    [aCoder encodeBool:self.Flow_Advertising forKey:@"Flow_Advertising"];
    [aCoder encodeBool:self.Flow_UsedIdle forKey:@"Flow_UsedIdle"];
    [aCoder encodeBool:self.Flow_WasteDisposal forKey:@"Flow_WasteDisposal"];
    [aCoder encodeBool:self.AM_Requisition forKey:@"AM_Requisition"];
    [aCoder encodeBool:self.AM_SetlleIn forKey:@"AM_SetlleIn"];
    [aCoder encodeBool:self.Flow_SpecialApplication forKey:@"Flow_SpecialApplication"];
    
    [aCoder encodeBool:self.BM_OutNotice forKey:@"BM_OutNotice"];
    [aCoder encodeBool:self.BS_OutNotice forKey:@"BS_OutNotice"];
    [aCoder encodeBool:self.SL_OutNotice forKey:@"SL_OutNotice"];
    [aCoder encodeBool:self.SM_Transfer forKey:@"SM_Transfer"];
    [aCoder encodeBool:self.ES_Transfer forKey:@"ES_Transfer"];
    [aCoder encodeBool:self.SL_Transfer forKey:@"SL_Transfer"];
    [aCoder encodeBool:self.BM_Transfer forKey:@"BM_Transfer"];
    
    [aCoder encodeBool:self.BL_OutNotice forKey:@"BL_OutNotice"];
    [aCoder encodeBool:self.SM_SendNotice forKey:@"SM_SendNotice"];
    [aCoder encodeBool:self.ES_OutNotice forKey:@"ES_OutNotice"];
    
    [aCoder encodeBool:self.SC_PayIn forKey:@"SC_PayIn"];
    
    
    [aCoder encodeBool:self.BM_MtlReturn forKey:@"BM_MtlReturn"];
    [aCoder encodeBool:self.FG_EngQuotation forKey:@"FG_EngQuotation"];
    [aCoder encodeBool:self.FG_ProcessProduct forKey:@"FG_ProcessProduct"];
    [aCoder encodeBool:self.FG_ProcessProtocol forKey:@"FG_ProcessProtocol"];
    [aCoder encodeBool:self.FG_ProfitQuote forKey:@"FG_ProfitQuote"];
    
    
    
    
    [aCoder encodeBool:self.OA_Market_Home forKey:@"OA_Market_Home"];
    [aCoder encodeBool:self.OA_BM_IO forKey:@"OA_BM_IO"];
    [aCoder encodeBool:self.OA_SL_IO forKey:@"OA_SL_IO"];
    [aCoder encodeBool:self.OA_Lease forKey:@"OA_Lease"];
    [aCoder encodeBool:self.OA_Ledger forKey:@"OA_Ledger"];
    
    [aCoder encodeBool:self.OA_Ledger_Dtl forKey:@"OA_Ledger_Dtl"];
    [aCoder encodeBool:self.OA_Market_Fee  forKey:@"OA_Market_Fee"];
    [aCoder encodeBool:self.OA_Market_Dealer_Fee forKey:@"OA_Market_Dealer_Fee"];
    
    [aCoder encodeBool:self.OA_Market_Pay_In  forKey:@"OA_Market_Pay_In"];
    [aCoder encodeBool:self.OA_Market_Settle_In forKey:@"OA_Market_Settle_In"];
    
    [aCoder encodeBool:self.Flow_TrainingCosts forKey:@"Flow_TrainingCosts"];
    [aCoder encodeBool:self.Flow_PropertyServices forKey:@"Flow_PropertyServices"];
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.userId = [aDecoder decodeIntegerForKey:@"userId"];
        self.userCode = [aDecoder decodeObjectForKey:@"userCode"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.appLoginToken = [aDecoder decodeObjectForKey:@"appLoginToken"];
        self.deptName = [aDecoder decodeObjectForKey:@"deptName"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.aesKey = [aDecoder decodeObjectForKey:@"aesKey"];
        
        self.deptId = [aDecoder decodeIntegerForKey:@"deptId"];
        self.empId = [aDecoder decodeIntegerForKey:@"empId"];
        self.empName = [aDecoder decodeObjectForKey:@"empName"];
        
        
        
        self.Flow_Purchase = [aDecoder decodeBoolForKey:@"Flow_Purchase"];
        self.Flow_Restaurant = [aDecoder decodeBoolForKey:@"Flow_Restaurant"];
        self.UseCar = [aDecoder decodeBoolForKey:@"UseCar"];
        self.Flow_Receptions = [aDecoder decodeBoolForKey:@"Flow_Receptions"];
        self.Flow_SupplierConsume = [aDecoder decodeBoolForKey:@"Flow_SupplierConsume"];
        self.Flow_VehicleReservation = [aDecoder decodeBoolForKey:@"Flow_VehicleReservation"];
        self.Flow_ApplyActivity = [aDecoder decodeBoolForKey:@"Flow_ApplyActivity"];
        self.Entertain = [aDecoder decodeBoolForKey:@"Entertain"];
        self.Flow_Entertain = [aDecoder decodeBoolForKey:@"Flow_Entertain"];
        
        
        
        self.Flow_ApplyLeave = [aDecoder decodeBoolForKey:@"Flow_ApplyLeave"];
        self.Flow_BreakDown = [aDecoder decodeBoolForKey:@"Flow_BreakDown"];
        self.Flow_HumanNeed = [aDecoder decodeBoolForKey:@"Flow_HumanNeed"];
        self.Flow_Quit = [aDecoder decodeBoolForKey:@"Flow_Quit"];
        self.Flow_PostMove = [aDecoder decodeBoolForKey:@"Flow_PostMove"];
        self.Flow_Become = [aDecoder decodeBoolForKey:@"Flow_Become"];
        self.Flow_Business = [aDecoder decodeBoolForKey:@"Flow_Business"];
        self.Flow_WorkOvertime = [aDecoder decodeBoolForKey:@"Flow_WorkOvertime"];
        
        self.Flow_InvestContract = [aDecoder decodeBoolForKey:@"Flow_InvestContract"];
        self.Flow_Contract = [aDecoder decodeBoolForKey:@"Flow_Contract"];
        self.Flow_Cachet = [aDecoder decodeBoolForKey:@"Flow_Cachet"];
        self.Flow_InCachet = [aDecoder decodeBoolForKey:@"Flow_InCachet"];
        self.Flow_FileUpdate = [aDecoder decodeBoolForKey:@"Flow_FileUpdate"];
        self.Flow_Chapter = [aDecoder decodeBoolForKey:@"Flow_Chapter"];
        self.Flow_SaleContract = [aDecoder decodeBoolForKey:@"Flow_SaleContract"];
        
        self.Flow_RsPayment = [aDecoder decodeBoolForKey:@"Flow_RsPayment"];
        self.Flow_RsApplyLeave = [aDecoder decodeBoolForKey:@"Flow_RsApplyLeave"];
        self.Flow_RsBreakDown = [aDecoder decodeBoolForKey:@"Flow_RsBreakDown"];
        
        self.Flow_Equipment = [aDecoder decodeBoolForKey:@"Flow_Equipment"];
        self.Flow_EquipService = [aDecoder decodeBoolForKey:@"Flow_EquipService"];
        
        
        self.Flow_Payment = [aDecoder decodeBoolForKey:@"Flow_Payment"];
        self.Flow_FixedAssets = [aDecoder decodeBoolForKey:@"Flow_FixedAssets"];
        self.Flow_Advertising = [aDecoder decodeBoolForKey:@"Flow_Advertising"];
        self.Flow_UsedIdle = [aDecoder decodeBoolForKey:@"Flow_UsedIdle"];
        self.Flow_WasteDisposal = [aDecoder decodeBoolForKey:@"Flow_WasteDisposal"];
        self.AM_Requisition = [aDecoder decodeBoolForKey:@"AM_Requisition"];
        self.AM_SetlleIn = [aDecoder decodeBoolForKey:@"AM_SetlleIn"];
        self.Flow_SpecialApplication = [aDecoder decodeBoolForKey:@"Flow_SpecialApplication"];
        
        self.BM_OutNotice = [aDecoder decodeBoolForKey:@"BM_OutNotice"];
        self.BS_OutNotice = [aDecoder decodeBoolForKey:@"BS_OutNotice"];
        self.SL_OutNotice = [aDecoder decodeBoolForKey:@"SL_OutNotice"];
        self.SM_Transfer = [aDecoder decodeBoolForKey:@"SM_Transfer"];
        self.ES_Transfer = [aDecoder decodeBoolForKey:@"ES_Transfer"];
        self.SL_Transfer = [aDecoder decodeBoolForKey:@"SL_Transfer"];
        self.BM_Transfer = [aDecoder decodeBoolForKey:@"BM_Transfer"];
        self.BL_OutNotice = [aDecoder decodeBoolForKey:@"BL_OutNotice"];
        self.SM_SendNotice = [aDecoder decodeBoolForKey:@"SM_SendNotice"];
        self.ES_OutNotice = [aDecoder decodeBoolForKey:@"ES_OutNotice"];
        self.SC_PayIn = [aDecoder decodeBoolForKey:@"SC_PayIn"];
        
        
        
        self.BM_MtlReturn = [aDecoder decodeBoolForKey:@"BM_MtlReturn"];
        self.FG_EngQuotation = [aDecoder decodeBoolForKey:@"FG_EngQuotation"];
        self.FG_ProcessProduct = [aDecoder decodeBoolForKey:@"FG_ProcessProduct"];
        self.FG_ProcessProtocol = [aDecoder decodeBoolForKey:@"FG_ProcessProtocol"];
        self.FG_ProfitQuote = [aDecoder decodeBoolForKey:@"FG_ProfitQuote"];
        
        
        
        self.OA_Market_Home = [aDecoder decodeBoolForKey:@"OA_Market_Home"];
        self.OA_BM_IO = [aDecoder decodeBoolForKey:@"OA_BM_IO"];
        self.OA_SL_IO = [aDecoder decodeBoolForKey:@"OA_SL_IO"];
        self.OA_Lease = [aDecoder decodeBoolForKey:@"OA_Lease"];
        self.OA_Ledger = [aDecoder decodeBoolForKey:@"OA_Ledger"];
        
        self.OA_Ledger_Dtl = [aDecoder decodeBoolForKey:@"OA_Ledger_Dtl"];
        self.OA_Market_Fee = [aDecoder decodeBoolForKey:@"OA_Market_Fee"];
        self.OA_Market_Dealer_Fee = [aDecoder decodeBoolForKey:@"OA_Market_Dealer_Fee"];
        
        self.OA_Market_Pay_In = [aDecoder decodeBoolForKey:@"OA_Market_Pay_In"];
               self.OA_Market_Settle_In = [aDecoder decodeBoolForKey:@"OA_Market_Settle_In"];
        
      
        self.Flow_PropertyServices = [aDecoder decodeBoolForKey:@"Flow_PropertyServices"];
        self.Flow_TrainingCosts = [aDecoder decodeBoolForKey:@"Flow_TrainingCosts"];
        
        
        
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    RSUserModel * usermodel = [[self.class allocWithZone:zone] init];
    usermodel.userId = self.userId;
    usermodel.userCode = self.userCode;
    usermodel.userName = self.userName;
    usermodel.appLoginToken = self.appLoginToken;
    usermodel.deptName = self.deptName;
    usermodel.sex = self.sex;
    usermodel.aesKey = self.aesKey;
    usermodel.deptId = self.deptId;
    usermodel.empId = self.empId;
    usermodel.empName = self.empName;
    
    
    usermodel.Flow_Purchase = self.Flow_Purchase;
    usermodel.Flow_Restaurant = self.Flow_Restaurant;
    usermodel.UseCar = self.UseCar;
    usermodel.Flow_Receptions = self.Flow_Receptions;
    usermodel.Flow_SupplierConsume = self.Flow_SupplierConsume;
    usermodel.Flow_VehicleReservation = self.Flow_VehicleReservation;
    usermodel.Flow_ApplyActivity = self.Flow_ApplyActivity;
    usermodel.Entertain = self.Entertain;
    usermodel.Flow_Entertain = self.Flow_Entertain;
    
    
    usermodel.Flow_ApplyLeave = self.Flow_ApplyLeave;
    usermodel.Flow_BreakDown = self.Flow_BreakDown;
    usermodel.Flow_HumanNeed = self.Flow_HumanNeed;
    usermodel.Flow_Quit = self.Flow_Quit;
    usermodel.Flow_PostMove = self.Flow_PostMove;
    usermodel.Flow_Become = self.Flow_Become;
    usermodel.Flow_Business = self.Flow_Business;
    usermodel.Flow_WorkOvertime = self.Flow_WorkOvertime;
    
    usermodel.Flow_InvestContract = self.Flow_InvestContract;
    usermodel.Flow_Contract = self.Flow_Contract;
    usermodel.Flow_Cachet = self.Flow_Cachet;
    usermodel.Flow_InCachet = self.Flow_InCachet;
    usermodel.Flow_FileUpdate = self.Flow_FileUpdate;
    usermodel.Flow_Chapter = self.Flow_Chapter;
    usermodel.Flow_SaleContract = self.Flow_SaleContract;
    
    
    usermodel.Flow_RsPayment = self.Flow_RsPayment;
    usermodel.Flow_RsApplyLeave = self.Flow_RsApplyLeave;
    usermodel.Flow_RsBreakDown = self.Flow_RsBreakDown;
    
    usermodel.Flow_Equipment = self.Flow_Equipment;
    usermodel.Flow_EquipService = self.Flow_EquipService;
    
    
    usermodel.Flow_Payment = self.Flow_Payment;
    usermodel.Flow_FixedAssets = self.Flow_FixedAssets;
    usermodel.Flow_Advertising = self.Flow_Advertising;
    usermodel.Flow_UsedIdle = self.Flow_UsedIdle;
    usermodel.Flow_WasteDisposal = self.Flow_WasteDisposal;
    usermodel.AM_Requisition = self.AM_Requisition;
    usermodel.AM_SetlleIn = self.AM_SetlleIn;
    usermodel.Flow_SpecialApplication = self.Flow_SpecialApplication;
    
    usermodel.BM_OutNotice = self.BM_OutNotice;
    usermodel.BS_OutNotice = self.BS_OutNotice;
    usermodel.SL_OutNotice = self.SL_OutNotice;
    usermodel.SM_Transfer = self.SM_Transfer;
    usermodel.ES_Transfer = self.ES_Transfer;
    usermodel.SL_Transfer = self.SL_Transfer;
    usermodel.BM_Transfer = self.BM_Transfer;
    usermodel.BL_OutNotice = self.BL_OutNotice;
    usermodel.SM_SendNotice = self.SM_SendNotice;
    usermodel.ES_OutNotice = self.ES_OutNotice;
    usermodel.SC_PayIn = self.SC_PayIn;
    usermodel.BM_MtlReturn = self.BM_MtlReturn;
    usermodel.FG_EngQuotation = self.FG_EngQuotation;
    usermodel.FG_ProcessProduct = self.FG_ProcessProduct;
    usermodel.FG_ProcessProduct = self.FG_ProcessProduct;
    usermodel.FG_ProfitQuote = self.FG_ProfitQuote;
    
    usermodel.OA_Market_Home = self.OA_Market_Home;
     usermodel.OA_BM_IO = self.OA_BM_IO;
     usermodel.OA_SL_IO = self.OA_SL_IO;
     usermodel.OA_Lease = self.OA_Lease;
     usermodel.OA_Ledger = self.OA_Ledger;
    
    usermodel.OA_Ledger_Dtl = self.OA_Ledger_Dtl;
        usermodel.OA_Market_Fee = self.OA_Market_Fee;
        usermodel.OA_Market_Dealer_Fee = self.OA_Market_Dealer_Fee;
    
    
    usermodel.OA_Market_Pay_In = self.OA_Market_Pay_In;
          usermodel.OA_Market_Settle_In = self.OA_Market_Settle_In;
    
    usermodel.Flow_PropertyServices = self.Flow_PropertyServices;
    usermodel.Flow_TrainingCosts = self.Flow_TrainingCosts;
    
   
    
    return usermodel;
}

@end
