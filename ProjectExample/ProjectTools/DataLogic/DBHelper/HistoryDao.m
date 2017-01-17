//
//  HistoryDao.m
//  ProjectTools
//
//  Created by Vols on 2017/1/17.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import "HistoryDao.h"

#define kHistoryMaxNum  100

@implementation HistoryDao

#pragma mark - 记录搜索股票数据模型

+ (void)insertStockHistory:(StockModel *)stockModel historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion {
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"stock_history_list"]) {
            [db executeUpdate:@"create table stock_history_list(stock_code PRIMARY KEY, stock_shortName, stock_name, stock_type, isSelect integer, searchTime, historyType)"];
        }

        BOOL success = [db executeUpdate:@"replace into stock_history_list(stock_code, stock_shortName, stock_name, stock_type, isSelect, searchTime, historyType) values(?, ?, ?, ?, ?, ?, ?)", stockModel.stockCode, stockModel.stockShortName, stockModel.stockName, stockModel.stockType, @(stockModel.isSelect), [HistoryDao getTimestamp], @(historyType)];
        
        completion(success);
    }];
}

+ (void)deleteStockHistory:(NSString *)stockCode historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion {
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db){
        
        BOOL success = [db executeUpdate:@"delete from stock_history_list where stock_code = ? and historyType = ?", stockCode, @(historyType)];
        completion(success);
    }];
}


+ (void)deleteAllStockHistory:(HistoryType)historyType completion:(void(^)(BOOL success))completion {
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db){
        
        BOOL success = [db executeUpdate:@"delete from stock_history_list where historyType = ?", @(historyType)];
        completion(success);
    }];
}

// 跟addStockHistory一样，replace into 兼insert、update功能
+ (void)updateStockHistory:(StockModel *)stockModel historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion {
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"stock_history_list"]) {
            [db executeUpdate:@"create table stock_history_list(stock_code PRIMARY KEY, stock_shortName, stock_name, stock_type, isSelect bit, searchTime, historyType)"];
        }
        
        BOOL success = [db executeUpdate:@"replace into stock_history_list(stock_code, stock_shortName, stock_name, stock_type, isSelect, searchTime, historyType) values(?, ?, ?, ?, ?, ?, ?)", stockModel.stockCode, stockModel.stockShortName, stockModel.stockName, stockModel.stockType, @(stockModel.isSelect), [HistoryDao getTimestamp], @(historyType)];
        
        completion(success);
    }];
}

+ (void)queryStockHistory:(HistoryType)historyType historyData:(void(^)(NSArray *stocks))completion {
    __block NSMutableArray * stockArray = [[NSMutableArray alloc] init];
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        
        if (![db tableExists:@"stock_history_list"]) {
            [db executeUpdate:@"create table stock_history_list(stock_code PRIMARY KEY, stock_shortName, stock_name, stock_type, isSelect bit, searchTime, historyType)"];
        }
        
        FMResultSet *rs = [db executeQuery:@"select * from stock_history_list where historyType = ? order by searchTime desc", @(historyType)];
        int count = 0;
        
        while ([rs next]) {
            count++;
            StockModel * stockModel = [HistoryDao stockForRS:rs];
            [stockArray addObject:stockModel];
            
            if (count >= kHistoryMaxNum) {
                [db executeUpdate:@"delete from stock_history_list where searchTime < ?",[rs objectForColumnName:@"searchTime"]];
                break;
            }
        }
        completion(stockArray);
        
        [rs close];
    }];
}


/*
 *  数据库里是否有某个股
 */
+ (void)checkIfExistStock:(NSString *)stockCode historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion {
    //    if exists (select * from tableName where conditions) select '1' else select '0'
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db){
        
        NSUInteger count = [db intForQuery:@"select count(*) from stock_history_list where historyType = ? and stock_code = ?", @(historyType), stockCode];
        
        if (count > 0) {
//            BOOL success = [db executeUpdate:@"update stock_history_list set isSelect = '1' where historyType = ? and stock_code = ?", @(historyType), stockCode];
            completion(YES);
        }else{
            completion(NO);
        }
    }];
}

+ (void)updateStock:(NSString *)stockCode isSelect:(BOOL)isSelect historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion {
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db){
        BOOL success = [db executeUpdate:@"update stock_history_list set isSelect = ? where historyType = ? and stock_code = ?", @(isSelect), @(historyType), stockCode];
        completion(success);
    }];
}



#pragma mark - 记录单条搜索记录文本

+ (void)addSearchRecord:(NSString *)searchString historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion {
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"search_record_list"]) {
            [db executeUpdate:@"create table search_record_list(searchText PRIMARY KEY, searchTime, historyType)"];
        }
        BOOL success = [db executeUpdate:@"replace into search_record_list(searchText, searchTime, historyType) values(?, ?, ?)", searchString, [HistoryDao getTimestamp], @(historyType)];
        
        completion(success);
    }];
}


+ (void)deleteSearchRecord:(NSString *)searchString historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion {
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db){
        BOOL success = [db executeUpdate:@"delete from search_record_list where searchText = ? and historyType = ?", searchString, @(historyType)];
        completion(success);
    }];
}


+ (void)deleteAllSearchRecords:(HistoryType)historyType completion:(void(^)(BOOL success))completion {
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db){
        BOOL success = [db executeUpdate:@"delete from search_record_list where historyType = ?", @(historyType)];
        completion(success);
    }];
}

+ (void)querySearchRecords:(HistoryType)historyType historyData:(void(^)(NSArray *records))completion {
    
    __block NSMutableArray * resultArray = [[NSMutableArray alloc] init];
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        
        if (![db tableExists:@"search_record_list"]) {
            [db executeUpdate:@"create table search_record_list(searchText PRIMARY KEY, searchTime, historyType)"];
        }
        
        FMResultSet *rs = [db executeQuery:@"select * from search_record_list where historyType = ? order by searchTime desc", @(historyType)];
        int count = 0;
        
        while ([rs next]) {
            count++;
            [resultArray addObject:[rs stringForColumn:@"searchText"]];
            
            if (count >= kHistoryMaxNum) {
                [db executeUpdate:@"delete from search_record_list where searchTime < ?",[rs objectForColumnName:@"searchTime"]];
                break;
            }
        }
        completion(resultArray);
        
        [rs close];
    }];
}





#pragma mark - Helpers

+ (StockModel *)stockForRS:(FMResultSet *)rs {
    
    StockModel * stock  = [[StockModel alloc] init];
    stock.stockCode = [rs stringForColumn:@"stock_code"];
    stock.stockName = [rs stringForColumn:@"stock_name"];
    stock.stockShortName = [rs stringForColumn:@"stock_shortName"];
    stock.stockType = [rs stringForColumn:@"stock_type"];
    stock.isSelect = [rs boolForColumn:@"isSelect"];
    
    return stock;
}

+ (NSNumber *)getTimestamp {
    NSTimeInterval timerSp = [[NSDate date] timeIntervalSince1970];
    return [NSNumber numberWithDouble:timerSp];
}

@end
