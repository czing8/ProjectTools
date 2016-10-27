//
//  HSDeviceID.h
//  TestPro
//
//  Created by Vols on 16/3/17.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSDeviceID : NSObject


/**
 *  获取设备的唯一标示(获取vender，存到keychain里，只要不刷机，就不会变)
 */
+ (NSString *)deviceID;


/**
 *  删除设备的唯一标示
 */
+ (void)deleteDeviceID;

@end
