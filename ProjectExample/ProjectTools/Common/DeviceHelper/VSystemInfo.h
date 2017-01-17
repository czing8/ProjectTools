//
//  VSystemInfo.h
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSystemInfo : NSObject

+ (BOOL)isPad;
+ (BOOL)isSimulator;

+ (nullable NSString *)deviceID;        // 获取设备的唯一标示(获取vender，存到keychain里，只要不刷机，就不会变)

+ (nullable NSString *)systemName;
+ (nullable NSString *)systemVersion;
+ (nullable NSDate *)systemUptime;

// e.g. "iPhone6,1" "iPad4,6"           @see http://theiphonewiki.com/wiki/Models
+ (nullable NSString *)machineModel;

// e.g. "iPhone 5s" "iPad mini 2"       @see http://theiphonewiki.com/wiki/Models
+ (nullable NSString *)machineModelName;



+ (NSInteger)screenWidth;
+ (NSInteger)screenHeight;
+ (float)screenBrightness;              //屏幕亮度
+ (BOOL)multitaskingEnabled;            // 多任务
+ (BOOL)proximitySensorEnabled;
+ (BOOL)debuggerAttached;


@end
