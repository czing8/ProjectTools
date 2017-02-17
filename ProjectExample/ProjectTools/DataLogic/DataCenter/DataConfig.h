//
//  LogicConfig.h
//  HBDemo
//
//  Created by hibor on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>
// 整体逻辑 参数配置
@interface DataConfig : NSObject

@property (nonatomic, readonly) int       environment;        // 环境
@property (nonatomic, readonly) BOOL      enableConsoleLog;   // 是否支持后台打印
@property (nonatomic, readonly) NSInteger logLevel;           // 日志级别

@end
