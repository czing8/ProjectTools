//
//  VBatteryInfo.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VBatteryInfo.h"
#import <UIKit/UIKit.h>

@implementation VBatteryInfo

+ (float)batteryLevel {
    @try {
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        float batteryCharge = [[UIDevice currentDevice] batteryLevel];
        return (batteryCharge > 0.0f ? batteryCharge * 100 : -1);
    }
    @catch (NSException *exception) {
        return -1;
    }
}


+ (BOOL)isCharging {
    @try {
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        UIDeviceBatteryState batteryState = [[UIDevice currentDevice] batteryState];
        
        if (batteryState == UIDeviceBatteryStateCharging || batteryState == UIDeviceBatteryStateFull) {
            return true;
        } else {
            return false;
        }
    }
    @catch (NSException *exception) {
        return false;
    }
}

+ (BOOL)fullyCharged {
    @try {
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        UIDeviceBatteryState batteryState = [[UIDevice currentDevice] batteryState];
        return (batteryState == UIDeviceBatteryStateFull ? true : false);
    }
    @catch (NSException *exception) {
        return false;
    }
}

@end
