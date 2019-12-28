//
//  RSOALocalDB.h
//  OAManage
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSOALocalDB : NSObject
{
    //数据库
    FMDatabase * _db;
    
}

/**判断创建了那些表*/
@property (nonatomic,strong)NSString * creatList;


- (RSOALocalDB *)initWithCreatTypeList:(NSString * )creatList;

/**创建数据表*/
- (BOOL)createContentTable;


/**删除所有数据*/
- (void)deleteAllContent;

/**获取所有数据*/
- (NSMutableArray *)getAllContent;


/**搜索内容*/
- (NSMutableArray *)serachContent:(NSString*)searchText;

/**搜索库区的内容*/
- (NSMutableArray*)serachWhsID:(NSInteger)whsid;
/**库区的搜索内容*/
- (NSMutableArray*)serachNewContent:(NSInteger)whsid andName:(NSString *)name;


/**批处理数据 仅作示例*/
- (void)batchAddMutableArray:(NSMutableArray *)array;


@end

NS_ASSUME_NONNULL_END
