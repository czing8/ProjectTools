//
//  StockModel.h
//  ProjectTools
//
//  Created by Vols on 2016/1/17.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockModel : NSObject

@property (nonatomic, strong) NSString  * stockShortName;   //股票简称
@property (nonatomic, strong) NSString  * stockCode;        //股票代码
@property (nonatomic, strong) NSString  * stockName;        //股票名字
@property (nonatomic, strong) NSString  * stockType;        //A股or其他

@property (nonatomic, assign) BOOL      isSelect;           //是否自选股


@end
