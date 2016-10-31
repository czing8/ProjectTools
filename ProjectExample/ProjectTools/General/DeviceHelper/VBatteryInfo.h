//
//  VBatteryInfo.h
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VBatteryInfo : NSObject

+ (float)batteryLevel;

+ (BOOL)isCharging;       //充电中

+ (BOOL)fullyCharged;


@end
