//
//  APPHelper.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "APPHelper.h"

@implementation APPHelper


+ (NSString *)appShortVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString *)appName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)versionCode {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"VersionCode"];
}

+ (NSString *)appCurrentOSVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)deviceId
{
    
    //    return [PAAccount shareInstance].accountContext.deviceId;
    return nil;
}


@end

