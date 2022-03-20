//
//  MyTableListView.h
//  xxxxxxxx
//
//  Created by WF on 2017/1/14.
//  Copyright © 2017年 WF. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BCContentOB.h"

#import "RSColumnarModel.h"

//typedef enum{
//    //获取园区费用应收余额列表
//    market_fee = 1,
//    //获取商户费用应收余额列表
//    dealer_fee = 2,
//    //获取商户费用应收明细
//    dealer_fee_dtl = 3,
//    //获取园区收款明细列表
//    pay_market_fee = 4,
//    //获取园区应收明细列表
//    market_fee_dtl = 5
//
//}MarketPee;
//


typedef void(^DetailBlock)(NSInteger index);

@protocol MyTableListViewDelegate <NSObject>
@optional
-(void)successOfCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface MyTableListView : UIView

@property(strong,nonatomic)UICollectionView * collectionView;

@property(strong,nonatomic)UITableView * table;

@property(strong,nonatomic)UITableView * rightTable;

@property(strong,nonatomic)NSDictionary* upOnedic;
@property(weak,nonatomic)id<MyTableListViewDelegate>delegate;

@property (nonatomic,strong)DetailBlock detailBlock;

@property(strong,nonatomic)NSMutableArray * arrayContent;//内容列表


-(instancetype)initWithFrame:(CGRect)frame andContentDicArray:(NSMutableArray *)contentDicArray andAttributeName:(NSArray *)attributeName andAttribute:(NSArray *)attribute andMarketPee:(NSInteger)marketpee;


-(void)addColumnarContentArray:(NSMutableArray *)array;


@end
