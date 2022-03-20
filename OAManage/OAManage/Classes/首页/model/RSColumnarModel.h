//
//  RSColumnarModel.h
//  OAManage
//
//  Created by mac on 2020/10/26.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSColumnarModel : NSObject


/**合同管理*/

/**合同编号*/
@property (nonatomic,strong)NSString * no;
/**合同标题*/
@property (nonatomic,strong)NSString * billTitle;
/**合同状态0 未提交  2 审核中  10 已生效  12 已过期）*/
@property (nonatomic,assign)NSInteger status;
/**合同日期（yyyy-MM-dd）*/
@property (nonatomic,strong)NSString * billDate;
/**合同ID*/
@property (nonatomic,strong)NSString * billId;
/**合同类型*/
@property (nonatomic,strong)NSString * billType;



/**报表管理*/
/**入库*/
@property (nonatomic,strong)NSNumber * volumeIn;
/**出库*/
@property (nonatomic,strong)NSNumber * volumeOut;
/**收款*/
@property (nonatomic,strong)NSNumber * bmStorageFee;
/**空地租金*/
@property (nonatomic,strong)NSNumber * bmSpaceRent;

/**入库差异比*/
@property (nonatomic,strong)NSNumber * areaIn;
/**出库差异比*/
@property (nonatomic,strong)NSNumber * areaOut;


/**大板收款差异比*/
@property (nonatomic,strong)NSNumber * slAmount;
/**条板收款差异比*/
@property (nonatomic,strong)NSNumber * smAmount;
/**业务楼收款差异比*/
@property (nonatomic,strong)NSNumber * pmAmount;



/**费用名称代号*/
@property (nonatomic,strong)NSString * feeCode;
/**对应费用名称*/
@property (nonatomic,strong)NSString * feeName;
/**总格数/间数*/
@property (nonatomic,assign)NSInteger maxQty;
/**新租商户*/
@property (nonatomic,assign)NSInteger newDealerCount;
/**新租格数/间数*/
@property (nonatomic,assign)NSInteger newQty;
/**未租*/
@property (nonatomic,assign)NSInteger notRentedQty;
/**续租商户*/
@property (nonatomic,assign)NSInteger rebackDealerCount;
/**续租格数/间数*/
@property (nonatomic,assign)NSInteger rebackQtyCount;
/**退租商户*/
@property (nonatomic,assign)NSInteger renewalDealerCount;
/**退租格数/间数*/
@property (nonatomic,assign)NSInteger renewalQty;
/**已租*/
@property (nonatomic,assign)NSInteger rentedQty;
/**租用比率*/
@property (nonatomic,strong)NSNumber * rate;



/**账单管理********/



//获取商户费用应收余额列表
/**结算对象ID*/
@property (nonatomic,assign)NSInteger dealerId;
/**结算对象名称*/
@property (nonatomic,strong)NSString * dealerName;
/**上期总应收*/
@property (nonatomic,strong)NSNumber * moneyBegin;
/**本期应收*/
@property (nonatomic,strong)NSNumber * moneyIn;
/**总收款*/
@property (nonatomic,strong)NSNumber * moneyOut;
/**本期结存*/
@property (nonatomic,strong)NSNumber * moneyEnd;

-(NSDictionary *)getDicOfOB;


//获取园区费用应收余额列表
/**费用ID*/
@property (nonatomic,assign)NSInteger feeId;
/**费用类型*/
//@property (nonatomic,strong)NSString * feeName;
/**上期总应收*/
//@property (nonatomic,strong)NSString * moneyBegin;
/**本期应收*/
//@property (nonatomic,strong)NSString * moneyIn;
/**总收款*/
//@property (nonatomic,strong)NSString * moneyOut;
/**本期结存*/
//@property (nonatomic,strong)NSString * moneyEnd;

-(NSDictionary *)getParkDicOfOB;

//获取园区收款明细列表
/**结算对象ID*/
//@property (nonatomic,assign)NSInteger dealerId;
/**结算对象名称*/
//@property (nonatomic,strong)NSString * dealerName;
/**费用ID*/
//@property (nonatomic,assign)NSInteger feeId;
/**费用类型*/
//@property (nonatomic,strong)NSString * feeName;
/**金额*/
@property (nonatomic,strong)NSNumber * money;
/**会计期*/
@property (nonatomic,strong)NSString * month;
/**摘要*/
@property (nonatomic,strong)NSString * notes;
/**收款类型*/
@property (nonatomic,strong)NSString * payType;


-(NSDictionary *)getParkDicOfDetailedOB;

//获取园区应收明细列表
/**结算对象ID*/
//@property (nonatomic,assign)NSInteger dealerId;
/**结算对象名称*/
//@property (nonatomic,strong)NSString * dealerName;
/**费用ID*/
//@property (nonatomic,assign)NSInteger feeId;
/**费用类型*/
//@property (nonatomic,strong)NSString * feeName;
/**金额*/
//@property (nonatomic,strong)NSString * money;
/**会计期*/
//@property (nonatomic,strong)NSString * month;

-(NSDictionary *)getParkDicOfReceivableOB;

//获取商户费用应收明细
//@property (nonatomic,strong)NSString * feeName;

@property (nonatomic,strong)NSNumber * value;

@property (nonatomic,strong)NSNumber * totalFee;

@end

NS_ASSUME_NONNULL_END
