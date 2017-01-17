//
//  HistoryDao.h
//  ProjectTools
//
//  Created by Vols on 2017/1/17.
//  Copyright © 2017年 Vols. All rights reserved.
//

/**
 *  历史记录本地数据操作
 */
#import <Foundation/Foundation.h>
#import "DBHelper.h"
#import "StockModel.h"

/*
 *  不同的历史记录类型
 */
typedef NS_ENUM(NSUInteger, HistoryType) {
    HistoryTypeNormalText = 1,      // 普通文本
    
    HistoryTypeStock100 = 100,      // 自选股模块的搜索记录
    HistoryTypeStock101,            // 定制模块的搜索记录
};


@interface HistoryDao : NSObject

// -----------  存取股票数据模型 -----------

+ (void)insertStockHistory:(StockModel *)stockModel historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion;

+ (void)deleteStockHistory:(NSString *)stockCode historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion;

+ (void)deleteAllStockHistory:(HistoryType)historyType completion:(void(^)(BOOL success))completion ;

+ (void)updateStockHistory:(StockModel *)stockModel historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion;

+ (void)queryStockHistory:(HistoryType)historyType historyData:(void(^)(NSArray *stocks))completion;

/*
 *  数据库里是否有某个股
 */
+ (void)checkIfExistStock:(NSString *)stockCode historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion;

/*
 *  改变某个股的选择状态
 */
+ (void)updateStock:(NSString *)stockCode isSelect:(BOOL)isSelect historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion;




// --------  单个搜索记录文本 --------

+ (void)addSearchRecord:(NSString *)searchString historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion;

+ (void)deleteSearchRecord:(NSString *)searchString historyType:(HistoryType)historyType completion:(void(^)(BOOL success))completion;

+ (void)deleteAllSearchRecords:(HistoryType)historyType completion:(void(^)(BOOL success))completion ;

+ (void)querySearchRecords:(HistoryType)historyType historyData:(void(^)(NSArray *records))completion;

// ------------------------------

@end
