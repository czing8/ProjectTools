//
//  VHistoryHelper.h
//  ProjectTools
//
//  Created by Vols on 2016/2/13.
//  Copyright © 2016年 Vols. All rights reserved.
//

/*******************************************
 *  历史记录模块
 *
 *  #breif 搜索模块里的历史记录视图
 ******************************************/

#import <Foundation/Foundation.h>
#import "VHistoryCell.h"
#import "HistoryDao.h"


typedef NS_ENUM(NSUInteger, HistoryListType) {
    HistoryListTypeSingleText,      // 只有一个文本的历史记录
    HistoryListTypeCustom,          // 定制搜索记录列表Cell
};


@interface VHistoryHelper : NSObject

- (instancetype)initWithHistoryType:(HistoryType)historyType;

- (void)bindHistoryListToView:(UIView *)attachView clickHandler:(void(^)(StockModel *))clickHandler;


/**
 *  移除tableView,tableView的数据源
 */
- (void)clearHistoryList;


/**
 *  判断tableView是否存在的方法
 */
- (BOOL)isHistoryListExits;


@end
