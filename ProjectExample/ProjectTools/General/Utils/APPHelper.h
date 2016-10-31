//
//  APPHelper.h
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  存储一切与app有关的属性配置
 */
@interface APPHelper : NSObject

+ (NSString *)appShortVersion;      //app版本号
+ (NSString *)appVersion;           //app打包号


+ (NSString *)appName;              //app名称

+ (NSString *)appCurrentOSVersion;  //当前iOS版本


/**
 *  设备ID，使用keychain保存获取的vender
 */
+ (NSString *)deviceId;             //设备id



@end
