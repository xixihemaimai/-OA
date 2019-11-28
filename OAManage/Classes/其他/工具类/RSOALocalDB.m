//
//  RSOALocalDB.m
//  OAManage
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSOALocalDB.h"
#import "RSOACreatFile.h"
#import "RSMailModel.h"

@implementation RSOALocalDB


- (RSOALocalDB *)initWithCreatTypeList:(NSString *)creatList{
    if (self = [super init]) {
        _creatList = creatList;
        NSString* dbPath = [RSOACreatFile getPathWithinDocumentDir:creatList];
         NSLog(@"%@",dbPath);
        //创建文件管理器
        NSFileManager* fileManager = [NSFileManager defaultManager];
        //判断文件是否存在
        BOOL existFile = [fileManager fileExistsAtPath:dbPath];
        if (existFile == NO) {
           NSString* poemDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:creatList];
           [fileManager copyItemAtPath:poemDBPath toPath:dbPath error:nil];
        }
        _db = [[FMDatabase alloc] initWithPath:dbPath];
        BOOL success = [_db open];
        if (success == NO) {
        return nil;
        }
    }
    return self;
}



- (BOOL)createContentTable
{
    [_db beginTransaction];
    BOOL success = false;
    //仓库
    if ([self.creatList isEqualToString:@"mailList.sqlite"]) {
        success  = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_mailList(mailListID integer primary key autoincrement,'code' text,'name' text,'sex' text,'department' text, 'position' text,'phone1' text,'phone2' text,'phone3' text,'email' text);"];
    }
    [_db commit];
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"faild");
        return NO;
    }
    else {
        NSLog(@"success12");
    }
    return YES;
}





//批处理数据 仅作示例
- (void)batchAddMutableArray:(NSMutableArray *)array{
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (int i = 0; i<array.count; i++) {
            BOOL success = NO;
            if ([self.creatList isEqualToString:@"mailList.sqlite"]) {
                //仓库
                RSMailModel * mailmodel = array[i];
               
                success = [_db executeUpdate:@"INSERT INTO t_mailList(code,name,sex,department,position,phone1,phone2,phone3,email) VALUES (?,?,?,?,?,?,?,?,?);",mailmodel.code,mailmodel.name,mailmodel.sex,mailmodel.department,mailmodel.position,mailmodel.phone1,mailmodel.phone2,mailmodel.phone3,mailmodel.email];
            }
            if (!success ) {
                NSLog(@"插入失败1");
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
    }
    @finally {
        if (!isRollBack) {
            [_db commit];
        }
    }
}


//删除所有数据
- (void)deleteAllContent
{
    [_db beginTransaction];
    BOOL success = NO;
    if ([self.creatList isEqualToString:@"mailList.sqlite"]) {
        success = [_db executeUpdate:@"DELETE  FROM t_mailList;"];
    }
    [_db commit];
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"error1");
        //return NO;
    }
}


//获取所有数据
- (NSMutableArray*)getAllContent
{
    NSMutableArray* result = [NSMutableArray array];
    NSString * sqlStr = [NSString string];
    if ([self.creatList isEqualToString:@"mailList.sqlite"]) {
         sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_mailList"];
    }
    FMResultSet* rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        if ([self.creatList isEqualToString:@"mailList.sqlite"]) {
            RSMailModel * mailmodel = [[RSMailModel alloc]init];
            mailmodel.code = [rs stringForColumn:@"code"];
            mailmodel.name = [rs stringForColumn:@"name"];
            mailmodel.sex = [rs stringForColumn:@"sex"];
            mailmodel.department = [rs stringForColumn:@"department"];
            mailmodel.position = [rs stringForColumn:@"position"];
            mailmodel.phone1 = [rs stringForColumn:@"phone1"];
            mailmodel.phone2 = [rs stringForColumn:@"phone2"];
            mailmodel.phone3 = [rs stringForColumn:@"phone3"];
            mailmodel.email = [rs stringForColumn:@"email"];
            [result addObject:mailmodel];
        }
    }
    [rs close];
    return result;
}


- (NSMutableArray*)serachContent:(NSString*)searchText
{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    NSString * sqlStr = [NSString string];
    if ([self.creatList isEqualToString:@"mailList.sqlite"]) {
        sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM t_mailList WHERE name LIKE '%@%%'", searchText];
    }
    FMResultSet* rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        if ([self.creatList isEqualToString:@"mailList.sqlite"]) {
           RSMailModel * mailmodel = [[RSMailModel alloc]init];
           mailmodel.code = [rs stringForColumn:@"code"];
           mailmodel.name = [rs stringForColumn:@"name"];
           mailmodel.sex = [rs stringForColumn:@"sex"];
           mailmodel.department = [rs stringForColumn:@"department"];
           mailmodel.position = [rs stringForColumn:@"position"];
           mailmodel.phone1 = [rs stringForColumn:@"phone1"];
           mailmodel.phone2 = [rs stringForColumn:@"phone2"];
           mailmodel.phone3 = [rs stringForColumn:@"phone3"];
           mailmodel.email = [rs stringForColumn:@"email"];
           [result addObject:mailmodel];
        }
    }
    [rs close];
    return result;
}


@end
