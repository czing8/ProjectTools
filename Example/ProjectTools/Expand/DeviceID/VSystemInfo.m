//
//  VSystemInfo.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VSystemInfo.h"
#import <UIKit/UIKit.h>

#include <sys/types.h>
#include <sys/sysctl.h>

#import "HSKeyChain.h"
#import <UIKit/UIKit.h>


static NSString * const KEY_DEVICEID    = @"com.haierSmart.app.deviceid";

@implementation VSystemInfo

+ (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

+ (NSString *)machineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self machineModel];
        if (!model) return;
        NSDictionary *dic = @{
                              @"Watch1,1" : @"Apple Watch",
                              @"Watch1,2" : @"Apple Watch",
                              
                              @"iPod1,1" : @"iPod touch 1",
                              @"iPod2,1" : @"iPod touch 2",
                              @"iPod3,1" : @"iPod touch 3",
                              @"iPod4,1" : @"iPod touch 4",
                              @"iPod5,1" : @"iPod touch 5",
                              @"iPod7,1" : @"iPod touch 6",
                              
                              @"iPhone1,1" : @"iPhone 1G",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4 (GSM)",
                              @"iPhone3,2" : @"iPhone 4",
                              @"iPhone3,3" : @"iPhone 4 (CDMA)",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5",
                              @"iPhone5,2" : @"iPhone 5",
                              @"iPhone5,3" : @"iPhone 5c",
                              @"iPhone5,4" : @"iPhone 5c",
                              @"iPhone6,1" : @"iPhone 5s",
                              @"iPhone6,2" : @"iPhone 5s",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              
                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2 (WiFi)",
                              @"iPad2,2" : @"iPad 2 (GSM)",
                              @"iPad2,3" : @"iPad 2 (CDMA)",
                              @"iPad2,4" : @"iPad 2",
                              @"iPad2,5" : @"iPad mini 1",
                              @"iPad2,6" : @"iPad mini 1",
                              @"iPad2,7" : @"iPad mini 1",
                              @"iPad3,1" : @"iPad 3 (WiFi)",
                              @"iPad3,2" : @"iPad 3 (4G)",
                              @"iPad3,3" : @"iPad 3 (4G)",
                              @"iPad3,4" : @"iPad 4",
                              @"iPad3,5" : @"iPad 4",
                              @"iPad3,6" : @"iPad 4",
                              @"iPad4,1" : @"iPad Air",
                              @"iPad4,2" : @"iPad Air",
                              @"iPad4,3" : @"iPad Air",
                              @"iPad4,4" : @"iPad mini 2",
                              @"iPad4,5" : @"iPad mini 2",
                              @"iPad4,6" : @"iPad mini 2",
                              @"iPad4,7" : @"iPad mini 3",
                              @"iPad4,8" : @"iPad mini 3",
                              @"iPad4,9" : @"iPad mini 3",
                              @"iPad5,1" : @"iPad mini 4",
                              @"iPad5,2" : @"iPad mini 4",
                              @"iPad5,3" : @"iPad Air 2",
                              @"iPad5,4" : @"iPad Air 2",
                              @"iPad6,3" : @"iPad Pro (9.7 inch)",
                              @"iPad6,4" : @"iPad Pro (9.7 inch)",
                              @"iPad6,7" : @"iPad Pro (12.9 inch)",
                              @"iPad6,8" : @"iPad Pro (12.9 inch)",
                              
                              @"AppleTV2,1" : @"Apple TV 2",
                              @"AppleTV3,1" : @"Apple TV 3",
                              @"AppleTV3,2" : @"Apple TV 3",
                              @"AppleTV5,3" : @"Apple TV 4",
                              
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64",
                              };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}


+ (NSDate *)systemUptime {
    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    return [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
}


+ (NSString *)systemName {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(systemName)]) {
        return [[UIDevice currentDevice] systemName];
    } else {
        return nil;
    }
}

+ (NSString *)systemVersion {

    if ([[UIDevice currentDevice] respondsToSelector:@selector(systemVersion)]) {
        return [[UIDevice currentDevice] systemVersion];
    } else {
        return nil;
    }
}

+ (NSInteger)screenWidth {
    @try {
        NSInteger width = [[UIScreen mainScreen] bounds].size.width;
        return width < 0 ? -1 : width;
    }
    @catch (NSException *exception) {
        return -1;
    }
}


+ (NSInteger)screenHeight {
    @try {
        NSInteger height = [[UIScreen mainScreen] bounds].size.height;
        return height < 0 ? -1 : height;
    }
    @catch (NSException *exception) {
        return -1;
    }
}


+ (float)screenBrightness {
    @try {
        float brightness = [UIScreen mainScreen].brightness;
        if (brightness < 0.0 || brightness > 1.0) {
            return -1;
        }
        
        return (brightness * 100);
    }
    @catch (NSException *exception) {
        return -1;
    }
}



+ (BOOL)multitaskingEnabled {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        BOOL MultitaskingSupported = [UIDevice currentDevice].multitaskingSupported;
        return MultitaskingSupported;
    } else {
        return false;
    }
}

+ (BOOL)proximitySensorEnabled {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setProximityMonitoringEnabled:)]) {
        UIDevice *device = [UIDevice currentDevice];
        
        BOOL ProximitySensor;
        
        if (device.proximityMonitoringEnabled != YES) {
            // Sensor is off
            // Turn it on
            [device setProximityMonitoringEnabled:YES];
            // See if it turned on
            if (device.proximityMonitoringEnabled == YES) {
                // It turned on!  Turn it off
                [device setProximityMonitoringEnabled:NO];
                // It works
                ProximitySensor = true;
            } else {
                // Didn't turn on, no good
                ProximitySensor = false;
            }
        } else {
            // Sensor is already on
            ProximitySensor = true;
        }
        
        // Return on or off
        return ProximitySensor;
    } else {
        // Doesn't respond to selector
        return false;
    }
}

+ (BOOL)debuggerAttached {
    @try {
        // Set up the variables
        size_t size = sizeof(struct kinfo_proc); struct kinfo_proc info;
        int ret = 0, name[4];
        memset(&info, 0, sizeof(struct kinfo_proc));
        
        // Get the process information
        name[0] = CTL_KERN;
        name[1] = KERN_PROC;
        name[2] = KERN_PROC_PID; name[3] = getpid();
        
        // Check to make sure the variables are correct
        if (ret == (sysctl(name, 4, &info, &size, NULL, 0))) {
            // Sysctl() failed
            // Return the output of sysctl
            return ret;
        }
        
        // Return whether or not we're being debugged
        return (info.kp_proc.p_flag & P_TRACED) ? 1 : 0;
    }
    @catch (NSException *exception) {
        // Error
        return false;
    }
}



+ (NSString *)deviceID {
    
    if ([self readDeviceID] == nil) {
        [self storeDeviceID];
    }
    
    return [self readDeviceID];
}


+ (NSString *)readDeviceID {
    
    NSString * uid = [HSKeyChain load:KEY_DEVICEID];
    return uid;
}


+ (void)storeDeviceID{
    NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [HSKeyChain save:KEY_DEVICEID data:UUID];
}

+ (void)deleteDeviceID {
    [HSKeyChain delete:KEY_DEVICEID];
}



+ (BOOL)isPad {
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}

+ (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}



@end
