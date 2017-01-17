//
//  VDeviceHelper.h
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VDeviceHelper : NSObject

+ (_Nonnull instancetype)shared;

@property (nonatomic, readonly) BOOL isPad;
@property (nonatomic, readonly) BOOL isSimulator;

@property (nonatomic, readonly, nullable) NSString  * deviceID; // 获取设备的唯一标示(获取vender，存到keychain里，只要不刷机，就不会变)
@property (nonatomic, readonly, nullable) NSString  * systemVersion;
@property (nonatomic, readonly, nullable) NSDate    * systemUptime;
@property (nonatomic, readonly, nullable) NSString  * systemName;
@property (nonatomic, readonly, nullable) NSString  * machineModel; //e.g. "iPhone6,1" "iPad4,6"
@property (nonatomic, readonly, nullable) NSString  * machineModelName; //e.g. "iPhone 5s" "iPad mini 2"

@property (nonatomic, readonly) NSInteger screenWidth;
@property (nonatomic, readonly) NSInteger screenHeight;
@property (nonatomic, readonly) float screenBrightness;         //屏幕亮度

@property (nonatomic, readonly) BOOL multitaskingEnabled;       // 多任务
@property (nonatomic, readonly) BOOL proximitySensorEnabled;
@property (nonatomic, readonly) BOOL debuggerAttached;
@property (nonatomic, readonly) BOOL isCharging;                //充电中


@property (nonatomic, readonly) NSInteger numberProcessors;
@property (nonatomic, readonly) NSInteger numberActiveProcessors;
@property (nonatomic, readonly) NSInteger processorSpeed;
@property (nonatomic, readonly) NSInteger processorBusSpeed;

@end
