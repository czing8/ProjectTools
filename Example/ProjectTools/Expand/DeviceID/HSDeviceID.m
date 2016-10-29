//
//  HSDeviceID.m
//  TestPro
//
//  Created by Vols on 16/3/17.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "HSDeviceID.h"
#import "HSKeyChain.h"
#import <UIKit/UIKit.h>


static NSString * const KEY_DEVICEID    = @"com.haierSmart.app.deviceid";


@implementation HSDeviceID

+ (NSString *)deviceID {

    if ([self readDeviceID] == nil) {  [self storeDeviceID]; }
    
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


@end
