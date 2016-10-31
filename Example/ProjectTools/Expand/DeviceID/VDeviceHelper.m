//
//  VDeviceHelper.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VDeviceHelper.h"

#import "VSystemInfo.h"
#import "VBatteryInfo.h"
#import "VHardwareInfo.h"

@implementation VDeviceHelper

+ (_Nonnull instancetype)shared{
    static VDeviceHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (BOOL)isPad{
    return [VSystemInfo isPad];
}


- (BOOL)isSimulator{
    return [VSystemInfo isSimulator];
}


- (NSString *)deviceID{
    return [VSystemInfo deviceID];
}


- (NSString *)systemVersion{
    return [VSystemInfo systemVersion];
}

- (NSDate *)systemUptime{
    return [VSystemInfo systemUptime];
}

- (NSString *)systemName{
    return [VSystemInfo systemName];
}

- (NSString *)machineModel{
    return [VSystemInfo machineModel];
}

- (NSString *)machineModelName{
    return [VSystemInfo machineModelName];
}

- (NSInteger)screenWidth{
    return [VSystemInfo screenWidth];
}

- (NSInteger)screenHeight{
    return [VSystemInfo screenHeight];
}

- (float)screenBrightness{
    return [VSystemInfo screenBrightness];
}

- (BOOL)multitaskingEnabled{
    return [VSystemInfo multitaskingEnabled];
}

- (BOOL)proximitySensorEnabled{
    return [VSystemInfo proximitySensorEnabled];
}

- (BOOL)debuggerAttached{
    return [VSystemInfo debuggerAttached];
}

- (BOOL)isCharging{
    return [VBatteryInfo isCharging];
}

- (NSInteger)numberProcessors {
    return [VHardwareInfo numberProcessors];
}

- (NSInteger)numberActiveProcessors {
    return [VHardwareInfo numberActiveProcessors];
}

- (NSInteger)processorSpeed {
    return [VHardwareInfo processorSpeed];
}

- (NSInteger)processorBusSpeed {
    return [VHardwareInfo processorBusSpeed];
}


@end
